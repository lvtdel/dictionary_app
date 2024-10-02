import 'package:directory_app/core/locator/locator.dart';
import 'package:directory_app/data/remote/data_sources/service/search_api_service.dart';
import 'package:directory_app/domain/repositories/word_repository.dart';

class WordRepositoryImpl extends WordRepository {
  // @override
  // Future<List<String>> find(String word) async {
  //   List<String> resultList = ["hello", "hi", "haha"];
  //   // TODO: implement find
  //
  //   await Future.delayed(const Duration(seconds: 1), () {
  //   });
  //   return resultList;
  // }

  @override
  Future<List<String>> find(String word) async {
    var searchRes = await sl<RestClient>().getSearch(word: word);

    print(searchRes.toJson());
    return searchRes.suggestions!.map((item) {
      var translation = item.data?.split('p>')[1].replaceAll('</', '');
      return "${item.select!} - ${translation!}";
    }).toList();

    // TODO: Cần check null
  }
}
