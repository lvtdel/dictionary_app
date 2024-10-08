import 'package:dio/dio.dart';
import 'package:directory_app/data/local/data_sources/sql_lite/database.dart';
import 'package:directory_app/data/remote/data_sources/service/search_api_service.dart';
import 'package:directory_app/data/repositories/word_repository_impl.dart';
import 'package:directory_app/domain/repositories/translation_repository.dart';
import 'package:directory_app/domain/use_cases/get_saved_translations_usecase.dart';
import 'package:directory_app/domain/use_cases/get_saved_translations_usecase.dart';
import 'package:directory_app/domain/use_cases/remove_translation_usecase.dart';
import 'package:directory_app/domain/use_cases/remove_translation_usecase.dart';
import 'package:directory_app/domain/use_cases/save_translation_usecase.dart';
import 'package:directory_app/domain/use_cases/search_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

initializeDependence() async {
  // Database
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  // Service
  final resClient = sl.registerSingleton<RestClient>(
      RestClient(Dio(BaseOptions(contentType: "application/json"))));

  // Repository
  sl.registerSingleton<TranslationRepository>(
      WordRepositoryImpl(resClient, database));

  // UseCase
  sl.registerSingleton<SearchUseCase>(SearchUseCase());
  sl.registerSingleton<SaveTranslationUseCase>(SaveTranslationUseCase());
  sl.registerSingleton<RemoveTranslationUseCase>(RemoveTranslationUseCase());
  sl.registerSingleton<GetSavedTranslationsUseCase>(
      GetSavedTranslationsUseCase());
}
