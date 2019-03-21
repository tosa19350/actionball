import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'list_item.dart';

int pagesize = 2;

class MenuDetail extends StatefulWidget {
  final String picname;
  final String menuname;

  MenuDetail({this.picname, this.menuname});

  @override
  _MenuDetailState createState() => _MenuDetailState();
}

class _MenuDetailState extends State<MenuDetail> {
  String picname;
  String menuname;
  bool   isloading;       // variable for detecting on loading.
  final ScrollController scrollController = new ScrollController();
  DocumentSnapshot _lastDoc;  // last document of displayed list.
  List<DocumentSnapshot>  items;

  @override
  void initState() {
    picname = widget.picname;
    menuname = widget.menuname;
    items = new List();
    isloading = true;
    // load fist 20 items
    Firestore.instance.collection('movies').document("genre").collection(menuname).orderBy('name').limit(pagesize).getDocuments().then((snap){
      setState(() {
        items.addAll(snap.documents);
      });
      _lastDoc = snap.documents.last;
      isloading = false;
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: onNotification,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.network(
                    picname,
                    fit: BoxFit.fitWidth
                ),
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  tooltip: 'Go to previous screen',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                new Container(
                  child: Column(
                    // display the list content on screen.
                    children: items.map((el) => ListItemViewWidget(snapshot: el)).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  // scroll event(pagination)
  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <= 50) {

        if(isloading == false){
          isloading = true;
          //get new list;
          Firestore.instance.collection('movies').document("genre").collection(menuname).orderBy('name').startAfter([_lastDoc.data['name']]).limit(pagesize).getDocuments().then((snap){
            if(snap.documents != null && snap.documents.length != 0) {
              setState(() {
                items.addAll(snap.documents);
              });
              _lastDoc = snap.documents.last;
            }
            isloading = false;
          });
        }
      }
      return true;
    }
    return false;
  }
}