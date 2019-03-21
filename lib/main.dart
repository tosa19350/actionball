import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'subsection.dart';
import 'menudetail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                  'assets/images/main_menu.jpg',
                  fit: BoxFit.fitWidth
              ),
              new Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: StreamBuilder(
                  // stream builder for menu list such as action, kids and romance...
                  stream: Firestore.instance.collection('movies').document("genre").snapshots(),
                  builder: (context, snapshot){
                    // occured error in loading data from firestore.
                    if (snapshot.hasError) return new Text('Error: ${snapshot.error}');

                    // it is loading data from firestore now.
                    if(snapshot.connectionState == ConnectionState.waiting)
                      return Text('Loading data... Please wait...');

                    // if else, loading is completed successfully.
                    Map<String, dynamic> _list = new Map<String, dynamic>.from(snapshot.data.data);
                    var sortkeylist = _list.keys.toList()..sort();
                    List<Widget> menulist = new List<Widget>();

                    // creating menu list for displaying them on the screen.
                    sortkeylist.forEach((String menuName){
                      var entry = _list[menuName];

                      menulist.add(
                          Padding(
                              padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                              child: new GestureDetector(
                                onTap: (){    // action event such as click event.
                                  if (entry['sub_section'][0] != ''){       // if has sub section,
                                    List<dynamic> sections = entry['sub_section'];
                                    List<dynamic> sectionpics = entry['sub_section_pic'];
                                    List<dynamic> sectionswithpic = new List();
                                    for(int i = 0; i < sections.length; i++){
                                      sectionswithpic.add({'section': sections[i], 'pic': sectionpics[i] == null ? '' : sectionpics[i]});
                                    }

                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => SubSection(
                                          sectionlist: sectionswithpic,
                                          picname: entry['pic'],
                                          menuname: menuName
                                        )));
                                  }else {     // if has no sub section.
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => MenuDetail(
                                          picname: entry['pic'],
                                          menuname: menuName
                                        )));
                                  }
                                },
                                child: new Container(
                                    decoration: new BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: new BorderRadius.all(new Radius.circular(10)),
                                        boxShadow: [
                                          new BoxShadow(
                                              color: Colors.grey,
                                              offset: new Offset(5, 5),
                                              blurRadius: 10
                                          )
                                        ]
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        new ClipRRect(
                                          borderRadius: new BorderRadius.only(
                                            topLeft: new Radius.circular(10),
                                            bottomLeft: new Radius.circular(10),
                                          ),
                                          child: Image.network(
                                              entry['pic'],
                                              width: 150
                                          ),
                                        ),
                                        Expanded(
                                            child: Padding(
                                                padding: EdgeInsets.only(right: 5),
                                                child: Text(
                                                  menuName,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 32,
                                                      color: Colors.black12
                                                  ),
                                                )
                                            )
                                        )
                                      ],
                                    )
                                )
                              )
                          )
                      );
                    });

                    return Column(
                      children: menulist,
                    );
                  },
                ),
              )
            ],
          ),
        )
      )
    );
  }
}