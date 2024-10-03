import 'package:directory_app/domain/entities/Translation.dart';

abstract class TranslationRepository {
  Future<List<Translation>> find(String word);
}
