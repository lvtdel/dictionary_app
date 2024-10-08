import 'package:directory_app/data/local/models/TranslationModel.dart';
import 'package:floor/floor.dart';
@dao
abstract class TranslationDao {
  @Query("SELECT * FROM translation")
  Future<List<TranslationModel>> findAll();

  @Query("SELECT * FROM translation WHERE word LIKE :word")
  Future<List<TranslationModel>> findByWord(String word);

  @insert
  Future<int> insertTranslationModel(TranslationModel translationModel);

  @Query("DELETE FROM translation WHERE id = :id")
  Future<void> removeTranslationModel(int id);
}
