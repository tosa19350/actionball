import 'package:flutter/material.dart';
import 'menudetail.dart';

class SubSection extends StatelessWidget {

  final List<dynamic> sectionlist;    // section list of a menu item received from main.dart (menu list)
  final String picname;
  final String menuname;

  SubSection({this.sectionlist, this.picname, this.menuname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.network(
                  picname,
                  fit: BoxFit.fitWidth
              ),
              new Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: sectionlist.map((el) => Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                      child: new GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => MenuDetail(
                                    picname: picname,
                                    menuname: menuname
                                )));
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
                                        el['pic'],
                                        width: 150
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                          padding: EdgeInsets.only(right: 5),
                                          alignment: Alignment.centerRight,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                el['section'].toString(),
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.black
                                                ),
                                              ),
                                              Text(
                                                menuname,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black12
                                                ),
                                              )
                                            ],
                                          )
                                      )
                                  )
                                ],
                              )
                          )
                      )
                  )).toList(),
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_back),
                tooltip: 'Go to previous screen',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}