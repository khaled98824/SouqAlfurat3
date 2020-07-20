import 'package:flutter/material.dart';
import 'package:sooq1alzour/Admin/Users.dart';
import 'package:sooq1alzour/models/PageRoute.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('لوحة التحكم',style: TextStyle(
              fontSize: 24,
              fontFamily: 'AmiriQuran',
              height: 1),),
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 200)),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width - 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red[900]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12, bottom: 12,right: 2),
                child: InkWell(
                  onTap: () {
                      Navigator.push(context, BouncyPageRoute(widget: UsersAdmin()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.arrow_back_ios,
                        size: 36,
                      ),
                      SizedBox(width: 100,),
                      SizedBox(width: 100,),
                      SizedBox(width: 22,),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text(
                          'المستخدمين',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'AmiriQuran',
                              height: 0.6),
                        ),
                      ),
                      Icon(Icons.supervised_user_circle,color: Colors.blue,size: 34,)
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width - 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red[900]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12, bottom: 12,right: 5),
                child: InkWell(
                  onTap: () {

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.arrow_back_ios,
                        size: 36,
                      ),
                      SizedBox(width: 100,),
                      SizedBox(width: 100,),
                      SizedBox(width: 22,),
                      Padding(
                        padding: EdgeInsets.only(right: 25),
                        child: Text(
                          'الإعلانات',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'AmiriQuran',
                              height: 1),
                        ),
                      ),
                      Icon(Icons.burst_mode,color: Colors.blue,size: 34,)
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width - 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red[900]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12, bottom: 12,right: 5),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.arrow_back_ios,
                        size: 36,
                      ),
                      SizedBox(width: 100,),
                      SizedBox(width: 100,),
                      SizedBox(width: 22,),
                      Padding(
                        padding: EdgeInsets.only(right: 22),
                        child: Text(
                          'التعليقات',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'AmiriQuran',
                              height: 1),
                        ),
                      ),
                      Icon(Icons.comment,color: Colors.blue,size: 34,)
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width - 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red[900]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12, bottom: 12,right: 5),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.arrow_back_ios,
                        size: 36,
                      ),
                      SizedBox(width: 40,),
                      SizedBox(width: 22,),
                      Padding(
                        padding: EdgeInsets.only(right: 32),
                        child: Text(
                          'صندوق الشكاوى والملاحضات',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'AmiriQuran',
                              height: 0.6),
                        ),
                      ),
                      Icon(Icons.markunread_mailbox,color: Colors.blue,size: 34,)
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width - 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red[900]),
              ),
            ],
          ),
        ));
  }
}
