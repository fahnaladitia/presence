import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Presence",
            // onGenerateRoute: Modular.,
            initialRoute: buildInitialRoute(snapshot.data),
            
            getPages: AppPages.routes,
          );
        }
      },
    );
  }

  String buildInitialRoute(User? user) {
    if (user != null) {
      return AppPages.INITIAL;
    } else {
      return Routes.LOGIN;
    }
  }
}
