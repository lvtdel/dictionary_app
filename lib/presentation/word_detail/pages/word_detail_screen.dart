import 'package:directory_app/common/constants/host.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WordDetailScreen extends StatelessWidget {
  const WordDetailScreen({super.key, required this.word});

  final String word;

  Future<void> _launchUrl(BuildContext context) async {
    // Mobile sẽ sử dụng link khác, nhưng web laban redirect không đúng
    // Tự redirect bằng tay
    String link = (MediaQuery.of(context).size.width > 600)
        ? "${HostConstants.labanHost}find?type=1&query=$word"
        : "${HostConstants.labanHostMobile}en_vn/find?keyword=$word";

    print("Open link: $link");

    Uri url = Uri.parse(link);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    _launchUrl(context);
    return Placeholder();
  }
}
