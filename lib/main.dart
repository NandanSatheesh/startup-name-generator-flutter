import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:name_gen/models/names_response.dart';
import 'package:name_gen/styles/textstyles.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.grey[850],
        ),
        home: MainScreen());
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<NamesResponse> getNames(String name) async {
    final response =
        await http.get(Uri.encodeFull('http://192.168.0.104:8080/$name'));

    if (response.statusCode == 200) {
      return NamesResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get names from API');
    }
  }

  NamesResponse response;

  @override
  Widget build(BuildContext context) {
    final inputController = TextEditingController();

    int numberOfStyles = listOfStyles.length;

    final List<String> items = [
      '123',
      '123',
      '123',
      '123',
      '123',
      '123',
      '123',
      '123',
      '123',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Start-up Name Generator'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Let\'s name your startup:',
                  style: TextStyle(color: Colors.grey[850], fontSize: 24),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                      child: TextField(
                        controller: inputController,
                        onChanged: (text) => inputController.text = text,
                        decoration: InputDecoration(hintText: 'some words'),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      flex: 2,
                      child: RaisedButton(
                        color: Colors.grey[850],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        onPressed: () {
                          getNames(inputController.text).then((data) {
                            setState(() {
                              this.response = data;
                            });
                          }, onError: (error) {
                            print(error);
                          });
                        },
                        child: Text(
                          "GO",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                NamesInCardView(response)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NamesInCardView extends StatelessWidget {
  NamesInCardView(this.response);

  NamesResponse response;
  final random = new Random();
  double width, height;

  int next(int min, int max) => min + random.nextInt(max - min);

  @override
  Widget build(BuildContext context) {
    final deviceData = MediaQuery.of(context).size;
    width = deviceData.width - 80;
    height = deviceData.height;

    if (response != null)
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < response.data.names.length / 2; i++)
                  createCard(response.data.names[i]),
              ],
            ),
          ),
          SizedBox(
            width: 16,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              for (int i = response.data.names.length - 1;
                  i > response.data.names.length / 2;
                  i--)
                createCard(response.data.names[i]),
            ],
          ),
        ],
      );
    else
      return Container(
        width: 0,
        height: 0,
      );
  }

  Widget createCard(String text) => Card(
        child: Container(
          width: width / 2,
          height: 160,
          child: Center(
            child: Text(
              text,
              style: listOfStyles[next(0, listOfStyles.length)],
            ),
          ),
        ),
      );
}
