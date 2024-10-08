part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class WordSearchChangeEvent extends SearchEvent {
  WordSearchChangeEvent(this.word);

  final String word;
}

class SaveWordSearchEvent extends SearchEvent {
  final Translation translation;

  SaveWordSearchEvent(this.translation);
}
class DeleteWordSearchEvent extends SearchEvent {
  final int id;

  DeleteWordSearchEvent(this.id);
}

class LoadFromDBSearchEvent extends SearchEvent {}