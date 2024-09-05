import 'package:flutter/material.dart';

class CustomPopupMenu extends StatelessWidget {
  final List<PopupMenuEntry<String>> menuItems;
  final void Function(String) onSelected;
  final Offset offset;
  // final Duration animationDuration;

  const CustomPopupMenu({
    Key? key,
    required this.menuItems,
    required this.onSelected,
    this.offset = Offset.zero,
    // this.animationDuration = const Duration(milliseconds: 100),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: offset,
      itemBuilder: (context) => menuItems,
      onSelected: onSelected,
      // animationDuration: animationDuration,
    );
  }
}
