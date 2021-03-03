//import 'package:earthquake/models/model.dart';
import 'package:earthquake/bloc/quakeBloc.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  QuakeBloc bloc = QuakeBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("EarthQuake"),
          centerTitle: true,
        ),
        body: Center(
          child: StreamBuilder(
              stream: bloc.quakes,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: Text('Application Error'),
                  );
                }
                var format = DateFormat.yMMMd("en_US").add_jm();
                var date = format.format(DateTime.fromMicrosecondsSinceEpoch(
                    snapshot.data[index].properties.time * 1000,
                    isUtc: true));
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          //dense: true,
                          leading: CircleAvatar(
                            radius: 35.0,
                            backgroundColor: Colors.blueAccent,
                            child: Text(
                              snapshot.data[index].properties.mag.roundToDouble().toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          title: Row(
                            children: <Widget>[
                              Icon(Icons.location_on),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  snapshot.data[index].properties.place,
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            "       $date",
                            style: TextStyle(
                                color: Colors.black26,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500),
                          ),
                          onTap: () {
                            showAlertDialogue(
                                context, snapshot.data[index].properties.title);
                          });
                    });
              }),
        ));
  }
}

void showAlertDialogue(BuildContext context, String message) {
  var alert = AlertDialog(
    title: Text("Quakes"),
    content: Text(message),
    actions: <Widget>[
      FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("OK"))
    ],
  );
  showDialog(context: context, child: alert);
}
