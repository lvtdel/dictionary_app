import 'package:directory_app/domain/entities/Translation.dart';

abstract class TranslationRepository {
  // API
  Future<List<Translation>> find(String word);

  // Local database
  Future<List<Translation>> getSavedTranslations();
  Future<int> saveTranslation(Translation translation);
  Future<void> removeTranslation(int id);
}
