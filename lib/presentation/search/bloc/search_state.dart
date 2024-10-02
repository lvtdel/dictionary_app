part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  SearchSuccess(this.result);

  final List<String> result;
}

final class SearchFail extends SearchState {
  SearchFail(this.errorMess);

  final String errorMess;
}
