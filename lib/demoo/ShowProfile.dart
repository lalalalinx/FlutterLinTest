
// ignore_for_file: file_names

class ShowProfile {
  late List<String> view;

  ShowProfile({required this.view});

  ShowProfile.fromJson(Map<String, dynamic> json) {
    view = json['view'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['view'] = this.view;
    return data;
  }
}