import 'package:dio/dio.dart';
import 'package:directory_app/common/constants/host.dart';
import 'package:directory_app/data/remote/models/SearchResponse.dart';
import 'package:retrofit/retrofit.dart';
part 'search_api_service.g.dart';


@RestApi(baseUrl: HostConstants.labanHost)
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("ajax/autocomplete")
  Future<SearchResponse> getSearch({
    @Query("type") String type = "1",
    @Query("site") String site = "dictionary",
    @Query("query") required String word
  });
}