import 'package:flutter/material.dart';
import 'package:p3_guide/src/service_locator.dart';
import 'package:p3_guide/src/ui/app.dart';

main() async {
  setUpServiceLocator();
  runApp(Persona3App());
}
