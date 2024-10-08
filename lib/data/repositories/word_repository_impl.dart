import 'package:dio/dio.dart';
import 'package:directory_app/core/locator/locator.dart';
import 'package:directory_app/data/exceptions/network_exception.dart';
import 'package:directory_app/data/local/data_sources/sql_lite/database.dart';
import 'package:directory_app/data/local/models/TranslationModel.dart';
import 'package:directory_app/data/remote/data_sources/service/search_api_service.dart';
import 'package:directory_app/domain/entities/Translation.dart';
import 'package:directory_app/domain/repositories/translation_repository.dart';

class WordRepositoryImpl extends TranslationRepository {
  RestClient _restClient;
  AppDatabase _appDatabase;

  WordRepositoryImpl(this._restClient, this._appDatabase); // @override
  // Future<List<String>> find(String word) async {
  //   List<String> resultList = ["hello", "hi", "haha"];
  //   // TODO: implement find
  //
  //   await Future.delayed(const Duration(seconds: 1), () {
  //   });
  //   return resultList;
  // }

  @override
  Future<List<Translation>> find(String word) async {
    try {
      var searchRes = await _restClient.getSearch(word: word);

      return searchRes.suggestions!.map((item) {
        var word = item.select;
        var translated = item.data?.split('p>')[1].replaceAll('</', '');
        return Translation(word: word ?? "", translated: translated ?? "");
      }).toList();
    } on DioException {
      throw NetworkException("No internet connection or server error!");
    }
    // print(searchRes.toJson());
    // TODO: Cần check null
  }

  @override
  Future<List<Translation>> getSavedTranslations() async {
    List<TranslationModel> translationModelList = await _appDatabase
        .translationDao.findAll();

    return translationModelList.map((translationModel) =>
        translationModel.toEntity()).toList();
    throw UnimplementedError();
  }

  @override
  Future<void> removeTranslation(int id) {
    return _appDatabase.translationDao.removeTranslationModel(id);
    throw UnimplementedError();
  }

  @override
  Future<int> saveTranslation(Translation translation) {
    return _appDatabase.translationDao.insertTranslationModel(
        TranslationModel.fromEntity(translation));
    throw UnimplementedError();
  }
}
