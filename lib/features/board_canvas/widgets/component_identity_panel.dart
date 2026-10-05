import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/board_canvas_palette.dart';
import '../../components/services/v2_add_component_writer.dart';
import '../../components/services/v2_edit_component_writer.dart';
import '../../../shared/models/known_facts.dart';
import '../../../shared/models/project_state.dart';
import '../../../shared/session/project_session.dart';

/// Create/edit workflow state owned for the lifetime of one Board Canvas screen.
class ComponentIdentityHolder extends ChangeNotifier {
  bool _disposed = false;
  String _rightPanelCreateComponentId = '';
  String _rightPanelCreateComponentLabel = '';
  String? _rightPanelCreateComponentKind;
  bool _rightPanelCreateComponentInFlight = false;
  String? _rightPanelCreateComponentStatusMessage;
  String? _rightPanelCreateComponentErrorMessage;
  String? _rightPanelMetadataEditComponentId;
  String _rightPanelMetadataEditLabel = '';
  String _rightPanelMetadataEditKind = 'unknown';
  bool _rightPanelMetadataEditInFlight = false;
  String? _rightPanelMetadataEditStatusMessage;
  String? _rightPanelMetadataEditErrorMessage;
  String? _rightPanelMetadataEditLastSuccessfulFormKey;

