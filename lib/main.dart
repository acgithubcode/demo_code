import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String _profileBaseUrl =
      'https://dog.ceo/api/breeds/image/random';
    
  Future<http.Response> _getHttp(
      {required String api, Map<String, String>? headers}) async {
    return http.get(
      Uri.parse(api),
      headers: headers ?? {"Content-Type": "application/json"},
    );
  }

  Future getUserProfileAPI() async {
    var response = await _getHttp(
      api: _profileBaseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    developer.log(response.statusCode.toString());
    developer.log(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                getUserProfileAPI() ;
              },
              child: Text(
                'Fetch',
                style: Theme.of(context).textTheme.headline4,
              ),
            )
          ],
        ),
      ),
    );
  }
}
