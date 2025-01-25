
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:message_reader/app_config.dart';

class MessageReaderWidget extends StatefulWidget {
  const MessageReaderWidget({super.key});
  final String title = 'Message Reader';

  @override
  State<MessageReaderWidget> createState() => _MessageReaderWidgetState();
}

class _MessageReaderWidgetState extends State<MessageReaderWidget> {
  List<EnkMessage> enkMessages = List.empty();
  static String cprDataURL =
      "https://enkce-enrobe.fr/v2/logs/message.php";


  void _loadData() {
    // String jsonData = "";
    if (enkMessages.isEmpty){
      downloadJson(cprDataURL).then((jsonData) {
        setState(() {
          List<dynamic> jsonResponse = json.decode(jsonData);
          enkMessages = jsonResponse
              .map((e) => EnkMessage.fromJson(e as Map<String, dynamic>))
              .toList();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      debugPrint("load data");
    }

    _loadData();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            EnkMessagesListWidget(enkMessages: enkMessages,),
          ],
        ),
      ),
    );
  }

  Future<String> downloadJson(String url) async {
    try {

      var response = await http.get(AppConfig.apiUrl,
          headers: <String, String>{'authorization': AppConfig.basicAuth});
      if (kDebugMode) {
        debugPrint(" response : $response");
      }
      if (response.statusCode == 200) {
        if (kDebugMode){
          debugPrint(response.body);
        }


        return response.body;
      } else {
        throw Exception(
            'Failed to load JSON data from the internet. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error downloading JSON: $e, $e.message');
    }
  }
}

class EnkMessagesListWidget extends StatelessWidget{
  const EnkMessagesListWidget({super.key, required this.enkMessages} );
final List<EnkMessage> enkMessages;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text("Message : ${enkMessages.length}"),
        Spacer(),
        getTextWidgets()
      ],
    );
  }
 getTextWidgets()
  {
    return Column(
        children: enkMessages.map((item) =>
    Text('$item', style: TextStyle(color: Colors.red ),)).toList());
  }
}

class EnkMessage {
  final String name;
  final String tel;
  final String email;
  final String? message;
  final String? debug;

  EnkMessage({
    required this.name,
    required this.tel,
    required this.email,
    required this.message,
    this.debug,
  });

  factory EnkMessage.fromJson(Map<String, dynamic> json) {
    return EnkMessage(
      name: json['name'] as String,
      tel: json['tel'] as String,
      email: json['email'] as String,
      message: json['message'] as String?,
      debug: json['robot'] as String?,
    );
  }
  @override
  String toString() {
    return '$name | $email | $tel';
  }

  Future<String> downloadJson(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // if (kDebugMode){
        //   debugPrint(response.body);
        // }


        return response.body;
      } else {
        throw Exception(
            'Failed to load JSON data from the internet. Status code: ${response
                .statusCode}');
      }
    } catch (e) {
      throw Exception('Error downloading JSON: $e');
    }
  }

}