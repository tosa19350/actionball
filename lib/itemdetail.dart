import 'package:flutter/material.dart';

class ItemDetail extends StatelessWidget {

  final Map<String, dynamic> doc;       // item content received from item list screen.

  ItemDetail({this.doc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Text(
                  doc['name'],
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 10),
                  child: Image.network(
                    doc['pic1']
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 5),
                        child: Image.network(
                          doc['pic2'],
                          height: 100,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 5),
                        child: Image.network(
                          doc['pic3'],
                          height: 100,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 5),
                        child: Image.network(
                          doc['pic4'],
                          height: 100,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Brand: " + doc['brand'],
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black45
                        )
                      ),
                      Text(
                          "\nprice: " + doc['price'].toString(),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black45
                          )
                      ),
                      Text(
                          "\n" + doc['description'],
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black45
                          )
                      ),
                    ],
                  )
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
          )
        )
      )
    );
  }
}