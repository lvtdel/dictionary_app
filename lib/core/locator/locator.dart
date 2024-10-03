import 'package:dio/dio.dart';
import 'package:directory_app/data/remote/data_sources/service/search_api_service.dart';
import 'package:directory_app/data/repositories/word_repository_impl.dart';
import 'package:directory_app/domain/repositories/translation_repository.dart';
import 'package:directory_app/domain/use_cases/search_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

initializeDependence() async {
  // Service
  sl.registerSingleton<RestClient>(
      RestClient(Dio(BaseOptions(contentType: "application/json"))));

  // Repository
  sl.registerSingleton<TranslationRepository>(WordRepositoryImpl());

  // UseCase
  sl.registerSingleton<SearchUseCase>(SearchUseCase());
}
