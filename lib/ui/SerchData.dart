
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sooq1alzour/ui/SerchList.dart';
class SerchData extends SearchDelegate<String>{
  Future<List<DocumentSnapshot>> _future() async{
    QuerySnapshot querySnapshot=await Firestore.instance.collection("Ads").getDocuments();
    final List<DocumentSnapshot> snap = querySnapshot.documents.where((DocumentSnapshot documentSnapshot) => documentSnapshot["description"].toString().toLowerCase().contains(query.toLowerCase())||documentSnapshot["category"].toString().toLowerCase().contains(query.toLowerCase())).toList();
    return snap;
  }
  final word=["كلمات البحث","مثل سيارة","مثل الكترونيات",];
  final recWord=["كلمات البحث","مثل سيارة","مثل الكترونيات",];
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
                  return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: swidth*0.003),
                    itemBuilder: (BuildContext context, int index){

                      return SerchList(snapshot.data[index]);
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
/*
.where('description',isGreaterThanOrEqualTo: "${query}").where('description',isLessThanOrEqualTo: "${query}\uF7FF").snapshots(),
 */
/*
StreamBuilder(
              stream: _future(),
              builder: (context, snapshot){
                snapshot.data.documents.where((data) => data.description == query);

                if(!snapshot.hasData) return const Text("انتظر ........");
                return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: swidth*0.003),
                  itemBuilder: (BuildContext context, int index){
                    print(snapshot.data.documents[index]["description"]);
                  return snapshot.data.documents[index]["description"].toString().contains(query)||snapshot.data.documents[index]["category"].toString().contains(query)?SerchList(snapshot.data.documents[index], query):Container();
                  },itemCount: snapshot.data.documents.length,);
              },
            )
 */