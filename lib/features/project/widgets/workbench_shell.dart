import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/session/beginner_mode_provider.dart';
import '../../../shared/session/project_session.dart';
import '../../../shared/theme/app_theme.dart';

class WorkbenchShellColors {
  const WorkbenchShellColors._();

  static const background = Color(0xFF0A0D11);
  static const panel = Color(0xFF161B22);
  static const panelRaised = Color(0xFF1D252D);
  static const tile = Color(0xFF11161C);
  static const boardBase = Color(0xFF080B0F);
  static const boardSurface = Color(0xFF0F1F18);
  static const rule = Color(0xFF252D37);
  static const ruleStrong = Color(0xFF36404D);
  static const text = Color(0xFFE9EEF4);
  static const muted = Color(0xFFABB7C4);
  static const dim = Color(0xFF7C8A98);
  static const green = Color(0xFF1FA35C);
  static const greenBright = Color(0xFF2BC06F);
  static const greenTint = Color(0x261FA35C);
  static const copper = Color(0xFFD8A24A);
  static const silk = Color(0xFFCDC78A);
}

class WorkbenchDestinationSurface extends StatelessWidget {
  const WorkbenchDestinationSurface({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final baseTheme = Theme.of(context);
    final textTheme = baseTheme.textTheme.apply(
      bodyColor: WorkbenchShellColors.text,
      displayColor: WorkbenchShellColors.text,
    );

    return Theme(
      data: baseTheme.copyWith(
        colorScheme: baseTheme.colorScheme.copyWith(
          primary: WorkbenchShellColors.greenBright,
          onPrimary: WorkbenchShellColors.background,
          surface: WorkbenchShellColors.background,
          onSurface: WorkbenchShellColors.text,
          outline: WorkbenchShellColors.ruleStrong,
        ),
        scaffoldBackgroundColor: WorkbenchShellColors.background,
        canvasColor: WorkbenchShellColors.background,
        dividerColor: WorkbenchShellColors.rule,
        textTheme: textTheme,
        iconTheme: const IconThemeData(color: WorkbenchShellColors.muted),
        listTileTheme: const ListTileThemeData(
          iconColor: WorkbenchShellColors.muted,
          textColor: WorkbenchShellColors.text,
          subtitleTextStyle: TextStyle(color: WorkbenchShellColors.muted),
        ),
        expansionTileTheme: const ExpansionTileThemeData(
          backgroundColor: WorkbenchShellColors.background,
          collapsedBackgroundColor: WorkbenchShellColors.background,
          textColor: WorkbenchShellColors.text,
          collapsedTextColor: WorkbenchShellColors.text,
          iconColor: WorkbenchShellColors.greenBright,
          collapsedIconColor: WorkbenchShellColors.muted,
        ),
      ),
      child: Material(
        key: const Key('workbench-destination-surface'),
        color: WorkbenchShellColors.background,
        child: DefaultTextStyle.merge(
          style: const TextStyle(color: WorkbenchShellColors.text),
          child: IconTheme(
            data: const IconThemeData(color: WorkbenchShellColors.muted),
            child: child,
          ),
        ),
      ),
    );
  }
}

class WorkbenchDestination {
  const WorkbenchDestination({
    required this.id,
    required this.label,
    required this.location,
    required this.icon,
  });