  void _update(VoidCallback action) {
    if (_disposed) {
      return;
    }
    action();
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  String? _rightPanelCreateComponentBlockReason(ProjectState projectState) {
    if (_rightPanelCreateComponentId.trim().isEmpty) {
      return 'Sisesta komponendi ID enne loomist.';
    }
    if (_rightPanelCreateComponentLabel.trim().isEmpty) {
      return 'Sisesta komponendi nimi enne loomist.';
    }
    if (_rightPanelCreateComponentKind == null ||
        _rightPanelCreateComponentKind!.trim().isEmpty) {
      return 'Vali komponendi liik enne loomist.';
    }
    final projectDirectory = projectState.projectDirectory;
    if (projectDirectory == null || projectDirectory.trim().isEmpty) {
      return 'Komponendi loomiseks ava projekt kohalikust kaustast.';
    }
    return null;
  }

  Future<void> _confirmRightPanelComponentCreation({
    required ProjectState projectState,
    required WidgetRef ref,
  }) async {
    if (_disposed || _rightPanelCreateComponentInFlight) {
      return;
    }

    final blockReason = _rightPanelCreateComponentBlockReason(projectState);
    if (blockReason != null) {
      _update(() {
        _rightPanelCreateComponentStatusMessage = null;
        _rightPanelCreateComponentErrorMessage = blockReason;
      });
      return;
    }

    final componentId = _rightPanelCreateComponentId.trim();
    final request = V2AddComponentRequest(
      componentId: componentId,
      label: _rightPanelCreateComponentLabel.trim(),
      componentKind: _rightPanelCreateComponentKind!.trim(),
      clientOperationId: _componentCreationClientOperationIdFor(componentId),
    );

    _update(() {
      _rightPanelCreateComponentInFlight = true;
      _rightPanelCreateComponentStatusMessage =
          'Salvestan komponendi identiteeti...';
      _rightPanelCreateComponentErrorMessage = null;
    });

    try {
      final projectSession = ref.read(projectStateProvider.notifier);
      final generation = projectSession.generation;
      final writer = ref.read(v2AddComponentWriterProvider);
      final result = await writer.addComponent(
        projectState: projectState,
        request: request,
      );
      projectSession.applyCanonicalEvent(
        result.event,
        generation: generation,
      );
      if (_disposed) {
        return;
      }
      _update(() {
        _rightPanelCreateComponentStatusMessage = result.appended
            ? 'Komponent loodud. Projektsioon vajab värskendamist.'
            : 'Komponent oli juba salvestatud. Projektsioon vajab värskendamist.';
        _rightPanelCreateComponentErrorMessage = null;
      });
    } on V2AddComponentException catch (error) {
      if (_disposed) {
        return;
      }
      _update(() {
        _rightPanelCreateComponentStatusMessage = null;
        _rightPanelCreateComponentErrorMessage =
            _componentCreationFailureMessage(error);
      });
    } catch (error) {
      if (_disposed) {
        return;
      }
      _update(() {
        _rightPanelCreateComponentStatusMessage = null;
        _rightPanelCreateComponentErrorMessage =
            'Komponendi loomine ebaõnnestus: $error';
      });
    } finally {
      if (!_disposed) {
        _update(() {
          _rightPanelCreateComponentInFlight = false;
        });
      }
    }
  }

  String _componentCreationClientOperationIdFor(String componentId) {
    final safeComponentId = componentId
        .trim()
        .replaceAll(RegExp(r'[^A-Za-z0-9_]+'), '_')
        .replaceAll(RegExp(r'_+'), '_');
    final timestamp = DateTime.now().toUtc().microsecondsSinceEpoch;
    return 'op_board_canvas_component_created_${safeComponentId}_$timestamp';
  }

  String _componentCreationFailureMessage(V2AddComponentException error) {
    switch (error.kind) {
      case V2AddComponentFailureKind.noProjectDirectory:
        return 'Komponendi loomiseks ava projekt kohalikust kaustast.';
      case V2AddComponentFailureKind.invalidProjectDirectory:
        return 'Projektikaust ei sobi komponendi loomiseks.';
      case V2AddComponentFailureKind.pythonUnavailable:
        return 'Komponendi kirjutaja pole saadaval.';
      case V2AddComponentFailureKind.lockConflict:
        return 'Komponendi kirjutaja on hetkel hõivatud.';
      case V2AddComponentFailureKind.validation:
        if (error.message.toLowerCase().contains(
              'duplicate v2 component_id',
            )) {
          return 'Komponendi ID on juba kasutusel. Vali uus Koht / ID.';
        }
        return 'Komponenti ei loodud: sisestus ei läbinud valideerimist.';
      case V2AddComponentFailureKind.append:
        return 'Komponendi loomine ebaõnnestus: ${error.message}';
    }
  }

  // Build-time reseeding stays silent; the panel is already rebuilding.
  void _seedRightPanelMetadataEditDraft(ComponentFact? component) {
    final componentId = component?.componentId;
    if (_rightPanelMetadataEditComponentId == componentId) {
      return;
    }
    _rightPanelMetadataEditComponentId = componentId;
    _rightPanelMetadataEditLabel =
        component == null ? '' : _componentMetadataEditBaselineLabel(component);
    _rightPanelMetadataEditKind = _canonicalRightPanelComponentKind(
      component?.type,
    );
    _rightPanelMetadataEditStatusMessage = null;
    _rightPanelMetadataEditErrorMessage = null;
    _rightPanelMetadataEditLastSuccessfulFormKey = null;
  }

  String _componentMetadataEditBaselineLabel(ComponentFact component) {
    final designator = component.designator?.trim();
    if (designator != null && designator.isNotEmpty) {
      return designator;
    }
    return component.componentId;
  }

  String _componentMetadataEditDisplayLabel(ComponentFact component) {
    final label = _componentMetadataEditBaselineLabel(component);
    if (label == component.componentId) {
      return component.componentId;
    }
    return '$label (${component.componentId})';
  }

  String _canonicalRightPanelComponentKind(String? rawValue) {
    final value = rawValue?.trim().toLowerCase() ?? '';
    if (_RightPanelComponentCreationSection._componentKinds.contains(value)) {
      return value;
    }
    return 'unknown';
  }

  List<V2ComponentChange> _rightPanelMetadataEditChanges(
    ComponentFact component,
  ) {
    final changes = <V2ComponentChange>[];
    final oldLabel = _componentMetadataEditBaselineLabel(component);
    final newLabel = _rightPanelMetadataEditLabel.trim();
    if (newLabel != oldLabel) {
      changes.add(
        V2ComponentChange(
          field: 'label',
          oldValueObserved: oldLabel,
          newValue: newLabel,
          changeKind: oldLabel.isEmpty ? 'set' : 'replace',
        ),
      );
    }

    final oldKind = _canonicalRightPanelComponentKind(component.type);
    final newKind = _canonicalRightPanelComponentKind(
      _rightPanelMetadataEditKind,
    );
    if (newKind != oldKind) {
      changes.add(
        V2ComponentChange(
          field: 'component_kind',
          oldValueObserved: oldKind,
          newValue: newKind,
          changeKind: oldKind == 'unknown' ? 'set' : 'replace',
        ),
      );
    }
    return changes;
  }

  String? _rightPanelMetadataEditBlockReason(
    ProjectState projectState,
    ComponentFact? component,
  ) {
    if (component == null) {
      if (_rightPanelCreateComponentStatusMessage?.startsWith(
            'Komponent loodud.',
          ) ??
          false) {
        return 'Komponent loodi. Värskenda projektsioon või vali olemasolev komponent enne metadata muutmist.';
      }
      return 'Vali plaadil olemasolev komponent. Mustandit ei saa siin muuta.';
    }
    if (_rightPanelMetadataEditLabel.trim().isEmpty) {
      return 'Sisesta komponendi nimi enne salvestamist.';
    }
    if (_rightPanelMetadataEditChanges(component).isEmpty) {
      return 'Muuda nime või liiki enne salvestamist.';
    }
    final formKey = _rightPanelMetadataEditFormKey(component);
    if (_rightPanelMetadataEditLastSuccessfulFormKey == formKey) {
      return 'Komponendi andmed on salvestatud. Projektsioon vajab värskendamist.';
    }
    final projectDirectory = projectState.projectDirectory;
    if (projectDirectory == null || projectDirectory.trim().isEmpty) {
      return 'Muudatuste salvestamiseks ava projekt kohalikust kaustast.';
    }
    return null;
  }

  Future<void> _confirmRightPanelMetadataEdit({
    required ProjectState projectState,
    required WidgetRef ref,
    required ComponentFact component,
  }) async {
    if (_disposed || _rightPanelMetadataEditInFlight) {
      return;
    }

    final blockReason = _rightPanelMetadataEditBlockReason(
      projectState,
      component,
    );
    if (blockReason != null) {
      _update(() {
        _rightPanelMetadataEditStatusMessage = null;
        _rightPanelMetadataEditErrorMessage = blockReason;
      });
      return;
    }

    final request = V2EditComponentRequest(
      componentId: component.componentId,
      changes: _rightPanelMetadataEditChanges(component),
      editReason: 'board_canvas_right_panel_metadata_edit',
      clientOperationId: _metadataEditClientOperationIdFor(
        component.componentId,
      ),
    );
    final formKey = _rightPanelMetadataEditFormKey(component);

    _update(() {
      _rightPanelMetadataEditInFlight = true;
      _rightPanelMetadataEditStatusMessage = 'Salvestan komponendi andmeid...';
      _rightPanelMetadataEditErrorMessage = null;
    });

    try {
      final projectSession = ref.read(projectStateProvider.notifier);
      final generation = projectSession.generation;
      final writer = ref.read(v2EditComponentWriterProvider);
      final result = await writer.editComponent(
        projectState: projectState,
        request: request,
      );
      projectSession.applyCanonicalEvent(
        result.event,
        generation: generation,
      );
      if (_disposed) {
        return;
      }
      _update(() {
        _rightPanelMetadataEditStatusMessage = result.appended
            ? 'Komponendi andmed salvestatud. Projektsioon vajab värskendamist.'
            : 'Komponendi andmed olid juba salvestatud. Projektsioon vajab värskendamist.';
        _rightPanelMetadataEditErrorMessage = null;
        _rightPanelMetadataEditLastSuccessfulFormKey = formKey;
      });
    } on V2EditComponentException catch (error) {
      if (_disposed) {
        return;
      }
      _update(() {
        _rightPanelMetadataEditStatusMessage = null;
        _rightPanelMetadataEditErrorMessage =
            _componentMetadataEditFailureMessage(error);
      });
    } catch (error) {
      if (_disposed) {
        return;
      }
      _update(() {
        _rightPanelMetadataEditStatusMessage = null;
        _rightPanelMetadataEditErrorMessage =
            'Komponendi andmete muutmine ebaõnnestus: $error';
      });
    } finally {
      if (!_disposed) {
        _update(() {
          _rightPanelMetadataEditInFlight = false;
        });
      }
    }
  }

  String _rightPanelMetadataEditFormKey(ComponentFact component) {
    final label = _rightPanelMetadataEditLabel.trim();
    final kind = _canonicalRightPanelComponentKind(_rightPanelMetadataEditKind);
    return '${component.componentId}|$label|$kind';
  }

  String _metadataEditClientOperationIdFor(String componentId) {
    final safeComponentId = componentId
        .trim()
        .replaceAll(RegExp(r'[^A-Za-z0-9_]+'), '_')
        .replaceAll(RegExp(r'_+'), '_');
    final timestamp = DateTime.now().toUtc().microsecondsSinceEpoch;
    return 'op_board_canvas_component_updated_${safeComponentId}_$timestamp';
  }

  String _componentMetadataEditFailureMessage(
    V2EditComponentException error,
  ) {
    switch (error.kind) {
      case V2EditComponentFailureKind.noProjectDirectory:
        return 'Muudatuste salvestamiseks ava projekt kohalikust kaustast.';
      case V2EditComponentFailureKind.invalidProjectDirectory:
        return 'Projektikaust ei sobi komponendi muutmiseks.';
      case V2EditComponentFailureKind.pythonUnavailable:
        return 'Komponendi muutmise kirjutaja pole saadaval.';
      case V2EditComponentFailureKind.lockConflict:
        return 'Komponendi muutmise kirjutaja on hetkel hõivatud.';
      case V2EditComponentFailureKind.unknownComponent:
        return 'Vali plaadil olemasolev komponent. Mustandit ei saa siin muuta.';
      case V2EditComponentFailureKind.validation:
        return 'Komponendi andmeid ei salvestatud: sisestus ei läbinud valideerimist.';
      case V2EditComponentFailureKind.append:
        return 'Komponendi andmete salvestamine ebaõnnestus: ${error.message}';
    }
  }
}

class ComponentIdentityPanel extends ConsumerWidget {
  const ComponentIdentityPanel({
    super.key,
    required this.projectState,
    required this.metadataEditComponent,
    required this.holder,
    required this.placementSectionBuilder,
  });

