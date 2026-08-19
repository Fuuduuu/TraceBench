import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app.dart';

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
  static const _wideBreakpoint = 1228.0;
  static const _navigationWidth = 244.0;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final activeDestination = activeWorkbenchDestination(location);
    final beginnerMode = ref.watch(beginnerModeProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= _wideBreakpoint;
        return Scaffold(
          key: const Key('workbench-shell'),
          backgroundColor: WorkbenchShellColors.background,
          appBar: AppBar(
            key: const Key('workbench-shell-app-bar'),
            automaticallyImplyLeading: false,
            backgroundColor: WorkbenchShellColors.panel,
            foregroundColor: WorkbenchShellColors.text,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.black,
            leading: isWide
                ? null
                : Builder(
                    builder: (drawerContext) => IconButton(
                      key: const Key('workbench-compact-menu-button'),
                      tooltip: 'Ava projekti navigatsioon',
                      onPressed: () => Scaffold.of(drawerContext).openDrawer(),
                      icon: const Icon(Icons.menu),
                    ),
                  ),
            title: const Text('BenchBeep Workbench'),
            actions: [
              IconButton(
                key: const Key('workbench-home-button'),
                tooltip: 'BenchBeep Home',
                onPressed: () => context.go('/'),
                icon: const Icon(Icons.home_outlined),
              ),
              Semantics(
                label: 'Beginner mode',
                button: true,
                toggled: beginnerMode,
                child: IconButton(
                  key: const Key('workbench-beginner-mode-button'),
                  tooltip: beginnerMode
                      ? 'Lülita beginner mode välja'
                      : 'Lülita beginner mode sisse',
                  onPressed: () {
                    ref.read(beginnerModeProvider.notifier).state =
                        !beginnerMode;
                  },
                  icon: Icon(
                    beginnerMode
                        ? Icons.school_outlined
                        : Icons.engineering_outlined,
                  ),
                ),
              ),
            ],
            bottom: _WorkbenchBreadcrumb(activeDestination: activeDestination),
          ),
          drawer: isWide
              ? null
              : Drawer(
                  key: const Key('workbench-compact-drawer'),
                  backgroundColor: WorkbenchShellColors.panel,
                  child: SafeArea(
                    child: _WorkbenchNavigation(
                      key: const Key('workbench-compact-navigation'),
                      activeDestination: activeDestination,
                      closeDrawerOnNavigate: true,
                    ),
                  ),
                ),
          body: ColoredBox(
            color: WorkbenchShellColors.background,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isWide)
                  SizedBox(
                    width: _navigationWidth,
                    child: _WorkbenchNavigation(
                      key: const Key('workbench-wide-navigation'),
                      activeDestination: activeDestination,
                      closeDrawerOnNavigate: false,
                    ),
                  ),
                Expanded(child: widget.child),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _WorkbenchBreadcrumb extends StatelessWidget
    implements PreferredSizeWidget {
  const _WorkbenchBreadcrumb({required this.activeDestination});

  final WorkbenchDestination activeDestination;

  @override
  Size get preferredSize => const Size.fromHeight(38);

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
          color: WorkbenchShellColors.text,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
        );
    final activeStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
          color: WorkbenchShellColors.muted,
          letterSpacing: 0.4,
        );

    return DecoratedBox(
      key: const Key('workbench-breadcrumb'),
      decoration: const BoxDecoration(
        color: WorkbenchShellColors.tile,
        border: Border(
          top: BorderSide(color: WorkbenchShellColors.rule),
        ),
      ),
      child: SizedBox(
        height: preferredSize.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text('BenchBeep', style: labelStyle),
              const _BreadcrumbSeparator(),
              Text('Töölaud', style: labelStyle),
              const _BreadcrumbSeparator(),
              Text(activeDestination.label, style: activeStyle),
            ],
          ),
        ),
      ),
    );
  }
}

class _BreadcrumbSeparator extends StatelessWidget {
  const _BreadcrumbSeparator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Icon(
        Icons.chevron_right,
        size: 16,
        color: WorkbenchShellColors.dim,
      ),
    );
  }
}

class _WorkbenchNavigation extends StatelessWidget {
  const _WorkbenchNavigation({
    required this.activeDestination,
    required this.closeDrawerOnNavigate,
    super.key,
  });

  final WorkbenchDestination activeDestination;
  final bool closeDrawerOnNavigate;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: WorkbenchShellColors.panel,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 16),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
            child: Text(
              'Projekt',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: WorkbenchShellColors.text,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          for (final destination in workbenchDestinations)
            _WorkbenchDestinationTile(
              destination: destination,
              selected: destination.location == activeDestination.location,
              closeDrawerOnNavigate: closeDrawerOnNavigate,
            ),
        ],
      ),
    );
  }
}

class _WorkbenchDestinationTile extends StatelessWidget {
  const _WorkbenchDestinationTile({
    required this.destination,
    required this.selected,
    required this.closeDrawerOnNavigate,
  });

  final WorkbenchDestination destination;
  final bool selected;
  final bool closeDrawerOnNavigate;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      label: selected
          ? '${destination.label}, aktiivne sihtkoht'
          : destination.label,
      child: ListTile(
        key: Key('workbench-destination-${destination.id}'),
        dense: true,
        selected: selected,
        selectedColor: WorkbenchShellColors.text,
        selectedTileColor: WorkbenchShellColors.greenTint,
        iconColor: WorkbenchShellColors.muted,
        textColor: WorkbenchShellColors.muted,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: selected ? WorkbenchShellColors.green : Colors.transparent,
          ),
        ),
        leading: Icon(destination.icon, size: 20),
        title: Text(destination.label),
        onTap: () {
          if (closeDrawerOnNavigate) {
            Navigator.of(context).pop();
          }
          context.go(destination.location);
        },
      ),
    );
  }
}
