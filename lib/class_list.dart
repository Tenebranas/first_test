import 'package:flutter/material.dart';
import 'homework_screen.dart';
import 'auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'class_info_screen.dart';
class ClassList extends StatefulWidget {
  const ClassList({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ClassList> createState() => _ClassListState();
}

class _ClassListState extends State<ClassList> {
  final User? user = Auth().currentUser;
  final String uid = Auth().currentUser?.uid as String;
  String? _username;
  final _database = FirebaseDatabase.instance.ref();
  void _fetchUsername() {
    _database.child('uuid_to_user/'+uid).get().then((snapshot) {
      final data = Map<String,dynamic>.from(snapshot.value as Map<dynamic,dynamic>);
      _username=data['username'];
      print("Username found: "+_username!);
    });
  }
  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }
  @override
  Widget build(BuildContext context) {
    _fetchUsername();
    print(_username);

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FutureBuilder(future: _database.child('uuid_to_user/'+uid).get(),
                builder: (context,snapshot) {
              if(snapshot.hasData) {
                print(snapshot.data!.value);
                _username = (snapshot.data!.value! as Map<dynamic,dynamic>)['username'] as String;
                return Flexible(
                  child: StreamBuilder(
                      stream: _database.child('classes/'+_username!).orderByKey().limitToLast(10).onValue,
                      builder: (context, snapshot) {
                        final tilesList = <ListTile>[];
                        if(snapshot.hasData) {
                          Map<dynamic,dynamic> classData=snapshot.data!.snapshot.value as Map<dynamic,dynamic>;

                          final myClasses=Map<String, dynamic>.from(
                              classData);
                          myClasses.forEach((key, value) {
                            final nextClass = Map<String, dynamic>.from(value);
                            final classTile = ListTile(
                              title: Text(nextClass['Subject']),
                              subtitle: Text(nextClass['Type']+" on "+ nextClass['Day']+" at "+nextClass['Time']),
                              tileColor: Colors.grey,
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ClassInfoScreen(title: nextClass['Subject']+", "+ nextClass['Day']+": "+nextClass['Time'], data: nextClass)),
                                );
                              },

                            );
                            tilesList.add(classTile);
                          });
                        }
                        return ListView(
                          shrinkWrap: true,
                          children: tilesList,
                        );
                      }
                  ),
                );
              } else{
                return CircularProgressIndicator();
              }
                })




          ],
        ),
      ),

    );
  }
}