  final ProjectState projectState;
  final ComponentFact? metadataEditComponent;
  final ComponentIdentityHolder holder;
  final List<Widget> Function(BuildContext context) placementSectionBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final component = metadataEditComponent;
    holder._seedRightPanelMetadataEditDraft(component);
    return ListenableBuilder(
      listenable: holder,
      builder: (context, _) {
        final createBlockReason =
            holder._rightPanelCreateComponentBlockReason(projectState);
        final editBlockReason =
            holder._rightPanelMetadataEditBlockReason(projectState, component);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            _RightPanelComponentCreationSection(
              componentId: holder._rightPanelCreateComponentId,
              onComponentIdChanged: (value) {
                holder._update(() {
                  holder._rightPanelCreateComponentId = value;
                  holder._rightPanelCreateComponentStatusMessage = null;
                  holder._rightPanelCreateComponentErrorMessage = null;
                });
              },
              label: holder._rightPanelCreateComponentLabel,
              onLabelChanged: (value) {
                holder._update(() {
                  holder._rightPanelCreateComponentLabel = value;
                  holder._rightPanelCreateComponentStatusMessage = null;
                  holder._rightPanelCreateComponentErrorMessage = null;
                });
              },
              componentKind: holder._rightPanelCreateComponentKind,
              onComponentKindChanged: (value) {
                holder._update(() {
                  holder._rightPanelCreateComponentKind = value;
                  holder._rightPanelCreateComponentStatusMessage = null;
                  holder._rightPanelCreateComponentErrorMessage = null;
                });
              },
              blockReason: createBlockReason,
              statusMessage: holder._rightPanelCreateComponentStatusMessage,
              errorMessage: holder._rightPanelCreateComponentErrorMessage,
              inFlight: holder._rightPanelCreateComponentInFlight,
              onCreateComponent: createBlockReason == null &&
                      !holder._rightPanelCreateComponentInFlight
                  ? () => holder._confirmRightPanelComponentCreation(
                        projectState: projectState,
                        ref: ref,
                      )
                  : null,
            ),
            ...placementSectionBuilder(context),
            _RightPanelMetadataEditSection(
              selectedComponentLabel: component == null
                  ? null
                  : holder._componentMetadataEditDisplayLabel(component),
              label: holder._rightPanelMetadataEditLabel,
              onLabelChanged: (value) {
                holder._update(() {
                  holder._rightPanelMetadataEditLabel = value;
                  holder._rightPanelMetadataEditStatusMessage = null;
                  holder._rightPanelMetadataEditErrorMessage = null;
                  holder._rightPanelMetadataEditLastSuccessfulFormKey = null;
                });
              },
              componentKind: holder._rightPanelMetadataEditKind,
              onComponentKindChanged: (value) {
                holder._update(() {
                  holder._rightPanelMetadataEditKind =
                      holder._canonicalRightPanelComponentKind(value);
                  holder._rightPanelMetadataEditStatusMessage = null;
                  holder._rightPanelMetadataEditErrorMessage = null;
                  holder._rightPanelMetadataEditLastSuccessfulFormKey = null;
                });
              },
              blockReason: editBlockReason,
              statusMessage: holder._rightPanelMetadataEditStatusMessage,
              errorMessage: holder._rightPanelMetadataEditErrorMessage,
              inFlight: holder._rightPanelMetadataEditInFlight,
              onSave: component != null &&
                      editBlockReason == null &&
                      !holder._rightPanelMetadataEditInFlight
                  ? () => holder._confirmRightPanelMetadataEdit(
                        projectState: projectState,
                        component: component,
                        ref: ref,
                      )
                  : null,
            ),
          ],
        );
      },
    );
  }
}

