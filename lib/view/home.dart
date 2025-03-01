import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:warsha_counter/core/utils/extensions/extensions.dart';
import 'package:warsha_counter/core/utils/themes/colors.dart';

import '../core/utils/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        centerTitle: true,
        backgroundColor: ColorManager.blue,
      ),
      body: Column(
        children: [
          const Spacer(),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                context.pushNamedAndRemoveUntil(
                    RoutesManager.login, (route) => false);
              }).onError((error, stackTrace) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(error.toString()),
                ));
              });
            },
            child: const Text("تسجيل الخروج"),
          )
        ],
      )
          .withSize(width: double.infinity, height: double.infinity)
          .withOnlyPadding(bottom: 50),
    );
  }
}
