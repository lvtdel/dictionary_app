import 'package:directory_app/core/locator/locator.dart';
import 'package:directory_app/core/usecase/usecase.dart';
import 'package:directory_app/domain/entities/Translation.dart';
import 'package:directory_app/domain/entities/Translation.dart';
import 'package:directory_app/domain/repositories/translation_repository.dart';

class SaveTranslationUseCase
    implements UseCase<int, Translation> {

  @override
  Future<int> call({Translation? params}) {
    return sl<TranslationRepository>().saveTranslation(params!);
    throw UnimplementedError();
  }
}
