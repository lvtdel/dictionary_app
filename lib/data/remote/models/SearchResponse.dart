import 'package:json_annotation/json_annotation.dart';

/// query : "hello"
/// suggestions : [{"select":"hello","link":"/find?type=1&query=hello","data":"<a  href=\"javascript:;\" rel=\"/find?type=1&query=hello\"><span class=\"fl\"><span class=\"hl\">hello</span></span><span class=\"fr hl\" >/hə'ləʊ/<img src=\"https://stc-laban.zdn.vn/dictionary/images/vi_dict_EV_icon.png\" style=\"margin-left: 5px;position: relative;top: 2px;\" ></span><div class=\"clr\"></div><p>Thán từ, Danh từ</p></a>","value":"43479"}]

@JsonSerializable()
class SearchResponse {
  SearchResponse({
      this.query, 
      this.suggestions,});

  SearchResponse.fromJson(dynamic json) {
    query = json['query'];
    if (json['suggestions'] != null) {
      suggestions = [];
      json['suggestions'].forEach((v) {
        suggestions?.add(Suggestions.fromJson(v));
      });
    }
  }
  String? query;
  List<Suggestions>? suggestions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['query'] = query;
    if (suggestions != null) {
      map['suggestions'] = suggestions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// select : "hello"
/// link : "/find?type=1&query=hello"
/// data : "<a  href=\"javascript:;\" rel=\"/find?type=1&query=hello\"><span class=\"fl\"><span class=\"hl\">hello</span></span><span class=\"fr hl\" >/hə'ləʊ/<img src=\"https://stc-laban.zdn.vn/dictionary/images/vi_dict_EV_icon.png\" style=\"margin-left: 5px;position: relative;top: 2px;\" ></span><div class=\"clr\"></div><p>Thán từ, Danh từ</p></a>"
/// value : "43479"

class Suggestions {
  Suggestions({
      this.select, 
      this.link, 
      this.data, 
      this.value,});

  Suggestions.fromJson(dynamic json) {
    select = json['select'];
    link = json['link'];
    data = json['data'];
    value = json['value'];
  }
  String? select;
  String? link;
  String? data;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['select'] = select;
    map['link'] = link;
    map['data'] = data;
    map['value'] = value;
    return map;
  }

}