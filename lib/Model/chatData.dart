// ignore_for_file: file_names

class ChatData{
  String name;
  String icon;
  bool isGroup;
  String time;
  String currentMessage;
  int id;
  ChatData(
    {required this.name, required this.icon, required this.isGroup, required this.time, required this.currentMessage,required this.id});

  // String type;
  // String message;
  // ChatData( {required this.type, required this.message});
}