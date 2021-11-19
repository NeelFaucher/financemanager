import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//key for the navigation bar
class NavBarKey {
  NavBarKey._();
  static final GlobalKey _globalKey = GlobalKey();
  static GlobalKey getKey() => _globalKey;
}
