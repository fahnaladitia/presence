import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/utils/depencency.dart';
import 'firebase_options.dart';
import 'app/app.dart';

void main() async {
  DenpendencyCreator.init();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(App());
}
