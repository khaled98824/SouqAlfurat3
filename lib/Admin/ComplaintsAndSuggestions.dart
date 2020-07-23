import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'SearchComplaintsAndSuggestionsAdmin.dart';

class ComplaintsAndSuggestions extends StatefulWidget {
  @override
  _ComplaintsAndSuggestionsState createState() => _ComplaintsAndSuggestionsState();
}

class _ComplaintsAndSuggestionsState extends State<ComplaintsAndSuggestions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'الشكاوى والإقتراحات',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontFamily: 'AmiriQuran', height: 1),
          ),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection('Complaints and Suggestions').orderBy('time').snapshots(),
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
                          itemBuilder: (BuildContext context, index){
                          return Container(
                            color: Colors.grey,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Card(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(snapshot.data.documents[index]['name'],textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'AmiriQuran',
                                            height: 1,
                                            color: Colors.black,
                                          ),),
                                        SizedBox(width: 10,),
                                        Text(': الإسم ',textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'AmiriQuran',
                                            height: 1,
                                            color: Colors.grey[700],
                                          ),),
                                        SizedBox(width: 10,)
                                      ],
                                    ),
                                    SizedBox(height: 9,),
                                    Container(
                                      width: MediaQuery.of(context).size.width-30,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.grey[300]
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(snapshot.data.documents[index]['mobile'],textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'AmiriQuran',
                                            height: 1,
                                            color: Colors.black,
                                          ),),
                                        SizedBox(width: 10,),
                                        Text(': موبايل ',textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'AmiriQuran',
                                            height: 1,
                                            color: Colors.grey[700],
                                          ),),
                                        SizedBox(width: 10,)
                                      ],
                                    ),
                                    SizedBox(height: 9,),
                                    Container(
                                      width: MediaQuery.of(context).size.width-30,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.grey[300]
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(snapshot.data.documents[index]['time'],textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'AmiriQuran',
                                            height: 1,
                                            color: Colors.black,
                                          ),),
                                        SizedBox(width: 10,),
                                        Text(': الوقت ',textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'AmiriQuran',
                                            height: 1,
                                            color: Colors.grey[700],
                                          ),),
                                        SizedBox(width: 10,)
                                      ],
                                    ),
                                    SizedBox(height: 9,),
                                    Container(
                                      width: MediaQuery.of(context).size.width-30,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.grey[300]
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(snapshot.data.documents[index]['uid'].toString(),textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'AmiriQuran',
                                            height: 1,
                                            color: Colors.black,
                                          ),),
                                        SizedBox(width: 5,),
                                        Text(': Uid  ',textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'AmiriQuran',
                                            height: 1,
                                            color: Colors.grey[700],
                                          ),),
                                        SizedBox(width: 10,)
                                      ],
                                    ),
                                    SizedBox(height: 9,),
                                    Container(
                                      width: MediaQuery.of(context).size.width-30,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.grey[300]
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(snapshot.data.documents[index]['kind'],textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'AmiriQuran',
                                            height: 1,
                                            color: Colors.black,
                                          ),),
                                        SizedBox(width: 10,),
                                        Text(': النوع ',textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'AmiriQuran',
                                            height: 1,
                                            color: Colors.grey[700],
                                          ),),
                                        SizedBox(width: 10,)
                                      ],
                                    ),
                                    SizedBox(height: 9,),
                                    Container(
                                      width: MediaQuery.of(context).size.width-30,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.grey[300]
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.grey[200],
                                      ),
                                      width: MediaQuery.of(context).size.width-20,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 4,horizontal: 5),
                                        child: RichText(
                                          textAlign: TextAlign.right,
                                            textDirection: TextDirection.rtl,
                                            text: TextSpan(

                                                children: [
                                                  TextSpan(
                                                    text:' النص : ',
                                                    style: TextStyle(
                                                      color: Colors.teal.shade700,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: "AmiriQuran",
                                                      height: 1,
                                                      fontSize: 17,
                                                      wordSpacing: 2,
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text: snapshot.data.documents[index]['message'],
                                                    style: TextStyle(
                                                      color: Colors.teal.shade900,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: "AmiriQuran",
                                                      height: 1,
                                                      fontSize: 18,

                                                    ),
                                                  ),


                                                ]
                                            )
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 9,),
                                    Container(
                                      width: MediaQuery.of(context).size.width-30,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.grey[300]
                                      ),
                                    ),
                                    Center(
                                      child: InkWell(
                                          onTap: (){
                                            Firestore.instance
                                                .collection('Complaints and Suggestions').document(snapshot
                                                .data
                                                .documents[
                                            index]
                                                .documentID)
                                                .delete()
                                                .then((value) {
                                              print(
                                                  'delete done');
                                            });
                                          },
                                          child: Icon(Icons.delete_forever,color: Colors.red,size: 30,)),
                                    ),
                                Container(
                                  width: MediaQuery.of(context).size.width-30,
                                  height: 1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.red[300],
                                  ),
                                )],
                                ),
                              ),
                            ),
                          );
                          }
                      ),
                    ),
                    Align(
                      alignment: Alignment(-0.8, -1),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 14,horizontal: 20),
                        child: Card(
                          color: Colors.grey[200],
                          elevation: 6,
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              child: Text("العدد ${snapshot.data.documents.length.toString()}")),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: InkWell(
                        onTap: () {
                          showSearch(
                              context: context,
                              delegate: SearchComplaintsAndSuggestionsAdmin(collection: 'Complaints and Suggestions'));
                        },
                        child: Container(
                          height: 42,
                          width: 280,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.grey[350]),
                          child: Stack(
                            alignment: Alignment(-0.2, 0),
                            children: <Widget>[
                              Text('!... إبحث في قائمة الشكاوى والإقتراحات',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'AmiriQuran',
                                    height: 1,
                                  )),
                              Align(
                                  alignment: Alignment(0.9, 0),
                                  child: Icon(
                                    Icons.search,
                                    size: 28,
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
