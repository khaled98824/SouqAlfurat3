import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sooq1alzour/Admin/SerchDataAdminUser.dart';


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
          stream: Firestore.instance.collection('users').snapshots(),
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
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    trailing: Text(snapshot.data.documents[index]['user_uid'],style: TextStyle(
                                      fontSize: 11
                                    ),),
                                    subtitle: Text(
                                      snapshot.data.documents[index]['time'],
                                      style: TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                    leading:Text(snapshot.data.documents[index]['area'],style: TextStyle(
                                      fontSize: 13
                                    ),),
                                  ),
                                ),
                              );
                            })),

                    Positioned(
                      right: 33,
                      top: 10,
                      child: InkWell(
                        onTap: (){
                          showSearch(context: context, delegate: SerchDataAdmin(collection: 'users'));
                        },
                        child: Container(
                          height: 42,
                          width: 340,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40), color: Colors.grey[350]),
                          child: Stack(
                            textDirection: TextDirection.rtl,
                            alignment: Alignment(0.3, 0),
                            children: <Widget>[
                              Text('!... إبحث في قائمة المستخدمين',
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
