import 'package:directory_app/common/constants/host.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WordDetailScreen extends StatelessWidget {
  const WordDetailScreen({super.key, required this.word});

  final String word;

  Future<void> _launchUrl() async {
    String link = "${HostConstants.labanHost}find?type=1&query=$word";

    Uri url = Uri.parse(link);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    _launchUrl();
    return Placeholder();
  }
}