class _RightPanelComponentCreationSection extends StatelessWidget {
  const _RightPanelComponentCreationSection({
    required this.componentId,
    required this.onComponentIdChanged,
    required this.label,
    required this.onLabelChanged,
    required this.componentKind,
    required this.onComponentKindChanged,
    required this.blockReason,
    required this.statusMessage,
    required this.errorMessage,
    required this.inFlight,
    required this.onCreateComponent,
  });

  static const List<String> _componentKinds = <String>[
    'unknown',
    'passive',
    'ic',
    'connector',
    'regulator',
  ];
  static const Map<String, String> _componentKindLabels = <String, String>{
    'unknown': 'Generic / unclassified',
    'passive': 'Resistor / capacitor / diode / passive',
    'ic': 'IC dual-side / quad-side / dense grid',
    'connector': 'Connector / header',
    'regulator': 'Regulator / relay / module',
  };

  final String componentId;
  final ValueChanged<String> onComponentIdChanged;
  final String label;
  final ValueChanged<String> onLabelChanged;
  final String? componentKind;
  final ValueChanged<String?> onComponentKindChanged;
  final String? blockReason;
  final String? statusMessage;
  final String? errorMessage;
  final bool inFlight;
  final VoidCallback? onCreateComponent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      key: const Key('board_canvas_create_component_section'),
      decoration: BoxDecoration(
        color: BoardCanvasPalette.tile,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: BoardCanvasPalette.rule),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Loo komponent',
              key: const Key('board_canvas_create_component_title'),
              style: theme.textTheme.titleSmall?.copyWith(
                color: BoardCanvasPalette.navy,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'Sündmus: component_created',
              key: const Key('board_canvas_create_component_event_type'),
              style: theme.textTheme.labelSmall?.copyWith(
                color: BoardCanvasPalette.signal,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Loob komponendi identiteedi projekti faktidesse. Ei paiguta komponenti plaadile ega loo kontakte, võrke või mõõtmisi.',
              key: const Key('board_canvas_create_component_boundary_copy'),
              style: theme.textTheme.labelSmall?.copyWith(
                color: BoardCanvasPalette.muted,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              key: const Key('board_canvas_create_component_id_input'),
              initialValue: componentId,
              decoration: _compactInputDecoration(
                theme: theme,
                labelText: 'Koht / ID',
                hintText: 'nt R102',
              ),
              onChanged: onComponentIdChanged,
              style: theme.textTheme.bodySmall?.copyWith(
                color: BoardCanvasPalette.navy,
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              key: const Key('board_canvas_create_component_label_input'),
              initialValue: label,
              decoration: _compactInputDecoration(
                theme: theme,
                labelText: 'Nimi',
                hintText: 'nt Pull-up resistor',
              ),
              onChanged: onLabelChanged,
              style: theme.textTheme.bodySmall?.copyWith(
                color: BoardCanvasPalette.navy,
              ),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              key: const Key('board_canvas_create_component_kind_dropdown'),
              initialValue: componentKind,
              isExpanded: true,
              dropdownColor: BoardCanvasPalette.paper,
              decoration: _compactInputDecoration(
                theme: theme,
                labelText: 'Liik',
                hintText: 'Vali liik',
              ),
              iconEnabledColor: BoardCanvasPalette.signal,
              style: theme.textTheme.bodySmall?.copyWith(
                color: BoardCanvasPalette.navy,
              ),
              items: _componentKinds
                  .map(
                    (kind) => DropdownMenuItem<String>(
                      value: kind,
                      child: Text(
                        _componentKindLabels[kind] ?? kind,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(growable: false),
              selectedItemBuilder: (context) => _componentKinds
                  .map(
                    (kind) => Text(
                      _componentKindLabels[kind] ?? kind,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: BoardCanvasPalette.navy,
                      ),
                    ),
                  )
                  .toList(growable: false),
              onChanged: inFlight ? null : onComponentKindChanged,
            ),
            const SizedBox(height: 8),
            if (blockReason != null)
              Text(
                blockReason!,
                key: const Key('board_canvas_create_component_guard'),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: const Color(0xFFF6C453),
                  fontWeight: FontWeight.w700,
                ),
              ),
            if (errorMessage != null)
              Text(
                errorMessage!,
                key: const Key('board_canvas_create_component_error'),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: const Color(0xFFEAA6A6),
                  fontWeight: FontWeight.w700,
                ),
              ),
            if (statusMessage != null)
              Text(
                statusMessage!,
                key: const Key('board_canvas_create_component_status'),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: BoardCanvasPalette.signal,
                  fontWeight: FontWeight.w800,
                ),
              ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: _AddComponentDraftChipButton(
                key: const Key('board_canvas_create_component_save'),
                label: inFlight ? 'Salvestan...' : 'Loo komponent',
                onPressed: onCreateComponent,
                minWidth: 132,
                minHeight: 38,
                foregroundColor: BoardCanvasPalette.signal,
                backgroundColor: BoardCanvasPalette.signalTint,
                borderColor: BoardCanvasPalette.signal.withValues(alpha: 0.7),
                disabledForegroundColor: BoardCanvasPalette.muted,
                disabledBackgroundColor: BoardCanvasPalette.paper,
                disabledBorderColor: BoardCanvasPalette.ruleStrong,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static InputDecoration _compactInputDecoration({
    required ThemeData theme,
    required String labelText,
    required String hintText,
  }) {
    return InputDecoration(
      isDense: true,
      labelText: labelText,
      hintText: hintText,
      labelStyle: theme.textTheme.labelSmall?.copyWith(
        color: BoardCanvasPalette.muted,
      ),
      hintStyle: theme.textTheme.bodySmall?.copyWith(
        color: BoardCanvasPalette.dim,
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: BoardCanvasPalette.rule),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: BoardCanvasPalette.signal),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 7,
      ),
    );
  }
}

class _RightPanelMetadataEditSection extends StatelessWidget {
  const _RightPanelMetadataEditSection({
    required this.selectedComponentLabel,
    required this.label,
    required this.onLabelChanged,
    required this.componentKind,
    required this.onComponentKindChanged,
    required this.blockReason,
    required this.statusMessage,
    required this.errorMessage,
    required this.inFlight,
    required this.onSave,
  });

  final String? selectedComponentLabel;
  final String label;
  final ValueChanged<String> onLabelChanged;
  final String componentKind;
  final ValueChanged<String?> onComponentKindChanged;
  final String? blockReason;
  final String? statusMessage;
  final String? errorMessage;
  final bool inFlight;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasSelectedComponent = selectedComponentLabel != null;
    return DecoratedBox(
      key: const Key('board_canvas_metadata_edit_section'),
      decoration: BoxDecoration(
        color: BoardCanvasPalette.tile,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: BoardCanvasPalette.rule),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Muuda andmeid',
              key: const Key('board_canvas_metadata_edit_title'),
              style: theme.textTheme.titleSmall?.copyWith(
                color: BoardCanvasPalette.navy,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'Sündmus: component_updated',
              key: const Key('board_canvas_metadata_edit_event_type'),
              style: theme.textTheme.labelSmall?.copyWith(
                color: BoardCanvasPalette.signal,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Muudab ainult valitud olemasoleva komponendi nime või liiki. Ei loo identiteeti, paigutust, kontakte, võrke ega mõõtmisi.',
              key: const Key('board_canvas_metadata_edit_boundary_copy'),
              style: theme.textTheme.labelSmall?.copyWith(
                color: BoardCanvasPalette.muted,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              hasSelectedComponent
                  ? 'Metaandmete komponent: $selectedComponentLabel'
                  : 'Metaandmete komponent: puudub',
              key: const Key('board_canvas_metadata_edit_selected_component'),
              style: theme.textTheme.labelSmall?.copyWith(
                color: hasSelectedComponent
                    ? BoardCanvasPalette.navy
                    : BoardCanvasPalette.dim,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            KeyedSubtree(
              key: const Key('board_canvas_metadata_edit_label_input'),
              child: TextFormField(
                key: ValueKey(
                  'board_canvas_metadata_edit_label_input_${selectedComponentLabel ?? 'none'}',
                ),
                initialValue: label,
                enabled: hasSelectedComponent && !inFlight,
                decoration:
                    _RightPanelComponentCreationSection._compactInputDecoration(
                  theme: theme,
                  labelText: 'Nimi',
                  hintText: 'nt R101',
                ),
                onChanged: onLabelChanged,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: BoardCanvasPalette.navy,
                ),
              ),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              key: const Key('board_canvas_metadata_edit_kind_dropdown'),
              initialValue: _RightPanelComponentCreationSection._componentKinds
                      .contains(componentKind)
                  ? componentKind
                  : 'unknown',
              isExpanded: true,
              dropdownColor: BoardCanvasPalette.paper,
              decoration:
                  _RightPanelComponentCreationSection._compactInputDecoration(
                theme: theme,
                labelText: 'Liik',
                hintText: 'Vali liik',
              ),
              iconEnabledColor: BoardCanvasPalette.signal,
              style: theme.textTheme.bodySmall?.copyWith(
                color: BoardCanvasPalette.navy,
              ),
              items: _RightPanelComponentCreationSection._componentKinds
                  .map(
                    (kind) => DropdownMenuItem<String>(
                      value: kind,
                      child: Text(
                        _RightPanelComponentCreationSection
                                ._componentKindLabels[kind] ??
                            kind,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(growable: false),
              selectedItemBuilder: (context) =>
                  _RightPanelComponentCreationSection._componentKinds
                      .map(
                        (kind) => Text(
                          _RightPanelComponentCreationSection
                                  ._componentKindLabels[kind] ??
                              kind,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: BoardCanvasPalette.navy,
                          ),
                        ),
                      )
                      .toList(growable: false),
              onChanged: hasSelectedComponent && !inFlight
                  ? onComponentKindChanged
                  : null,
            ),
            const SizedBox(height: 8),
            if (blockReason != null)
              Text(
                blockReason!,
                key: const Key('board_canvas_metadata_edit_guard'),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: const Color(0xFFF6C453),
                  fontWeight: FontWeight.w700,
                ),
              ),
            if (errorMessage != null)
              Text(
                errorMessage!,
                key: const Key('board_canvas_metadata_edit_error'),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: const Color(0xFFEAA6A6),
                  fontWeight: FontWeight.w700,
                ),
              ),
            if (statusMessage != null)
              Text(
                statusMessage!,
                key: const Key('board_canvas_metadata_edit_status'),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: BoardCanvasPalette.signal,
                  fontWeight: FontWeight.w800,
                ),
              ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: _AddComponentDraftChipButton(
                key: const Key('board_canvas_metadata_edit_save'),
                label: inFlight ? 'Salvestan...' : 'Salvesta muudatused',
                onPressed: onSave,
                minWidth: 158,
                minHeight: 38,
                foregroundColor: const Color(0xFFF6C453),
                backgroundColor: const Color(0xFF33270F),
                borderColor: const Color(0xFFF6C453).withValues(alpha: 0.7),
                disabledForegroundColor: BoardCanvasPalette.muted,
                disabledBackgroundColor: BoardCanvasPalette.paper,
                disabledBorderColor: BoardCanvasPalette.ruleStrong,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddComponentDraftChipButton extends StatelessWidget {
  const _AddComponentDraftChipButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.foregroundColor,
    this.backgroundColor,
    this.borderColor,
    this.disabledForegroundColor,
    this.disabledBackgroundColor,
    this.disabledBorderColor,
    this.minWidth = 0,
    this.minHeight = 28,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? disabledForegroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledBorderColor;
  final double minWidth;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        minimumSize: Size(minWidth, minHeight),
        maximumSize: Size(math.max(minWidth, 120), minHeight),
        foregroundColor: foregroundColor ?? BoardCanvasPalette.navy,
        backgroundColor: backgroundColor ?? Colors.transparent,
        disabledForegroundColor:
            disabledForegroundColor ?? BoardCanvasPalette.dim,
        disabledBackgroundColor: disabledBackgroundColor ?? Colors.transparent,
        side: BorderSide(
          color: onPressed == null
              ? disabledBorderColor ?? BoardCanvasPalette.rule
              : borderColor ?? BoardCanvasPalette.ruleStrong,
        ),
        textStyle: theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      child: Text(label),
    );
  }
}
