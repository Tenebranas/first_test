import 'package:flutter/material.dart';
import 'homework_screen.dart';
class ClassInfoScreen extends StatefulWidget {
  const ClassInfoScreen({super.key, required this.title, required this.data});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final Map<String, dynamic> data;
  @override
  State<ClassInfoScreen> createState() => _ClassInfoScreenState();
}

class _ClassInfoScreenState extends State<ClassInfoScreen> {
  int _counter = 0;
  Map<String,dynamic>? studentData;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
    print(_counter);
  }
  @override
  void initState() {
    studentData=Map<String,dynamic>.from(widget.data['Students'] as Map<dynamic,dynamic>);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey, width:5)),
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                  "Class type: ",
                  style: TextStyle(fontSize: 30.0),
                )),

                Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey, width:5)),
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.data['Type'],
                      style: TextStyle(fontSize: 30.0),
                    )),
              ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey, width:5)),
                      margin: const EdgeInsets.all(3.0),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Week: ",
                        style: TextStyle(fontSize: 30.0),
                      )),

                  Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey, width:5)),
                      margin: const EdgeInsets.all(3.0),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.data['Week'].toString(),
                        style: TextStyle(fontSize: 30.0),
                      )),
                ]
            ),
          Text(
            "Students",
            style: TextStyle(fontSize: 30.0),
          ),
            Flexible(
                child:ListView.builder(
                  itemCount: studentData!.length,
                  itemBuilder: (BuildContext context, int index) {
                    String key = studentData!.keys.elementAt(index);
                    Map<String,dynamic> curData=Map<String,dynamic>.from(studentData![key]);
                    print(curData);
                    return ListTile(
                      title: Text(curData['name']),
                      subtitle: Text("StudentID: "+curData['id'].toString()+" Status: "+curData['status']),
                    );
                  }

            )),
            Row(children:[
              SizedBox(width: 180, height:50,
                  child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                HomeworkNotesScreen(title: 'Homework',text: widget.data['Homework']),
                            ));
                      },
                      child: const Text("Homework", style: TextStyle(fontSize: 30.0),)
                  ),
              ),
              SizedBox(width:5),
              SizedBox(width: 180, height:50,
                child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              HomeworkNotesScreen(title: 'Notes', text: widget.data['Notes'] ),
                          ));
                    },
                    child: const Text("Notes", style: TextStyle(fontSize: 30.0),)
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,),
            SizedBox(width:10,height:50)







          ],
        ),
      ),

    );
  }
}
