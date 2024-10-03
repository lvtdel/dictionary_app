import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:directory_app/core/locator/locator.dart';
import 'package:directory_app/data/exceptions/network_exception.dart';
import 'package:directory_app/data/repositories/word_repository_impl.dart';
import 'package:directory_app/domain/entities/Translation.dart';
import 'package:directory_app/domain/use_cases/search_usecase.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchEvent? lastWordSearchEvent;

  SearchBloc() : super(SearchInitial()) {
    on<WordSearchChangeEvent>(_onWordChangeEvent);
  }

  _onWordChangeEvent(event, emit) async {
    lastWordSearchEvent = event;
    String word = event.word;

    print("Word change: $word");

    if (word.isEmpty) {
      print("Word empty");

      emit(SearchInitial());
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
      }
      on NetworkException catch (e) {
        emit(SearchFail(e.mess));
      }
    }
  }

  _cancelFetch() {
    // _fetchCompleter?.complete();
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
