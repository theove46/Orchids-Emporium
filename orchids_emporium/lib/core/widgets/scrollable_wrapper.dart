import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orchids_emporium/core/theme/palette.dart';

class ScrollableWrapper extends StatelessWidget {
  const ScrollableWrapper({
    Key? key,
    required this.child,
    this.appBar,
    this.alignment,
    this.dismissKeyboard = false,
    this.bottomSheet,
    this.endDrawer,
    this.extendBody = true,
    this.bottomNavigationBar,
  }) : super(key: key);

  final Widget child;
  final AppBar? appBar;
  final bool? dismissKeyboard;
  final AlignmentGeometry? alignment;
  final Widget? bottomSheet;
  final Widget? endDrawer;
  final bool extendBody;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Palette.secondary,
        appBar: appBar,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Align(
                alignment: alignment ?? Alignment.bottomCenter,
                child: SingleChildScrollView(
                  keyboardDismissBehavior: dismissKeyboard == true
                      ? ScrollViewKeyboardDismissBehavior.onDrag
                      : ScrollViewKeyboardDismissBehavior.manual,
                  padding: _buildPadding,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                      minHeight: constraints.maxHeight -
                          (appBar?.preferredSize.height ?? 0) +
                          topPadding +
                          bottomPadding,
                    ),
                    child: IntrinsicHeight(
                      child: child,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: bottomNavigationBar,
        bottomSheet: bottomSheet,
        endDrawer: endDrawer,
      ),
    );
  }

  static double topPadding = 16.h;
  static double bottomPadding = 16.h;
  static double leftPadding = 16.h;
  static double rightPadding = 16.h;

  EdgeInsets get _buildPadding {
    return EdgeInsets.only(
      top: topPadding,
      bottom: bottomPadding,
      left: leftPadding,
      right: rightPadding,
    );
  }
}
