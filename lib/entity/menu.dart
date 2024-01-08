import 'package:flutter/cupertino.dart';

class MenuItemModel{
  MenuItemModel({this.icon, this.title, this.right, this.onTap});

  final IconData? icon;

  final String? title;

  final IconData? right;

  final Function()? onTap;
}