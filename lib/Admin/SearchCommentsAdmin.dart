import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SerchCommentsAdmin extends SearchDelegate<String>{
  String collection ;
  SerchCommentsAdmin({this.collection});
  Future<List<DocumentSnapshot>> _future() async{
    QuerySnapshot querySnapshot=await Firestore.instance.collection(collection).getDocuments();
    final List<DocumentSnapshot> snap = querySnapshot.documents.where((DocumentSnapshot documentSnapshot) => documentSnapshot["name"].toString().toLowerCase().contains(query.toLowerCase())||documentSnapshot["text"].toString().toLowerCase().contains(query.toLowerCase())).toList();
    return snap;
  }
  final word=["كلمات البحث","إبلاغ عن صورة","محمد",];
  final recWord=["كلمات البحث","إبلاغ عن صورة","محمد",];
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(icon: Icon(Icons.clear),onPressed: (){query="";},)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: (){close(context, null);},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    double swidth=MediaQuery.of(context).size.width;
    double sheight=MediaQuery.of(context).size.height;
    return query!=""?
    Center(
      child: Container(
        height: sheight*0.87,
        width: swidth,
        color: Colors.transparent,
        child: MediaQuery.removePadding(context: context,removeTop: true,
            child:FutureBuilder<List<DocumentSnapshot>>(
              future: _future(), // async work
              builder: (BuildContext context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: swidth*0.0026),
                    itemBuilder: (BuildContext context, int index){
                      return SerchListComments_Admin(snapshot.data[index]);
                    },itemCount: snapshot.data.length,);
                }
              },
            )
        ),
      ),
    ):Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList=query.isEmpty?recWord:word.where((p)=>p.startsWith(query)).toList();
    // TODO: implement buildSuggestions
    return ListView.builder(itemBuilder: (context,index)=>ListTile(
      onTap: (){
        //showResults(context);

      },
      leading: Icon(Icons.search),
      title: RichText(
        text: TextSpan(
          text: suggestionList[index].substring(0,query.length),
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          children: [
            TextSpan(text: suggestionList[index].substring(query.length),
                style: TextStyle(color: Colors.grey))
          ],
        ),
      ),
    ),
      itemCount: suggestionList.length,
    );
  }

}
String idD;
class SerchListComments_Admin extends StatelessWidget{
  final DocumentSnapshot lis;
  SerchListComments_Admin(this.lis);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Padding(
        padding: EdgeInsets.only(top: 5),
        child: Card(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text( lis.data['name'],textAlign: TextAlign.right,
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
                  Text( lis.data['date'],textAlign: TextAlign.right,
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
                  Text( lis.data['Ad_id'].toString(),textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'AmiriQuran',
                      height: 1,
                      color: Colors.black,
                    ),),
                  SizedBox(width: 5,),
                  Text(': Ad_id  ',textAlign: TextAlign.right,
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
                  padding: EdgeInsets.only(top: 5,right: 2,left: 2,bottom: 3),
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
                              text: lis.data['text'],
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
                          .collection('messages').document(lis.documentID)
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

}
/*
 print(desc.contains("${query}")||cat.contains("${query}")||dep.contains("${query}"));
 */