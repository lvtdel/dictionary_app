import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:directory_app/core/locator/locator.dart';
import 'package:directory_app/domain/use_cases/search_usecase.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchEvent? lastEvent;

  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {
      lastEvent = event;
    });

    on<WordSearchChangeEvent>(_onWordChangeEvent);
  }

  _onWordChangeEvent(event, emit) async {
    var currentEvent = event;
    String word = event.word;

    print("Word change: $word");

    if (word.isEmpty) {
      print("Word empty");

      emit(SearchInitial());
    } else {
      var wordList = await _fetch(word);

      // Xử lý khi người dùng đã thay đổi từ khoá tìm kiếm
      // mà data cũ trả về thì không chấp nhận
      if (currentEvent == lastEvent) {
        emit(SearchSuccess(wordList));
      }
    }
  }

  _cancelFetch() {
    // _fetchCompleter?.complete();
  }

  _fetch(String word) {
    return sl<SearchUseCase>().call(params: word);
  }

  @override
  void onChange(Change<SearchState> change) {
    // TODO: implement onChange
    super.onChange(change);

    print(change);
  }
}
