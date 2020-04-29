import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:moyawim/services/auth.dart';
import 'visitorProfile.dart';

import 'package:moyawim/homefiles/detailpage.dart';
import '../loader.dart';
import '../pages/picturesGet.dart';

class completeDetail extends StatefulWidget {
  DocumentSnapshot ad;
  final String uid;

  completeDetail({this.ad, this.uid});

  @override
  _completeDetailState createState() => _completeDetailState();
}

class _completeDetailState extends State<completeDetail> {
  Future _data;
  final db = Firestore.instance;

  Future getAds() async {
    var fs = Firestore.instance;
    QuerySnapshot qn = await fs.collection("ads").getDocuments();
    return qn.documents;
  }

  bool isImage = true;

  void check() {
    var len1 = widget.ad.data["urls"];
    int len;
    if(len1 != null){
      int len = widget.ad.data["urls"].length;
      if(len != 0){
        isImage = true;
      }
      else{
        isImage = false;
      }
    }
  }


  @override
  void initState() {
    super.initState();
    _data = getAds();

  }

  navigateToDetail(DocumentSnapshot ad, String uid) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage(ad: ad, uid: uid)));
  }

  static RandomColor _randomColor = RandomColor();

  Color _color() =>
      _randomColor.randomColor(colorBrightness: ColorBrightness.light);


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final mainTag = widget.ad.data["tags"][0];
    check();
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
            future: _data,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: ColorLoader(),
                );
              } else {

                return Container(
                    color: Colors.black45,
                    child: ListView(children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(3.0),
                          height: 230.0,
                          width: 600.0,
                          child: !isImage ? Card(
                            color: Colors.cyan,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.lightbulb_outline, color: Colors.black),
                                Text(
                                  (widget.ad.data["tags"][0]),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontFamily: 'Raleway'),
                                )
                              ],
                            ),
                          ) :
                          getPic(ad: widget.ad)
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10.0, top: 10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              (widget.ad.data["title"]),
                              textAlign: TextAlign.start,
                              style:
                              TextStyle(fontFamily: 'Raleway', fontSize: 30.0),
                            ),
                          )),
                      Container(
                          padding: EdgeInsets.only(left: 10.0, top: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              ("\$" + widget.ad.data["price"]),
                              textAlign: TextAlign.start,
                              style:
                              TextStyle(fontFamily: 'Raleway', fontSize: 25.0),
                            ),
                          )),
                     /* Container(
                          padding: EdgeInsets.only(left: 10.0, top: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              ("79382467"),
                              textAlign: TextAlign.start,
                              style:
                              TextStyle( fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                          )),*/
                      SizedBox(height: 10),
                      MaterialButton(
                          padding: EdgeInsets.only(right: 10.0, left: 10.0),
                          child: GestureDetector(
                            child: Container(
                              child: Text(
                                "Completed",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color:
                                    Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold),
                              ),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 13),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [Colors.green, Colors.greenAccent])),
                            ),
                          )),
                      SizedBox(height: 10),
                      Container(
                          padding: EdgeInsets.only(left: 10.0, top: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              ("Ad Information"),
                              textAlign: TextAlign.start,
                              style:
                              TextStyle(fontFamily: 'Raleway', fontSize: 25.0),
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 3.0, right: 3.0),
                          width: width,
                          height: 250.0,
                          child: Card(
                            color: Colors.grey[900],
                            child: Column(
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(top: 5.0, left: 3.0),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Description",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontSize: 20.0),
                                        ))),
                                Container(
                                  width: width,
                                  height: 100.0,
                                  padding: EdgeInsets.all(4.0),
                                  child: Card(
                                    color: Colors.black12,
                                    child: Container(
                                        margin: EdgeInsets.all(5.0),
                                        child: Text(
                                          (widget.ad.data["description"] + ""),
                                          maxLines: 99,
                                          style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontSize: 15.0),
                                        )),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 5.0, left: 3.0),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Location",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontSize: 20.0),
                                        ))),
                                Container(
                                  width: width,
                                  height: 60.0,
                                  padding: EdgeInsets.all(4.0),
                                  child: Card(
                                    color: Colors.black12,
                                    child: Container(
                                        margin: EdgeInsets.all(5.0),
                                        child: Text(
                                          (widget.ad.data["location"]),
                                          style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontSize: 15.0),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Container(
                          padding:
                          EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              ("Worked on by"),
                              textAlign: TextAlign.start,
                              style:
                              TextStyle(fontFamily: 'Raleway', fontSize: 25.0),
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => visitorProfile(widget.ad.data["worker"]))),

                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.white),
                                borderRadius:
                                BorderRadius.circular(10.0)),
                            height: 70,
                            width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                firstl(widget.ad.data["worker"]),

                                fName(widget.ad.data["worker"]),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                          padding:
                          EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              ("Posted by"),
                              textAlign: TextAlign.start,
                              style:
                              TextStyle(fontFamily: 'Raleway', fontSize: 25.0),
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => visitorProfile(widget.ad.data["poster"]))),

                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.white),
                                borderRadius:
                                BorderRadius.circular(10.0)),
                            height: 70,
                            width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                firstl(widget.ad.data["poster"]),

                                fName(widget.ad.data["poster"]),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                          padding:
                          EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              ("Similar Ads"),
                              textAlign: TextAlign.start,
                              style:
                              TextStyle(fontFamily: 'Raleway', fontSize: 25.0),
                            ),
                          )),
                      Container(
                        child: Container(
                            padding: EdgeInsets.only(
                              left: 10.0,
                            ),
                            height: height * 0.267,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 14,
                              itemBuilder: (context, index) {
                                if ((snapshot.data[index].data["tags"][0] ==
                                    mainTag) &&
                                    (snapshot.data[index].documentID !=
                                        widget.ad.documentID)) {
                                  return Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: GestureDetector(
                                        onTap: () => navigateToDetail(
                                            snapshot.data[index], widget.uid),
                                        child: Container(
                                            width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                            decoration: BoxDecoration(
                                                border:
                                                Border.all(color: Colors.white),
                                                borderRadius:
                                                BorderRadius.circular(10.0)),
                                            child: GestureDetector(
                                              child: Column(children: <Widget>[
                                                Expanded(
                                                    flex: 5,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                            child: Padding(
                                                                padding:
                                                                EdgeInsets.only(
                                                                    left: 6.0,
                                                                    right: 6.0,
                                                                    top: 6.0),
                                                                child: Container(
                                                                    height: height *
                                                                        0.3,
                                                                    child: Card(
                                                                      color: Colors
                                                                          .white60,
                                                                      child:
                                                                      ListTile(
                                                                        title: Text(
                                                                          snapshot
                                                                              .data[
                                                                          index]
                                                                              .data["title"],
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white,
                                                                              fontSize:
                                                                              16.0,
                                                                              fontFamily:
                                                                              'Raleway',
                                                                              fontWeight:
                                                                              FontWeight.bold),
                                                                        ),
                                                                        subtitle:
                                                                        Text(
                                                                          "Price \$" +
                                                                              snapshot
                                                                                  .data[index]
                                                                                  .data["price"],
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white,
                                                                              fontSize:
                                                                              16.0,
                                                                              fontFamily:
                                                                              'Raleway'),
                                                                        ),
                                                                      ),
                                                                    )))),
                                                      ],
                                                    )),
                                                Expanded(
                                                    flex: 7,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Padding(
                                                              padding:
                                                              EdgeInsets.only(
                                                                  top: width *
                                                                      0.021,
                                                                  left: width *
                                                                      0.021,
                                                                  right: width *
                                                                      0.021,
                                                                  bottom: width *
                                                                      0.027),
                                                              child:
                                                              GestureDetector(
                                                                  child:
                                                                  Container(
                                                                    height:
                                                                    height * 0.3,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          5.0),
                                                                      color: _color(),
                                                                    ),
                                                                    child: Column(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                      children: <
                                                                          Widget>[
                                                                        Icon(
                                                                            Icons
                                                                                .lightbulb_outline,
                                                                            color: Colors
                                                                                .white),
                                                                        Text(
                                                                          (snapshot.data[index].data["tags"][0]
                                                                          [
                                                                          0])
                                                                              .toUpperCase() +
                                                                              (snapshot
                                                                                  .data[
                                                                              index]
                                                                                  .data[
                                                                              "tags"]
                                                                              [
                                                                              0]
                                                                                  .substring(
                                                                                  1)),
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white,
                                                                              fontSize:
                                                                              18.0,
                                                                              fontFamily:
                                                                              'Raleway'),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ))),
                                                        ),
                                                      ],
                                                    ))
                                              ]),
                                            ))),
                                  );
                                } else {
                                  return Text("");
                                }
                              },
                            )),
                      )
                    ]));
              }
            }));
  }
}
