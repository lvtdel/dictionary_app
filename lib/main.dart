import 'package:directory_app/core/locator/locator.dart';
import 'package:directory_app/presentation/search/bloc/search_bloc.dart';
import 'package:directory_app/presentation/search/pages/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  await initializeDependence();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => SearchBloc(),
        child: SearchScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

