import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sooq1alzour/models/PageRoute.dart';
import 'package:sooq1alzour/ui/SearchUi.dart';
import 'package:sooq1alzour/ui/ShowAds.dart';

class Ads extends StatelessWidget {
  String department;
  String category;
  Ads({this.department,this.category});
  static const String id = "Ads";
  @override
  Widget build(BuildContext context) {
    return AdsFul(department: department,category: category,);
  }
}

class AdsFul extends StatefulWidget {
  String department;
  String category;
  AdsFul({this.department,this.category});
  @override
  _AdsFulState createState() => _AdsFulState(department: department);
}

class _AdsFulState extends State<AdsFul> {
  String department;
  String category;
  _AdsFulState({this.department,this.category});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('Ads')
            .where('department', isEqualTo: department,).where('category', isEqualTo:category )
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Text(
              'Loading...',
              style: TextStyle(fontSize: 60),
            );
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return Stack(
                children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: GridView.count(
                crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 0.7,
                    children:
                    List.generate(snapshot.data.documents.length, (index) {
                      return InkWell(
                        onTap: () {
                          print(department);
                          Navigator.push(context, BouncyPageRoute(widget: ShowAd(
                            documentId: snapshot.data.documents[index].documentID,indexDocument: index,)));
                        },
                        child: Card(
                          elevation: 6,
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white70,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  ClipRRect(
                                    child: Image.network(
                                      snapshot.data.documents[index]['imagesUrl'][0],
                                      height: 212,
                                      width: 190,
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data.documents[index]['name'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'AmiriQuran',
                                          height: 1.2,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data.documents[index]['price']
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'AmiriQuran',
                                          height: 1.2,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        ': السعر',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'AmiriQuran',
                                          height: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data.documents[index]['area'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'AmiriQuran',
                                          height: 1.2,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        ': المنطقة',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'AmiriQuran',
                                          height: 1.3,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 9,
                                      )
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      );
                    })),
              ),
                  Padding(
                    padding: EdgeInsets.only(top: 70,),
                      child: SearchArea()),
                  Align(
                    alignment: Alignment(0, -0.9),
                    child: Text(department,style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'AmiriQuran',
                      height: 1,
                      ),
                      ),)
                ],
              );

          }
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
