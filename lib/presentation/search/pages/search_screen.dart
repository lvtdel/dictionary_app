import 'dart:async';

import 'package:directory_app/presentation/search/bloc/search_bloc.dart';
import 'package:directory_app/presentation/search/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final TextEditingController _textEditingController =
  TextEditingController();

  Timer? _timer;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Search'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          _textFieldSearch(context),
          const SizedBox(
            height: 40,
          ),
          _resultList(context)
        ],
      ),
    );
  }

  _onTextChange(BuildContext context, String value) {

    _timer?.cancel();

    _timer = Timer(const Duration(milliseconds: 300), () {
    context.read<SearchBloc>().add(WordSearchChangeEvent(value));
    });
  }

  _textFieldSearch(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: TextField(
          onChanged: (value) {
            _onTextChange(context, value);
          },
          controller: _textEditingController,
        ),
      ),
    );
  }

  _resultList(context) {
    return SizedBox(
      height: 400,
      width: 300,
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchInitial) {
            return const SizedBox();
          }

          if (state is SearchLoading) {
            return const CircularProgressIndicator();
          }

          if (state is SearchSuccess) {
            var wordList = state.result;
            if (wordList.isEmpty) {
              wordList.add("Word is not found");
            }

            return ListView.builder(
                itemCount: wordList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(wordList[index]),
                  );
                });
          }

          return const SizedBox();
        },
      ),
    );
  }
}
