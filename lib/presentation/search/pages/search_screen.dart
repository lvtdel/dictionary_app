import 'dart:async';

import 'package:directory_app/presentation/search/bloc/search_bloc.dart';
import 'package:directory_app/presentation/search/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final TextEditingController _textEditingController = TextEditingController();

  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Search'),
      body: SingleChildScrollView(
        child: Column(
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
          decoration: const InputDecoration(
              label: Icon(Icons.search),
              hintText: "Hello",
              border: OutlineInputBorder()),
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
            return const Center(
              child: SizedBox(
                  height: 100, width: 100, child: CircularProgressIndicator()),
            );
          }

          if (state is SearchSuccess) {
            var wordList = state.result;
            if (wordList.isEmpty) {
              wordList.add("Word is not found");
            }

            return ListView.separated(
              itemCount: wordList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(wordList[index]),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 1,
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
