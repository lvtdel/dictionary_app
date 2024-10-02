import 'dart:async';

import 'package:directory_app/core/routering/go_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), () {
      context.go("/");
    });

    return Container(
      alignment: Alignment.center,
       color: Colors.white,
      child: const SizedBox(height: 100, width: 100, child: Card(
        elevation: 15,
          color: Colors.blueAccent,
        child: Icon(Icons.search, color: Colors.white, size: 50,),
      )),
    );
  }
}
