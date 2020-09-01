import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p3_guide/src/service_locator.dart';
import 'package:p3_guide/src/ui/app.dart';

main() async {
  setUpServiceLocator();

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(Persona3App());
  });

  // runApp(Persona3App());
}
