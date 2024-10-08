import 'package:directory_app/core/locator/locator.dart';
import 'package:directory_app/core/routering/go_router.dart';
import 'package:directory_app/presentation/search/bloc/search_bloc.dart';
import 'package:directory_app/presentation/search/pages/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependence();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

