import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sooq1alzour/models/PageRoute.dart';
import 'package:sooq1alzour/ui/EditAd.dart';
import 'package:sooq1alzour/ui/ShowAds.dart';

class SerchAdsAdmin extends SearchDelegate<String>{
  String collection ;
  SerchAdsAdmin({this.collection});
  Future<List<DocumentSnapshot>> _future() async{
    QuerySnapshot querySnapshot=await Firestore.instance.collection(collection).getDocuments();
    final List<DocumentSnapshot> snap = querySnapshot.documents.where((DocumentSnapshot documentSnapshot) => documentSnapshot["name"].toString().toLowerCase().contains(query.toLowerCase())||documentSnapshot.documentID.toString().toLowerCase().contains(query.toLowerCase())).toList();
    return snap;
  }
  final word=["كلمات البحث","تاهو للبيع","ايفون برو",];
  final recWord=["كلمات البحث","تاهو للبيع","ايفون برو",];
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
                  return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: swidth*0.002),
                    itemBuilder: (BuildContext context, int index){
                      return SerchListAds_Admin(snapshot.data[index]);
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
class SerchListAds_Admin extends StatelessWidget{
  final DocumentSnapshot lis;
  SerchListAds_Admin(this.lis);

  @override
  Widget build(BuildContext context) {
    double swidth=MediaQuery.of(context).size.width;
    double sheight=MediaQuery.of(context).size.height;
    return Padding(
      padding:  EdgeInsets.only(left: swidth*0.01,right: swidth*0.01,bottom:0.01,top: 0.01),

      child:ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          child: InkWell(
            onTap: (){
              idD=lis.documentID;
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ShowAd(documentId: idD)));

              },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(swidth*0.050),
              child: Container(
                width:swidth,
                height: sheight*0.15,
                child: SizedBox(
                  height: 300,
                  child: Card(
                    color: Colors.white,
                    elevation: 1,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 1,
                          right:0,
                          bottom: 50,
                          child: Container(
                            width:210,
                            child: Image.network(lis["imagesUrl"][0],fit: BoxFit.fill,height: 230,),
                          ),
                        ),
                        Positioned(
                          bottom: sheight*0.01,
                          right: 1,
                          child: Container(
                              padding: EdgeInsets.all(swidth*0.007),
                              height: sheight * 0.09,
                              //width: MediaQuery.of(context).size.width*0.75,
                              decoration:  BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Colors.black.withOpacity(0.5),
                                // set border width
                                // set rounded corner radius
                                // make rounded corner of border
                              ),
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Text(lis["name"],style: TextStyle(color: Colors.white,fontSize: sheight*0.014,fontWeight: FontWeight.bold),),
                                    Text(lis["area"],style: TextStyle(color: Colors.white,fontSize: sheight*0.014,fontWeight: FontWeight.bold),),
                                    Text("${lis["price"]}",style: TextStyle(color: Colors.white,fontSize: sheight*0.014,fontWeight: FontWeight.bold),),
                                    Text("${lis["uid"]}",style: TextStyle(color: Colors.white,fontSize: sheight*0.011,fontWeight: FontWeight.bold),),
                                    Text("${lis["time"]}",style: TextStyle(color: Colors.white,fontSize: sheight*0.010,fontWeight: FontWeight.bold),),


                                  ],
                                ),
                              )
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Firestore.instance
                                .collection('Ads')
                                .document(lis.documentID)
                                .delete()
                                .then((value) {
                              print(
                                  'delete done');
                            });
                          },
                            child: Icon(Icons.delete_forever,color: Colors.red,size: 28,)),
                        Positioned(
                          right: 3,
                            child: InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      BouncyPageRoute(
                                          widget: EditAd(documentId:lis.documentID,)));
                                },
                                child: Icon(Icons.edit,color: Colors.blue,size: 28)))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
      ),

    ) ;
  }

}
/*
 print(desc.contains("${query}")||cat.contains("${query}")||dep.contains("${query}"));
 */