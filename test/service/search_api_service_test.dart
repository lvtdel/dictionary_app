import 'package:dio/dio.dart';
import 'package:directory_app/core/locator/locator.dart';
import 'package:directory_app/data/remote/data_sources/service/search_api_service.dart';
import 'package:directory_app/data/remote/models/SearchResponse.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils/logging_interceptor.dart';

Future<void> main() async {
  initializeDependence();

  final dio = Dio(BaseOptions(contentType: "application/json"));
  dio.interceptors.add(LoggingInterceptor());
  var restClient = RestClient(dio);

  test(
      "get search list, list.suggestions not null, length greater than 0", () async {
    SearchResponse response = await restClient.getSearch(word: "abc");

    print(response.toJson());

    expect(response.suggestions, isNotNull);
    expect(response.suggestions!.length, greaterThan(0));
  });
}