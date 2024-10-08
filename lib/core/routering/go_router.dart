import 'package:directory_app/presentation/search/bloc/search_bloc.dart';
import 'package:directory_app/presentation/search/pages/search_screen.dart';
import 'package:directory_app/presentation/splash/splash_screen.dart';
import 'package:directory_app/presentation/word_detail/pages/word_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(initialLocation: "/splash", routes: [
  GoRoute(path: "/splash", builder: (context, state) => const SplashScreen()),
  GoRoute(path: "/", pageBuilder: (context, state) => _buildSearchScreen()),
  GoRoute(path: "/details/:word", builder: (context, state) {
    return WordDetailScreen(word: state.pathParameters['word']!);
  })
]);

_buildSearchScreen() {
  return CustomTransitionPage(
      child: BlocProvider(
        create: (context) =>
        SearchBloc()..add(LoadFromDBSearchEvent()),
        child: SearchScreen(),
      ),
      transitionDuration: const Duration(milliseconds: 700),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {

        const begin = Offset(1.0, 0.0);
        const end = Offset(0.0, 0.0);
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
                position: offsetAnimation,
                child: child,
        );
      });
}
