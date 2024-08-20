import 'package:agsant_package/agsant_package.dart';
import 'package:flutter/material.dart';

class AgsPage extends StatelessWidget {
  final Widget child;
  final String title;
  final Color? titleColor;
  final EdgeInsetsGeometry? padding;
  final Widget? button;
  final String? buttonTitle;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? buttonPadding;
  final Color? appBarColor;
  final List<Widget>? actions;
  final IconThemeData? iconTheme;
  final IconThemeData? iconActionsTheme;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? fabLocation;

  const AgsPage({
    super.key,
    required this.title,
    required this.child,
    this.titleColor,
    this.padding,
    this.button,
    this.buttonTitle,
    this.onTap,
    this.buttonPadding,
    this.appBarColor,
    this.actions,
    this.iconActionsTheme,
    this.iconTheme,
    this.floatingActionButton,
    this.fabLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: fabLocation,
      appBar: AppBar(
        iconTheme: iconTheme,
        actionsIconTheme: iconActionsTheme,
        backgroundColor: appBarColor,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: titleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: actions,
      ),
      body: SafeArea(
        child: Padding(
          padding: padding ?? const EdgeInsets.all(0.0),
          child: Column(
            children: [
              Expanded(child: child),
              _getBottomButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getBottomButton() {
    Widget? button = this.button;
    String? title = buttonTitle;
    VoidCallback? onTapButton = onTap;

    if (button == null || title == null || onTapButton == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: buttonPadding ?? const EdgeInsets.all(0),
      child: AgsButton(
        title: title,
        onTap: onTap,
      ),
    );
  }
}
