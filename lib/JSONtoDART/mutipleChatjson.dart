// To parse this JSON data, do
//
//     final mutipleChatjson = mutipleChatjsonFromJson(jsonString);

// ignore_for_file: file_names, unnecessary_this, unnecessary_new, deprecated_member_use, prefer_collection_literals

// class MutipleChatjson {
// 	late List<List> set;

// 	MutipleChatjson({required this.set});

// 	MutipleChatjson.fromJson(Map<String, dynamic> json) {
// 		if (json['set'] != null) {
// 			set = new List<List>();
// 			json['set'].forEach((v) { set.add(new List.fromJson(v)); });
// 		}
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		if (this.set != null) {
//       data['set'] = this.set.map((v) => v.toJson()).toList();
//     }
// 		return data;
// 	}
// }

// class Set {


// 	Set({});

// 	Set.fromJson(Map<String, dynamic> json) {
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		return data;
// 	}
// }

import 'dart:convert';

MutipleChatjson mutipleChatjsonFromJson(String str) => MutipleChatjson.fromJson(json.decode(str));

String mutipleChatjsonToJson(MutipleChatjson data) => json.encode(data.toJson());

class MutipleChatjson {
  late List<List> set;
  
    MutipleChatjson({
        required this.mutipleChatjsonSet,
    });

    List<List<String>> mutipleChatjsonSet;

    factory MutipleChatjson.fromJson(Map<String, dynamic> json) => MutipleChatjson(
        mutipleChatjsonSet: List<List<String>>.from(json["set"].map((x) => List<String>.from(x.map((x) => x)))),
    );

    Map<String, dynamic> toJson() => {
        "set": List<dynamic>.from(mutipleChatjsonSet.map((x) => List<dynamic>.from(x.map((x) => x)))),
    };
}
