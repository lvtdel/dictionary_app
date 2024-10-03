import 'package:directory_app/core/locator/locator.dart';
import 'package:directory_app/core/usecase/usecase.dart';
import 'package:directory_app/domain/entities/Translation.dart';
import 'package:directory_app/domain/entities/Translation.dart';
import 'package:directory_app/domain/repositories/translation_repository.dart';

class SearchUseCase implements UseCase<List<Translation>, String> {
  @override
  Future<List<Translation>> call({String? params}) {
    return sl<TranslationRepository>().find(params!);
    throw UnimplementedError();
  }

}