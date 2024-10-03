import 'dart:async';

import 'package:directory_app/common/constants/host.dart';
import 'package:directory_app/core/routering/go_router.dart';
import 'package:directory_app/domain/entities/Translation.dart';
import 'package:directory_app/presentation/search/bloc/search_bloc.dart';
import 'package:directory_app/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _launchBrowser(BuildContext context, String word) async {
    // Mobile sẽ sử dụng link khác, nhưng web laban redirect không đúng
    // Tự redirect bằng tay
    String link = (MediaQuery.of(context).size.width > 600)
        ? "${HostConstants.labanHost}find?type=1&query=$word"
        : "${HostConstants.labanHostMobile}en_vn/find?keyword=$word";

    print("Open link: $link");

    Uri url = Uri.parse(link);

    await launchUrl(url);
  }

  _resultList(context) {
    return SizedBox(
      height: 500,
      width: 350,
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchInitial) {
            return const SizedBox();
          }

          if (state is SearchLoading) {
            return const Center(
              child: SizedBox(
                  height: 50, width: 50, child: CircularProgressIndicator()),
            );
          }

          if (state is SearchSuccess) {
            var translationList = state.result;
            if (translationList.isEmpty) {
              return const Align(alignment: Alignment.topCenter, child: Text("Word is not found"));
            }

            return ListView.separated(
              itemCount: translationList.length,
              itemBuilder: (context, index) {
                var translation = translationList[index];

                return ListTile(
                    // onTap: () => context.go("/details/$keyWord"),
                    onTap: () => _launchBrowser(context, translation.word),
                    title: _translationItem(translation));
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

  Widget _translationItem(Translation translation) {
    var word = translation.word;
    var translated = translation.translated;

    var firstChar = word[0];
    word = word.replaceFirst(firstChar, firstChar.toUpperCase());

    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: "$word ",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18)),
        TextSpan(
            text: translated,
            style: const TextStyle(color: Colors.black, fontSize: 18)),
      ]),
    );
  }
}
