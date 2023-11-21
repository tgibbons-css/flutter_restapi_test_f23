import 'dart:async';
//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_restapi_test_f23/my_rest_api.dart';

//import 'package:http/http.dart' as http;
import 'album.dart';
import 'cat_facts_model.dart';
import 'pokemon_model.dart';
import 'mlb_teams_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum;
  late Future<List<Team>> futureBaseballTeams;

  @override
  void initState() {
    super.initState();
    MyRestAPI api = new MyRestAPI();
    futureAlbum = api.fetchAlbum();
    futureBaseballTeams = api.fetchBaseballTeams();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body:
              //albumFutureBuilder(),
              //buildBody(context),
        BaseballTeamWidget(),
        ),
      );
  }

  FutureBuilder<Album> albumFutureBuilder() {
    return FutureBuilder<Album>(
      future: futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }

  Widget BaseballTeamWidget() {
    return FutureBuilder(
      future: futureBaseballTeams,
      builder: (context, snapshot) {
        print('Baseball team widget updating');
        if (snapshot.data == null  || snapshot.connectionState == ConnectionState.none ||
            snapshot.hasData == null) {
          print('project snapshot data is: ${snapshot.data}');
          return Container();
        }
        print('snapshot length is: ${snapshot.data!.length}');
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            Team team = snapshot.data![index];
            return ListTile(
              title: Text(team.teamName,),
              subtitle: Text(team.locationName??'no loacation'),

            );
          },
        );
      },

    );
  }

  Widget buildBody(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 4,
        //shrinkWrap: true,
        itemBuilder: (BuildContext context, int position) {
          return buildListTile(position);
        }
    );
  }

  ListTile buildListTile(int position) {
    return ListTile(
        shape: Border(
          top: BorderSide(),
          bottom: BorderSide(),
        ),
        leading:  Icon(Icons.access_time_outlined),
        title: Row(
          children: <Widget>[
            Icon(Icons.airline_seat_recline_normal_rounded),
            Text("Row :" ),
          ],
        ),
    );
  }

}
