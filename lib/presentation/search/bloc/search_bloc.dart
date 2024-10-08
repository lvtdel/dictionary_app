import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:directory_app/core/locator/locator.dart';
import 'package:directory_app/data/exceptions/network_exception.dart';
import 'package:directory_app/data/repositories/word_repository_impl.dart';
import 'package:directory_app/domain/entities/Translation.dart';
import 'package:directory_app/domain/use_cases/get_saved_translations_usecase.dart';
import 'package:directory_app/domain/use_cases/remove_translation_usecase.dart';
import 'package:directory_app/domain/use_cases/save_translation_usecase.dart';
import 'package:directory_app/domain/use_cases/search_usecase.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  WordSearchChangeEvent? lastWordSearchEvent;
  SearchEvent? lastEvent;

  List<Translation>? translationListRecycle;

  SearchBloc() : super(SearchInitial()) {
    on<WordSearchChangeEvent>(_onWordChangeEvent);
    on<SaveWordSearchEvent>(_onSaveWordSearch);
    on<LoadFromDBSearchEvent>(_onLoadFromDB);
    on<DeleteWordSearchEvent>(_onDeleteWord);

    on<SearchEvent>((event, emit) {
      lastEvent = event;
    });
  }

  _onWordChangeEvent(event, emit) async {
    lastWordSearchEvent = event;
    String word = event.word;

    print("Word change: $word");

    if (word.isEmpty) {
      print("Word empty");

      // emit(SearchInitial());
      add(LoadFromDBSearchEvent());
    } else {
      try {
        var currentWordSearchEvent = event;
        emit(SearchLoading());
        var translationList = await _fetch(word);

        // Xử lý khi người dùng đã thay đổi từ khoá tìm kiếm
        // mà data cũ trả về thì không chấp nhận
        if (currentWordSearchEvent == lastWordSearchEvent) {
          emit(SearchSuccess(translationList));
        }
      } on NetworkException catch (e) {
        emit(SearchFail(e.mess));
      }
    }
  }

  _cancelFetch() {
    // _fetchCompleter?.complete();
  }

  _onSaveWordSearch(SaveWordSearchEvent event, emit) async {
    int id = await sl<SaveTranslationUseCase>().call(params: event.translation);
    var trans = event.translation;
    var newTrans = Translation(
        id: id, word: trans.word, translated: trans.translated);
    translationListRecycle?.add(newTrans);
  }

  _onLoadFromDB(LoadFromDBSearchEvent event, emit) async {
    if (translationListRecycle != null) {
      emit(SearchLoadedFromDB(List.from(translationListRecycle!)));
      return;
    }

    emit(SearchLoading());
    var translationList = await sl<GetSavedTranslationsUseCase>().call();
    translationListRecycle = translationList;

    if (lastEvent is LoadFromDBSearchEvent) {
      emit(SearchLoadedFromDB(translationList));
    }
  }

  _onDeleteWord(DeleteWordSearchEvent event, emit) async {
    sl<RemoveTranslationUseCase>().call(params: event.id);
    translationListRecycle!.removeWhere(
          (element) => element.id == event.id,
    );

    add(LoadFromDBSearchEvent());
  }

  Future<List<Translation>> _fetch(String word) {
    return sl<SearchUseCase>().call(params: word);
  }

  @override
  void onChange(Change<SearchState> change) {
    // TODO: implement onChange
    super.onChange(change);

    print(change);
  }
}
