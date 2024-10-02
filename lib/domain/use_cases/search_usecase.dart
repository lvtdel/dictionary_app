import 'package:directory_app/core/locator/locator.dart';
import 'package:directory_app/core/usecase/usecase.dart';
import 'package:directory_app/domain/repositories/word_repository.dart';

class SearchUseCase implements UseCase<List<String>, String> {
  @override
  Future<List<String>> call({String? params}) {
    return sl<WordRepository>().find(params!);
    throw UnimplementedError();
  }

}