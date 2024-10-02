import 'package:dio/dio.dart';
import 'package:directory_app/data/remote/models/SearchResponse.dart';
import 'package:retrofit/retrofit.dart';
part 'search_api_service.g.dart';


@RestApi(baseUrl: "https://dict.laban.vn/ajax/autocomplete")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("")
  Future<SearchResponse> getSearch({
    @Query("type") String type = "1",
    @Query("site") String site = "dictionary",
    @Query("query") required String word
  });
}