  final String id;
  final String label;
  final String location;
  final IconData icon;
}

const workbenchDestinations = <WorkbenchDestination>[
  WorkbenchDestination(
    id: 'board-canvas',
    label: 'Board Canvas',
    location: '/project',
    icon: Icons.developer_board_outlined,
  ),
  WorkbenchDestination(
    id: 'overview',
    label: 'Project Overview',
    location: '/project/overview',
    icon: Icons.dashboard_outlined,
  ),
  WorkbenchDestination(
    id: 'components',
    label: 'Komponendid',
    location: '/project/components',
    icon: Icons.memory_outlined,
  ),
  WorkbenchDestination(
    id: 'measurements',
    label: 'Mõõtmised',
    location: '/project/measurements',
    icon: Icons.straighten_outlined,
  ),
  WorkbenchDestination(
    id: 'pins',
    label: 'Pinnid',
    location: '/project/pins',
    icon: Icons.push_pin_outlined,
  ),
  WorkbenchDestination(
    id: 'not-populated',
    label: 'Täitamata',
    location: '/project/not-populated',
    icon: Icons.do_not_disturb_alt_outlined,
  ),
  WorkbenchDestination(
    id: 'photos',
    label: 'Foto tõendid',
    location: '/project/photos',
    icon: Icons.photo_camera_back_outlined,
  ),
  WorkbenchDestination(
    id: 'reference-images',
    label: 'Viitepildid',
    location: '/project/reference-images',
    icon: Icons.image_outlined,
  ),
  WorkbenchDestination(
    id: 'graph',
    label: 'Advanced graph',
    location: '/project/graph',
    icon: Icons.account_tree_outlined,
  ),
  WorkbenchDestination(
    id: 'events',
    label: 'Sündmused',
    location: '/project/events',
    icon: Icons.history_outlined,
  ),
  WorkbenchDestination(
    id: 'known-facts',
    label: 'Teadaolevad faktid',
    location: '/project/known-facts',
    icon: Icons.fact_check_outlined,
  ),
  WorkbenchDestination(
    id: 'report',
    label: 'Raport',
    location: '/project/report',
    icon: Icons.description_outlined,
  ),
];

WorkbenchDestination activeWorkbenchDestination(String location) {
  final path = Uri.parse(location).path;
  final activeLocation = switch (path) {
    '/project/components/add' ||
    '/project/components/edit' =>
      '/project/components',
    '/project/measure-sheet' ||
    '/project/measurements/new' =>
      '/project/measurements',
    _ => path,
  };

  return workbenchDestinations.firstWhere(
    (destination) => destination.location == activeLocation,
    orElse: () => workbenchDestinations.first,
  );
}

class WorkbenchShell extends ConsumerStatefulWidget {
  const WorkbenchShell({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  ConsumerState<WorkbenchShell> createState() => _WorkbenchShellState();
}

class _WorkbenchShellState extends ConsumerState<WorkbenchShell> {
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final activeDestination = activeWorkbenchDestination(location);
    final beginnerMode = ref.watch(beginnerModeProvider);
    final manifest = ref.watch(projectStateProvider)?.manifest;
    final projectName = manifest?.projectName?.trim();
    final identity = projectName != null && projectName.isNotEmpty
        ? projectName
        : manifest?.projectId ?? 'Projekt';

    return Scaffold(
      key: const Key('workbench-shell'),
      backgroundColor: WorkbenchColors.shell,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: Theme(
          data: buildWorkbenchTheme(),
          child: AppBar(
            key: const Key('workbench-shell-app-bar'),
            toolbarHeight: 44,
            backgroundColor: WorkbenchColors.paper,
            foregroundColor: WorkbenchColors.navy,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            leadingWidth: 36,
            leading: IconButton(
              key: const Key('workbench-home-button'),
              tooltip: 'BenchBeep Home',
              style: IconButton.styleFrom(
                minimumSize: const Size(32, 32),
                padding: EdgeInsets.zero,
              ),
              iconSize: 20,
              onPressed: () {
                ref.read(projectStateProvider.notifier).closeProject();
                context.go('/');
              },
              icon: const Icon(Icons.home_outlined),
            ),
            titleSpacing: 4,
            title: LayoutBuilder(
              builder: (context, constraints) => Align(
                alignment: Alignment.centerLeft,
                child: _WorkbenchBreadcrumb(
                  activeDestination: activeDestination,
                  identity: identity,
                  showIdentity: constraints.maxWidth >= 500,
                ),
              ),
            ),
            actions: [
              Semantics(
                label: 'Beginner mode',
                button: true,
                toggled: beginnerMode,
                child: Tooltip(
                  message: beginnerMode
                      ? 'Lülita beginner mode välja'
                      : 'Lülita beginner mode sisse',
                  child: TextButton.icon(
                    key: const Key('workbench-beginner-mode-button'),
                    style: TextButton.styleFrom(
                      minimumSize: const Size(0, 32),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      textStyle: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {
                      ref.read(beginnerModeProvider.notifier).state =
                          !beginnerMode;
                    },
                    icon: Icon(
                      beginnerMode
                          ? Icons.school_outlined
                          : Icons.engineering_outlined,
                      size: 16,
                    ),
                    label: Text(beginnerMode ? 'Algaja' : 'Edasijõudnu'),
                  ),
                ),
              ),
              const SizedBox(width: 4),
            ],
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: ColoredBox(
                color: WorkbenchColors.rule,
                child: SizedBox(height: 1, width: double.infinity),
              ),
            ),
          ),
        ),
      ),
      body: ColoredBox(
        color: WorkbenchColors.shell,
        child: SizedBox.expand(child: widget.child),
      ),
    );
  }
}

class _WorkbenchBreadcrumb extends StatelessWidget {
  const _WorkbenchBreadcrumb({
    required this.activeDestination,
    required this.identity,
    required this.showIdentity,
  });

  final WorkbenchDestination activeDestination;
  final String identity;
  final bool showIdentity;

  @override
  Widget build(BuildContext context) {
    return Focus(
      skipTraversal: true,
      canRequestFocus: false,
      child: Builder(builder: (context) {
        final focused = Focus.of(context).hasFocus;
        final labelStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
              color: WorkbenchColors.navy,
              fontWeight: FontWeight.w700,
              decoration:
                  focused ? TextDecoration.underline : TextDecoration.none,
            );
        return PopupMenuButton<String>(
          key: const Key('workbench-project-menu'),
          tooltip:
              'Ava projekti navigatsioon: $identity · ${activeDestination.label}',
          position: PopupMenuPosition.under,
          onSelected: (location) => context.go(location),
          itemBuilder: (_) => [
            for (final destination in workbenchDestinations)
              CheckedPopupMenuItem<String>(
                key: Key('workbench-destination-${destination.id}'),
                value: destination.location,
                checked: destination.location == activeDestination.location,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(destination.icon, size: 18),
                    const SizedBox(width: 8),
                    Flexible(child: Text(destination.label)),
                  ],
                ),
              ),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    focused ? WorkbenchColors.signal : WorkbenchColors.outline,
                width: focused ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              key: const Key('workbench-breadcrumb'),
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showIdentity) ...[
                  Flexible(
                    child: Text(
                      '$identity ·',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: labelStyle?.copyWith(color: WorkbenchColors.muted),
                    ),
                  ),
                  const SizedBox(width: 6),
                ],
                Flexible(
                  child: Text(
                    activeDestination.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: labelStyle,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.expand_more, size: 18),
              ],
            ),
          ),
        );
      }),
    );
  }
}
