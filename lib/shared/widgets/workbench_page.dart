import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Opt-in local presentation under the existing Workbench navigation shell.
/// Builders run below the theme. The caller supplies one bounded scrollable;
/// the frame itself never adds a competing scroll view or domain action.
class WorkbenchPage extends StatelessWidget {
  const WorkbenchPage({
    super.key,
    required this.builder,
    this.statusBuilder,
    this.actions = const [],
    this.isEmpty = false,
    this.emptyBuilder,
    this.maxContentWidth = 1200,
    this.padding = const EdgeInsets.all(16),
  })  : assert(maxContentWidth > 0),
        assert(!isEmpty || emptyBuilder != null);

  final WidgetBuilder builder;
  final WidgetBuilder? statusBuilder;
  final List<Widget> actions;
  final bool isEmpty;
  final WidgetBuilder? emptyBuilder;
  final double maxContentWidth;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: buildWorkbenchTheme(),
      child: Builder(
          builder: (context) => Material(
                color: Theme.of(context).colorScheme.surface,
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxContentWidth),
                      child: Padding(
                        padding: padding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (statusBuilder != null) statusBuilder!(context),
                            if (actions.isNotEmpty) ...[
                              Wrap(
                                  spacing: 8, runSpacing: 8, children: actions),
                              const SizedBox(height: 16),
                            ],
                            Expanded(
                                child: PrimaryScrollController.none(
                              child: isEmpty
                                  ? emptyBuilder!(context)
                                  : builder(context),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
    );
  }
}
