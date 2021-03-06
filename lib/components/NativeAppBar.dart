import 'dart:ui' show Size;
import 'package:flutter/material.dart'
    show
        AppBar,
        BackButtonIcon,
        Brightness,
        BuildContext,
        Color,
        IconButton,
        IconThemeData,
        Key,
        // LocalHistoryEntry,
        MaterialLocalizations,
        ModalRoute,
        NavigationToolbar,
        PreferredSizeWidget,
        ShapeBorder,
        StatelessWidget,
        TextTheme,
        Widget,
        Navigator,
        kToolbarHeight;
// import 'package:flutter/services.dart' show SystemNavigator;

import '../setup/router.dart' show Router;

/// NativeAppBar的表现形式和flutter官方基础组件中的AppBar几乎完全一样。
/// NativeAppBar将始终在头部包含一个返回箭头，这个箭头的点击行为在路由栈堆为空的情况下将关闭当前flutter示例，不为空其行为和AppBar保持一致。
/// 该组件适用于混合开发模式（产物集成[ARR]）下的头部导航组件<AppBar>。

class NativeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context; // 路由页面的上下文
  final Key key;
  final Widget leading;
  final bool automaticallyImplyLeading = true;
  final Widget title;
  final List<Widget> actions;
  final Widget flexibleSpace;
  final PreferredSizeWidget bottom;
  final double elevation;
  final ShapeBorder shape;
  final Color backgroundColor;
  final Color backButtonColor;
  final Brightness brightness;
  final IconThemeData iconTheme;
  final IconThemeData actionsIconTheme;
  final TextTheme textTheme;
  final bool primary;
  final bool centerTitle;
  final double titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;

  Widget get customLeading => leading ?? customBackButton(context, backButtonColor: backButtonColor);

  static Widget customBackButton(BuildContext context, {
    Color backButtonColor,
    Widget backButtonIcon = const BackButtonIcon(),
    bool isRequired = false
  }){
    final bool _hasBackButton = !ModalRoute.of(context).canPop /* && ModalRoute.of(context).settings.isInitialRoute */; // 是否展示返回按钮
    final Widget _iconButton = IconButton(
      icon: backButtonIcon,
      color: backButtonColor,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () => _hasBackButton ? Router.navigatorPop() : Navigator.of(context).pop(),
    );

    if (isRequired) return _iconButton;

    return _hasBackButton ? _iconButton : null;
  }

  const NativeAppBar(
    this.context, {
    this.key,
    this.leading,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.shape,
    this.backgroundColor,
    this.backButtonColor,
    this.brightness,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.primary,
    this.centerTitle,
    this.titleSpacing,
    this.toolbarOpacity,
    this.bottomOpacity,
  });

  @override
  Widget build(BuildContext context) => AppBar(
        key: key,
        leading: customLeading,
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: title,
        actions: actions,
        flexibleSpace: flexibleSpace,
        bottom: bottom,
        elevation: elevation,
        shape: shape,
        backgroundColor: backgroundColor,
        brightness: brightness,
        iconTheme: iconTheme,
        actionsIconTheme: actionsIconTheme,
        textTheme: textTheme,
        primary: primary ?? true,
        centerTitle: centerTitle,
        titleSpacing: titleSpacing ?? NavigationToolbar.kMiddleSpacing,
        toolbarOpacity: toolbarOpacity ?? 1.0,
        bottomOpacity: bottomOpacity ?? 1.0,
      );

  @override
  Size get preferredSize => Size.fromHeight(
      kToolbarHeight + (this.bottom?.preferredSize?.height ?? 0.0));
}
