import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'wizard_compact_tokens.dart';

enum WizardCompactActionTone {
  neutral,
  accent,
  destructive,
}

class WizardCompactIconAction extends StatelessWidget {
  const WizardCompactIconAction({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.tone = WizardCompactActionTone.neutral,
    this.selected = false,
    this.focusNode,
    this.buttonKey,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final WizardCompactActionTone tone;
  final bool selected;
  final FocusNode? focusNode;
  final Key? buttonKey;

  Key? get _effectiveButtonKey {
    if (buttonKey != null) {
      return buttonKey;
    }
    final ownerKey = key;
    if (ownerKey is ValueKey<String>) {
      return ValueKey<String>('${ownerKey.value}-button');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    final destructive = tone == WizardCompactActionTone.destructive;
    final foreground = switch (tone) {
      WizardCompactActionTone.neutral => WizardCompactTokens.cream,
      WizardCompactActionTone.accent => WizardCompactTokens.goldBright,
      WizardCompactActionTone.destructive => WizardCompactTokens.warningBright,
    };
    final border = switch (tone) {
      WizardCompactActionTone.neutral => WizardCompactTokens.edge,
      WizardCompactActionTone.accent => WizardCompactTokens.edgeGold,
      WizardCompactActionTone.destructive => WizardCompactTokens.warning,
    };
    final semanticsLabel = destructive ? '$label, hävitav toiming' : label;

    return SizedBox.square(
      dimension: WizardCompactTokens.minimumTapTarget,
      child: Tooltip(
        message: label,
        excludeFromSemantics: true,
        child: Semantics(
          label: semanticsLabel,
          button: true,
          enabled: enabled,
          selected: selected,
          excludeSemantics: true,
          child: FocusableActionDetector(
            key: _effectiveButtonKey,
            focusNode: focusNode,
            enabled: enabled,
            mouseCursor:
                enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
            shortcuts: const <ShortcutActivator, Intent>{
              SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
              SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
            },
            actions: <Type, Action<Intent>>{
              ActivateIntent: CallbackAction<ActivateIntent>(
                onInvoke: (_) {
                  onPressed?.call();
                  return null;
                },
              ),
            },
            child: Center(
              child: Material(
                color: selected
                    ? WizardCompactTokens.activeFill
                    : WizardCompactTokens.panelRaised,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: enabled ? border : WizardCompactTokens.edge,
                  ),
                  borderRadius: BorderRadius.circular(
                    WizardCompactTokens.radiusControl,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  canRequestFocus: false,
                  excludeFromSemantics: true,
                  onTap: onPressed,
                  child: SizedBox.square(
                    dimension: WizardCompactTokens.visibleIconControl,
                    child: Icon(
                      icon,
                      size: 18,
                      color: enabled ? foreground : WizardCompactTokens.faint,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WizardCompactToolbar extends StatelessWidget {
  const WizardCompactToolbar({
    super.key,
    required this.label,
    required this.children,
  });

  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: label,
      child: DecoratedBox(
        decoration: WizardCompactTokens.panelDecoration(
          color: WizardCompactTokens.panelRaised,
        ),
        child: Padding(
          padding: const EdgeInsets.all(WizardCompactTokens.space8),
          child: Wrap(
            spacing: WizardCompactTokens.space4,
            runSpacing: WizardCompactTokens.space4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: children,
          ),
        ),
      ),
    );
  }
}

class WizardCompactControlGroup extends StatelessWidget {
  const WizardCompactControlGroup({
    super.key,
    required this.label,
    required this.children,
  });

  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: label,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: WizardCompactTokens.space4,
        ),
        child: Wrap(
          spacing: WizardCompactTokens.space8,
          runSpacing: WizardCompactTokens.space8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: children,
        ),
      ),
    );
  }
}

class WizardCompactFileChip extends StatelessWidget {
  const WizardCompactFileChip({
    super.key,
    required this.path,
    this.semanticsPrefix = 'Valitud foto',
  });

  final String path;
  final String semanticsPrefix;

  String get _fileName {
    final normalized = path.replaceAll('\\', '/');
    final segments = normalized.split('/');
    return segments.isEmpty || segments.last.isEmpty ? path : segments.last;
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: path,
      excludeFromSemantics: true,
      child: Semantics(
        container: true,
        label: '$semanticsPrefix: $path',
        excludeSemantics: true,
        child: DecoratedBox(
          decoration: WizardCompactTokens.panelDecoration(
            color: WizardCompactTokens.inset,
            borderColor: WizardCompactTokens.edgeGold,
            radius: WizardCompactTokens.radiusControl,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: WizardCompactTokens.space12,
              vertical: WizardCompactTokens.space8,
            ),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.photo_outlined,
                  size: 18,
                  color: WizardCompactTokens.goldDim,
                ),
                const SizedBox(width: WizardCompactTokens.space8),
                Expanded(
                  child: Text(
                    _fileName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: WizardCompactTokens.bodyStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WizardCompactFieldSection extends StatelessWidget {
  const WizardCompactFieldSection({
    super.key,
    required this.label,
    required this.child,
    this.requiredField = false,
    this.statusLabel,
  });

  final String label;
  final Widget child;
  final bool requiredField;
  final String? statusLabel;

  @override
  Widget build(BuildContext context) {
    final status = statusLabel ?? (requiredField ? '* nõutav' : 'valikuline');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ExcludeSemantics(
                child: Text(
                  label,
                  style: WizardCompactTokens.labelStyle(),
                ),
              ),
            ),
            const SizedBox(width: WizardCompactTokens.space8),
            ExcludeSemantics(
              child: Text(
                status,
                style: WizardCompactTokens.labelStyle(
                  color: requiredField
                      ? WizardCompactTokens.gold
                      : WizardCompactTokens.muted,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: WizardCompactTokens.space8),
        child,
      ],
    );
  }
}

class WizardCompactDisclosure extends StatelessWidget {
  const WizardCompactDisclosure({
    super.key,
    required this.label,
    required this.expanded,
    required this.onChanged,
    required this.child,
  });

  final String label;
  final bool expanded;
  final ValueChanged<bool>? onChanged;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final enabled = onChanged != null;
    final duration = WizardCompactTokens.motionDuration(
      disableAnimations: MediaQuery.of(context).disableAnimations,
    );
    return Semantics(
      container: true,
      button: true,
      enabled: enabled,
      expanded: expanded,
      label: label,
      child: DecoratedBox(
        decoration: WizardCompactTokens.panelDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InkWell(
              onTap: enabled ? () => onChanged!(!expanded) : null,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: WizardCompactTokens.minimumTapTarget,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: WizardCompactTokens.space12,
                    vertical: WizardCompactTokens.space8,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          label,
                          style: WizardCompactTokens.labelStyle(),
                        ),
                      ),
                      const SizedBox(width: WizardCompactTokens.space8),
                      Icon(
                        expanded ? Icons.expand_less : Icons.expand_more,
                        color: enabled
                            ? WizardCompactTokens.gold
                            : WizardCompactTokens.faint,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (duration == Duration.zero)
              expanded
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(
                        WizardCompactTokens.space12,
                        0,
                        WizardCompactTokens.space12,
                        WizardCompactTokens.space12,
                      ),
                      child: child,
                    )
                  : const SizedBox.shrink()
            else
              ClipRect(
                child: AnimatedSize(
                  duration: duration,
                  curve: WizardCompactTokens.standardCurve,
                  alignment: Alignment.topCenter,
                  child: expanded
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(
                            WizardCompactTokens.space12,
                            0,
                            WizardCompactTokens.space12,
                            WizardCompactTokens.space12,
                          ),
                          child: child,
                        )
                      : const SizedBox.shrink(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class WizardCompactSlider extends StatelessWidget {
  const WizardCompactSlider({
    super.key,
    required this.label,
    required this.valueLabel,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.divisions,
    this.controlKey,
  });

  final String label;
  final String valueLabel;
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final ValueChanged<double>? onChanged;
  final Key? controlKey;

  Key? get _effectiveControlKey {
    if (controlKey != null) {
      return controlKey;
    }
    final ownerKey = key;
    if (ownerKey is ValueKey<String>) {
      return ValueKey<String>('${ownerKey.value}-control');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: label,
      value: valueLabel,
      slider: true,
      enabled: onChanged != null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(label, style: WizardCompactTokens.labelStyle()),
              ),
              const SizedBox(width: WizardCompactTokens.space8),
              Text(
                valueLabel,
                style: WizardCompactTokens.labelStyle(
                  color: WizardCompactTokens.gold,
                ),
              ),
            ],
          ),
          Slider(
            key: _effectiveControlKey,
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            label: valueLabel,
            semanticFormatterCallback: (_) => valueLabel,
            onChanged: onChanged,
            activeColor: WizardCompactTokens.goldBright,
            inactiveColor: WizardCompactTokens.edge,
          ),
        ],
      ),
    );
  }
}

class WizardCompactNumericInput extends StatelessWidget {
  const WizardCompactNumericInput({
    super.key,
    required this.label,
    required this.controller,
    required this.onChanged,
    this.enabled = true,
    this.suffixText,
    this.focusNode,
    this.controlKey,
  });

  final String label;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final String? suffixText;
  final FocusNode? focusNode;
  final Key? controlKey;

  Key? get _effectiveControlKey {
    if (controlKey != null) {
      return controlKey;
    }
    final ownerKey = key;
    if (ownerKey is ValueKey<String>) {
      return ValueKey<String>('${ownerKey.value}-control');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: label,
      textField: true,
      enabled: enabled && onChanged != null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(label, style: WizardCompactTokens.labelStyle()),
          const SizedBox(height: WizardCompactTokens.space8),
          TextField(
            key: _effectiveControlKey,
            controller: controller,
            focusNode: focusNode,
            enabled: enabled,
            onChanged: onChanged,
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            style: WizardCompactTokens.bodyStyle(),
            decoration: WizardCompactTokens.inputDecoration(
              suffixText: suffixText,
            ),
          ),
        ],
      ),
    );
  }
}

class WizardCompactInfoPopover extends StatefulWidget {
  const WizardCompactInfoPopover({
    super.key,
    required this.label,
    required this.child,
    this.triggerKey,
    this.popoverKey,
  });

  final String label;
  final Widget child;
  final Key? triggerKey;
  final Key? popoverKey;

  @override
  State<WizardCompactInfoPopover> createState() =>
      _WizardCompactInfoPopoverState();
}

class _WizardCompactInfoPopoverState extends State<WizardCompactInfoPopover> {
  final FocusNode _triggerFocusNode = FocusNode();
  final FocusNode _popoverFocusNode = FocusNode();
  OverlayEntry? _entry;
  bool _open = false;
  Size _viewport = Size.zero;

  void _toggle() {
    if (_open) {
      _close();
    } else {
      _show();
    }
  }

  void _show() {
    final overlay = Overlay.of(context);
    _viewport = MediaQuery.sizeOf(context);
    setState(() => _open = true);
    final entry = OverlayEntry(builder: _buildOverlay);
    _entry = entry;
    overlay.insert(entry);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_open) {
        _popoverFocusNode.requestFocus();
      }
    });
  }

  void _close() {
    final entry = _entry;
    if (!_open && entry == null) {
      return;
    }
    _entry = null;
    entry?.remove();
    if (mounted) {
      setState(() => _open = false);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _triggerFocusNode.requestFocus();
        }
      });
    }
  }

  Key? get _triggerButtonKey {
    final triggerKey = widget.triggerKey;
    if (triggerKey is ValueKey<String>) {
      return ValueKey<String>('${triggerKey.value}-button');
    }
    return null;
  }

  Widget _buildOverlay(BuildContext context) {
    final overlayViewport = MediaQuery.sizeOf(context);
    final viewport = _viewport.isEmpty ? overlayViewport : _viewport;
    final width = math.max(
      0.0,
      math.min(
        WizardCompactTokens.popoverMaximumWidth,
        viewport.width - WizardCompactTokens.viewportInset * 2,
      ),
    );
    final height = math.max(
      0.0,
      viewport.height - WizardCompactTokens.viewportInset * 2,
    );
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _close,
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Focus(
              focusNode: _popoverFocusNode,
              onKeyEvent: (_, event) {
                if (event is KeyDownEvent &&
                    event.logicalKey == LogicalKeyboardKey.escape) {
                  _close();
                  return KeyEventResult.handled;
                }
                return KeyEventResult.ignored;
              },
              child: SizedBox(
                width: width,
                child: Material(
                  key: widget.popoverKey,
                  color: Colors.transparent,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: height),
                    child: DecoratedBox(
                      decoration: WizardCompactTokens.panelDecoration(
                        color: WizardCompactTokens.panelRaised,
                        borderColor: WizardCompactTokens.edgeGold,
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(
                          WizardCompactTokens.space16,
                        ),
                        child: DefaultTextStyle(
                          style: WizardCompactTokens.bodyStyle(),
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _entry?.remove();
    _triggerFocusNode.dispose();
    _popoverFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WizardCompactIconAction(
      key: widget.triggerKey,
      buttonKey: _triggerButtonKey,
      label: widget.label,
      icon: Icons.info_outline,
      selected: _open,
      focusNode: _triggerFocusNode,
      onPressed: _toggle,
    );
  }
}

class WizardCompactStepHeader extends StatelessWidget {
  const WizardCompactStepHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.description,
    this.requiredField = false,
    this.trailing,
  });

  final String eyebrow;
  final String title;
  final String description;
  final bool requiredField;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: WizardCompactTokens.headerMinimumHeight,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  eyebrow.toUpperCase(),
                  style: WizardCompactTokens.labelStyle(
                    color: WizardCompactTokens.goldDim,
                    fontSize: 10.5,
                  ).copyWith(letterSpacing: 1.2),
                ),
                const SizedBox(height: WizardCompactTokens.space4),
                Wrap(
                  spacing: WizardCompactTokens.space8,
                  runSpacing: WizardCompactTokens.space4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Text(
                      title,
                      style: WizardCompactTokens.bodyStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                    if (requiredField)
                      Text(
                        '* nõutav',
                        style: WizardCompactTokens.labelStyle(
                          color: WizardCompactTokens.gold,
                          fontSize: 11.5,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: WizardCompactTokens.space4),
                Text(
                  description,
                  style: WizardCompactTokens.bodyStyle(
                    color: WizardCompactTokens.muted,
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) ...<Widget>[
            const SizedBox(width: WizardCompactTokens.space8),
            trailing!,
          ],
        ],
      ),
    );
  }
}

class WizardCompactPanel extends StatelessWidget {
  const WizardCompactPanel({
    super.key,
    required this.title,
    required this.child,
    this.actions = const <Widget>[],
  });

  final String title;
  final Widget child;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: WizardCompactTokens.panelDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(WizardCompactTokens.space12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Wrap(
              spacing: WizardCompactTokens.space8,
              runSpacing: WizardCompactTokens.space8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: WizardCompactTokens.labelStyle(
                    color: WizardCompactTokens.gold,
                  ),
                ),
                ...actions,
              ],
            ),
            const SizedBox(height: WizardCompactTokens.space12),
            child,
          ],
        ),
      ),
    );
  }
}

