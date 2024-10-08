import 'package:directory_app/domain/entities/Translation.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "translation")
class TranslationModel {
  @PrimaryKey()
  int? id;
  String word;
  String translated;

  TranslationModel(this.id, this.word, this.translated);

  Map<String, dynamic> toJson() => {
        'id': id,
        'word': word,
        'translated': translated,
      };

  factory TranslationModel.fromEntity(Translation translation) {
    return TranslationModel(null, translation.word, translation.translated);
  }

  Translation toEntity() {
    return Translation(id: id, word: word, translated: translated);
  }
}
