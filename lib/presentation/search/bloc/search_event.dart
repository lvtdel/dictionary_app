part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class WordSearchChangeEvent extends SearchEvent {
  WordSearchChangeEvent(this.word);

  final String word;
}