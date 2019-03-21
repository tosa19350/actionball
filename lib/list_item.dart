import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'itemdetail.dart';

class ListItemViewWidget extends StatelessWidget {

  final DocumentSnapshot snapshot;
  ListItemViewWidget({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
      child: new GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => ItemDetail(
                  doc: snapshot.data
              )));
        },
        child: Container(
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
                    snapshot.data['pic1'],
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
                            snapshot.data['name'],
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            snapshot.data['brand'],
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black
                            ),
                          ),
                          Text(
                            snapshot.data['description'],
                            textAlign: TextAlign.right,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black12
                            ),
                          )
                        ],
                      )
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}