import 'package:directory_app/core/locator/locator.dart';
import 'package:directory_app/core/usecase/usecase.dart';
import 'package:directory_app/domain/entities/Translation.dart';
import 'package:directory_app/domain/entities/Translation.dart';
import 'package:directory_app/domain/repositories/translation_repository.dart';

class RemoveTranslationUseCase
    implements UseCase<void, int> {
  @override
  Future<void> call({int? params}) {
    return sl<TranslationRepository>().removeTranslation(params!);
    throw UnimplementedError();
  }
}