@immutable
class WizardCompactTile<T> {
  const WizardCompactTile({
    required this.value,
    required this.label,
    required this.icon,
    this.key,
    this.semanticsLabel,
  });

  final T value;
  final String label;
  final IconData icon;
  final Key? key;
  final String? semanticsLabel;
}

class WizardCompactTileSelector<T> extends StatelessWidget {
  const WizardCompactTileSelector({
    super.key,
    required this.label,
    required this.tiles,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final List<WizardCompactTile<T>> tiles;
  final T value;
  final ValueChanged<T>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: label,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ExcludeSemantics(
            child: Text(label, style: WizardCompactTokens.labelStyle()),
          ),
          const SizedBox(height: WizardCompactTokens.space8),
          LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth =
                  constraints.maxWidth.isFinite ? constraints.maxWidth : 280.0;
              final tileWidth = math.max(
                WizardCompactTokens.minimumTapTarget,
                (availableWidth - WizardCompactTokens.space8) / 2,
              );
              return Wrap(
                spacing: WizardCompactTokens.space8,
                runSpacing: WizardCompactTokens.space8,
                children: <Widget>[
                  for (final tile in tiles)
                    SizedBox(
                      width: tileWidth,
                      child: Builder(
                        builder: (context) {
                          final selected = tile.value == value;
                          final enabled = onChanged != null;
                          return Semantics(
                            label:
                                tile.semanticsLabel ?? '$label: ${tile.label}',
                            button: true,
                            enabled: enabled,
                            selected: selected,
                            excludeSemantics: true,
                            child: ChoiceChip(
                              key: tile.key,
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(tile.icon, size: 16),
                                  const SizedBox(
                                    width: WizardCompactTokens.space4,
                                  ),
                                  Flexible(child: Text(tile.label)),
                                ],
                              ),
                              selected: selected,
                              onSelected: enabled
                                  ? (_) {
                                      if (!selected) {
                                        onChanged!(tile.value);
                                      }
                                    }
                                  : null,
                              showCheckmark: false,
                              selectedColor: WizardCompactTokens.activeFill,
                              backgroundColor: WizardCompactTokens.inset,
                              side: BorderSide(
                                color: selected
                                    ? WizardCompactTokens.gold
                                    : WizardCompactTokens.edge,
                              ),
                              labelStyle: WizardCompactTokens.labelStyle(
                                color: selected
                                    ? WizardCompactTokens.gold
                                    : WizardCompactTokens.cream,
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class WizardCompactWorkspace extends StatelessWidget {
  const WizardCompactWorkspace({
    super.key,
    required this.stacked,
    required this.workspace,
    required this.inspector,
  });

  final bool stacked;
  final Widget workspace;
  final Widget inspector;

  @override
  Widget build(BuildContext context) {
    if (stacked) {
      return Column(
        key: const ValueKey('wizard-compact-workspace-stacked'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          workspace,
          const SizedBox(height: WizardCompactTokens.space12),
          inspector,
        ],
      );
    }
    return Row(
      key: const ValueKey('wizard-compact-workspace-wide'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: workspace),
        const SizedBox(width: WizardCompactTokens.space16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: inspector,
        ),
      ],
    );
  }
}

class WizardCompactReviewSection extends StatelessWidget {
  const WizardCompactReviewSection({
    super.key,
    required this.title,
    required this.children,
    this.onEdit,
    this.editLabel = 'Muuda',
  });

  final String title;
  final List<Widget> children;
  final VoidCallback? onEdit;
  final String editLabel;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: WizardCompactTokens.panelDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(WizardCompactTokens.space12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    title,
                    style: WizardCompactTokens.labelStyle(
                      color: WizardCompactTokens.gold,
                    ),
                  ),
                ),
                if (onEdit != null)
                  TextButton(
                    onPressed: onEdit,
                    child: Text(editLabel),
                  ),
              ],
            ),
            const SizedBox(height: WizardCompactTokens.space8),
            ...children.expand(
              (child) => <Widget>[
                child,
                const SizedBox(height: WizardCompactTokens.space8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WizardCompactSuccessCard extends StatelessWidget {
  const WizardCompactSuccessCard({
    super.key,
    required this.title,
    required this.message,
    this.details = const <Widget>[],
    this.actions = const <Widget>[],
  });

  final String title;
  final String message;
  final List<Widget> details;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: WizardCompactTokens.panelDecoration(
        borderColor: WizardCompactTokens.success,
        radius: WizardCompactTokens.radiusWindow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(WizardCompactTokens.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Icon(
              Icons.check_circle_outline,
              color: WizardCompactTokens.success,
              size: 34,
            ),
            const SizedBox(height: WizardCompactTokens.space8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: WizardCompactTokens.bodyStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: WizardCompactTokens.space8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: WizardCompactTokens.bodyStyle(
                color: WizardCompactTokens.muted,
              ),
            ),
            if (details.isNotEmpty) ...<Widget>[
              const SizedBox(height: WizardCompactTokens.space16),
              ...details.expand(
                (detail) => <Widget>[
                  detail,
                  const SizedBox(height: WizardCompactTokens.space8),
                ],
              ),
            ],
            if (actions.isNotEmpty) ...<Widget>[
              const SizedBox(height: WizardCompactTokens.space8),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: WizardCompactTokens.space8,
                runSpacing: WizardCompactTokens.space8,
                children: actions,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

enum WizardCompactStepState {
  complete,
  viewed,
  current,
  upcoming,
}

@immutable
class WizardCompactNavigationItem {
  const WizardCompactNavigationItem({
    required this.label,
    required this.detail,
    required this.state,
    this.onPressed,
  });

  final String label;
  final String detail;
  final WizardCompactStepState state;
  final VoidCallback? onPressed;
}

class WizardCompactNavigation extends StatelessWidget {
  const WizardCompactNavigation({
    super.key,
    required this.compact,
    required this.items,
  });

  final bool compact;
  final List<WizardCompactNavigationItem> items;

  Widget _item(WizardCompactNavigationItem item) {
    final current = item.state == WizardCompactStepState.current;
    final stateLabel = switch (item.state) {
      WizardCompactStepState.complete => 'valmis',
      WizardCompactStepState.viewed => 'vaadatud',
      WizardCompactStepState.current => 'praegune samm',
      WizardCompactStepState.upcoming => 'ees',
    };
    final accent = switch (item.state) {
      WizardCompactStepState.complete => WizardCompactTokens.success,
      WizardCompactStepState.current => WizardCompactTokens.gold,
      WizardCompactStepState.viewed => WizardCompactTokens.goldDim,
      WizardCompactStepState.upcoming => WizardCompactTokens.faint,
    };
    return Semantics(
      container: true,
      button: item.onPressed != null,
      enabled: item.onPressed != null,
      selected: current,
      label: '${item.label}, $stateLabel, ${item.detail}',
      excludeSemantics: true,
      child: Material(
        color: current
            ? WizardCompactTokens.activeFill
            : WizardCompactTokens.panel,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: current
                ? WizardCompactTokens.edgeGold
                : WizardCompactTokens.edge,
          ),
          borderRadius: BorderRadius.circular(
            WizardCompactTokens.radiusControl,
          ),
        ),
        child: InkWell(
          onTap: item.onPressed,
          borderRadius: BorderRadius.circular(
            WizardCompactTokens.radiusControl,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: WizardCompactTokens.minimumTapTarget,
              minWidth: 150,
            ),
            child: Padding(
              padding: const EdgeInsets.all(WizardCompactTokens.space8),
              child: Row(
                children: <Widget>[
                  Icon(
                    current ? Icons.radio_button_checked : Icons.circle,
                    size: current ? 17 : 9,
                    color: accent,
                  ),
                  const SizedBox(width: WizardCompactTokens.space8),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.label,
                          style: WizardCompactTokens.labelStyle(
                            color: current
                                ? WizardCompactTokens.gold
                                : WizardCompactTokens.cream,
                            fontSize: 12.5,
                          ),
                        ),
                        const SizedBox(height: WizardCompactTokens.space4),
                        Text(
                          item.detail,
                          style: WizardCompactTokens.bodyStyle(
                            color: accent,
                            fontSize: 10.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (var index = 0; index < items.length; index += 1) ...<Widget>[
              SizedBox(width: 190, child: _item(items[index])),
              if (index < items.length - 1)
                const SizedBox(width: WizardCompactTokens.space8),
            ],
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (var index = 0; index < items.length; index += 1) ...<Widget>[
          _item(items[index]),
          if (index < items.length - 1)
            const SizedBox(height: WizardCompactTokens.space8),
        ],
      ],
    );
  }
}

class WizardCompactShell extends StatelessWidget {
  const WizardCompactShell({
    super.key,
    required this.compact,
    required this.navigation,
    required this.child,
    this.footer,
  });

  final bool compact;
  final Widget navigation;
  final Widget child;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final content = compact
        ? Column(
            key: const ValueKey('wizard-compact-shell-compact'),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              navigation,
              const SizedBox(height: WizardCompactTokens.space12),
              child,
            ],
          )
        : Row(
            key: const ValueKey('wizard-compact-shell-wide'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 224, child: navigation),
              const SizedBox(width: WizardCompactTokens.space16),
              Expanded(child: child),
            ],
          );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        content,
        if (footer != null) ...<Widget>[
          const SizedBox(height: WizardCompactTokens.space12),
          footer!,
        ],
      ],
    );
  }
}

class WizardCompactInlineNotice extends StatelessWidget {
  const WizardCompactInlineNotice({
    super.key,
    required this.message,
    this.icon = Icons.info_outline,
    this.warning = false,
    this.semanticsKey,
  });

  final String message;
  final IconData icon;
  final bool warning;
  final Key? semanticsKey;

  @override
  Widget build(BuildContext context) {
    final accent =
        warning ? WizardCompactTokens.warningBright : WizardCompactTokens.gold;
    return Semantics(
      key: semanticsKey,
      container: true,
      label: message,
      excludeSemantics: true,
      child: DecoratedBox(
        decoration: WizardCompactTokens.panelDecoration(
          color: WizardCompactTokens.activeFill,
          borderColor: warning
              ? WizardCompactTokens.warning
              : WizardCompactTokens.edgeGold,
        ),
        child: Padding(
          padding: const EdgeInsets.all(WizardCompactTokens.space12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(icon, color: accent, size: 20),
              const SizedBox(width: WizardCompactTokens.space8),
              Expanded(
                child: Text(
                  message,
                  style: WizardCompactTokens.bodyStyle(
                    color: WizardCompactTokens.muted,
                    fontSize: 12.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
