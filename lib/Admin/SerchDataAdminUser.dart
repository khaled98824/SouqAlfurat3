import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class SerchDataAdmin extends SearchDelegate<String>{
  String collection ;
  SerchDataAdmin({this.collection});
  Future<List<DocumentSnapshot>> _future() async{
    QuerySnapshot querySnapshot=await Firestore.instance.collection(collection).getDocuments();
    final List<DocumentSnapshot> snap = querySnapshot.documents.where((DocumentSnapshot documentSnapshot) => documentSnapshot["name"].toString().toLowerCase().contains(query.toLowerCase())||documentSnapshot["user_uid"].toString().toLowerCase().contains(query.toLowerCase())).toList();
    return snap;
  }
  final word=["كلمات البحث","احمد","خالد العلي",];
  final recWord=["كلمات البحث","احمد","خالد العلي",];
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
        height: sheight*0.85,
        width: swidth,
        color: Colors.transparent,
        child: MediaQuery.removePadding(context: context,removeTop: true,
            child:FutureBuilder<List<DocumentSnapshot>>(
              future: _future(), // async work
              builder: (BuildContext context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: swidth*0.002),
                    itemBuilder: (BuildContext context, int index){

                      return SerchListAdminUsers(snapshot.data[index]);
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

/////////////

class SerchListAdminUsers extends StatelessWidget{
  final DocumentSnapshot lis;
  SerchListAdminUsers(this.lis);
  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SizedBox(
        height: 200,
        child: Card(
            child: Padding(
              padding: EdgeInsets.only(right: 6,left: 6,top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text('${lis['name']}',style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'AmiriQuran',
                      height: 1),),
                  SizedBox(height: 10,),
                  Text('${lis['area']}',style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'AmiriQuran',
                      height: 1),),
                  SizedBox(height: 10,),
                  Text('${lis['time']}',style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'AmiriQuran',
                      height: 1),),
                  SizedBox(height: 22,),
                  Text('User Uid :\n\n${lis['user_uid']}',style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'AmiriQuran',
                      color: Colors.red,
                      height: 1),),
                  SizedBox(height: 3,),
                  Container(
                    height: 2,
                    color: Colors.grey,
                  ),
//                Row(
//                  children: <Widget>[
//                    InkWell(
//                      onTap: (){
//                        Firestore.instance
//                            .collection('users')
//                            .document(lis['user_uid'])
//                            .delete()
//                            .then((value) {
//                          print('delete done');
//                        });
//                      },
//                        child: Icon(Icons.delete_forever,color: Colors.red,))
//                  ],
//                )

                ],
              ),
            )

        ),
      ),
    );


  }

}
