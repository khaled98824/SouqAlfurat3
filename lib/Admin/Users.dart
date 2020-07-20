import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sooq1alzour/models/PageRoute.dart';
import 'package:sooq1alzour/ui/EditAd.dart';

class UsersAdmin extends StatefulWidget {
  @override
  _UsersAdminState createState() => _UsersAdminState();
}

class _UsersAdminState extends State<UsersAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Users Info'),
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
                        padding: EdgeInsets.only(top: 20),
                        child: ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (BuildContext context, index) {
                              return Card(
                                elevation: 5,
                                child: SizedBox(
                                  height: 65,
                                  child: ListTile(
                                    title: Text(
                                      snapshot.data.documents[index]['name'],
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    trailing: InkWell(
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
                                          Icons.mode_edit,
                                          color: Colors.blue,
                                          size: 32,
                                        )),
                                    subtitle: Text(
                                      snapshot.data.documents[index]['time'],
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                    leading: InkWell(
                                        onTap: () async {
                                          Firestore.instance
                                              .collection('Ads')
                                              .document(snapshot.data
                                                  .documents[index].documentID)
                                              .delete()
                                              .then((value) {
                                            print('delete done');
                                          });
                                        },
                                        child: Icon(
                                          Icons.delete_forever,
                                          color: Colors.red,
                                        )),
                                  ),
                                ),
                              );
                            })),
                    Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 40)),
                      ],
                    ),
                  ],
                );
            }
          },
        ));
  }
}
