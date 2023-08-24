import 'dart:async';

import 'package:demo_test/DbHelper.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Joke.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _data = "Initial data"; // Placeholder for the fetched data
  List<Joke>lists=[];
  DbHelper helper=new DbHelper();

  @override
  void initState() {
    super.initState();
    helper.initializeDb();
    // Call the API fetching function initially
    fetchData();

    // Set up a timer to fetch API data every 1 minute
    Timer.periodic(Duration(minutes: 1), (timer) {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    final url = "https://geek-jokes.sameerkumar.website/api?format=json"; // Replace with your API endpoint
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Joke joke=Joke.fromJson(json.decode(response.body));
        await helper.insert(joke);
        var list=  helper.getProducts();
        lists=await list;
        setState(() {

        });

      } else {
        print("Failed to fetch data. Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Joke Example"),
        ),
        body: Center(
          child:  ListView.builder(
            itemCount:lists.length,
            itemBuilder: (context, i){
              return Card(child:new Container(child:  new Text(lists[i].joke.toString()),padding: EdgeInsets.all(10),));

            },
          ),
        ), // Display the fetched data here
      ),

    );
  }
}
