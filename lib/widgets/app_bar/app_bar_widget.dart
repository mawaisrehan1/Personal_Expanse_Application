import 'package:flutter/material.dart';

import '../../values/colors.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBarWidget({Key? key, required this.title, this.icon, required this.color}) : super(key: key);
  final String title;
  final Widget? icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: colorWhite,
        ),
      ),
      centerTitle: true,
      backgroundColor: color,
      elevation: 0.0,
      actions: [
        IconButton(
          onPressed: (){},
          icon: const Icon(Icons.add),
        )
      ],
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(56);
}
