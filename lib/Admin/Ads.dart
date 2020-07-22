import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sooq1alzour/models/PageRoute.dart';
import 'package:sooq1alzour/ui/EditAd.dart';

import 'SerchAdsAdmin.dart';
import 'SerchDataAdminUser.dart';

class AdsAdmin extends StatefulWidget {
  @override
  _AdsAdminState createState() => _AdsAdminState();
}
var time = DateFormat('yyyy,MM,dd').format(DateTime.now());
class _AdsAdminState extends State<AdsAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'الإعلانات',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontFamily: 'AmiriQuran', height: 1),
          ),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection('Ads').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      padding: EdgeInsets.only(top: 60),
                      child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 0.6,
                          children: List.generate(
                              snapshot.data.documents.length, (index) {
                            return InkWell(
                              onTap: () {
//
//                                  Navigator.push(context, BouncyPageRoute(widget: ShowAd(
//                                    documentId: snapshot.data.documents[index].documentID,indexDocument: index,)));
                              },
                              child: Card(
                                elevation: 6,
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white70,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        ClipRRect(
                                          child: Image.network(
                                            snapshot.data.documents[index]
                                                ['imagesUrl'][0],
                                            height: 174,
                                            width: 190,
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              snapshot.data.documents[index]
                                                  ['name'],
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              snapshot.data
                                                  .documents[index]['price']
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              snapshot.data.documents[index]
                                                  ['area'],
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
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              snapshot.data.documents[index]['time'],
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
                                              ': الوقت',
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
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              snapshot.data.documents[index]
                                              ['uid'],
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: 'AmiriQuran',
                                                height: 1.2,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),

                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            IconButton(
                                                icon: Icon(Icons.delete_forever,
                                                  color: Colors.red,size: 28,),
                                                onPressed: (){
                                                  Firestore.instance
                                                      .collection('Ads')
                                                      .document(snapshot
                                                      .data
                                                      .documents[
                                                  index]
                                                      .documentID)
                                                      .delete()
                                                      .then((value) {
                                                    print(
                                                        'delete done');
                                                  });
                                                }),
                                            InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      BouncyPageRoute(
                                                          widget: EditAd(
                                                        documentId: snapshot
                                                            .data
                                                            .documents[index]
                                                            .documentID,
                                                      )));
                                                },
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.blue,
                                                  size: 28,
                                                ))
                                          ],
                                        )
                                      ],
                                    )),
                              ),
                            );
                          })),
                    ),
                    Positioned(
                      right: 33,
                      top: 10,
                      child: InkWell(
                        onTap: () {
                          showSearch(
                              context: context,
                              delegate: SerchAdsAdmin(collection: 'Ads'));
                        },
                        child: Container(
                          height: 42,
                          width: 340,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.grey[350]),
                          child: Stack(
                            alignment: Alignment(0.3, 0),
                            children: <Widget>[
                              Text('!... إبحث في قائمة الإعلانات',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
                                    fontFamily: 'AmiriQuran',
                                    height: 1,
                                  )),
                              Align(
                                  alignment: Alignment(0.9, 0),
                                  child: Icon(
                                    Icons.search,
                                    size: 32,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
            }
          },
        ));
  }
}
