import 'package:flutter/material.dart';
import 'package:sooq1alzour/ui/Home.dart';

class SearchUi extends StatefulWidget {

  static const String id = "SearchUi";

  @override
  _SearchUiState createState() => _SearchUiState();
}

class _SearchUiState extends State<SearchUi> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 10)),
          Heade(),
          SearchArea()
        ],
      )
    );
  }
}

class SearchArea extends StatefulWidget {
  @override
  _SearchAreaState createState() => _SearchAreaState();
}

class _SearchAreaState extends State<SearchArea> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 15,right:2,left: 10),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: 340,
                  height: 50,
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueAccent),
                          borderRadius:
                          BorderRadius.circular(
                              55)),
                      alignLabelWithHint: true,
                      hintText:
                      '!... إبحث في سوق الزور',
                      fillColor: Colors.white,
                      hoverColor: Colors.white,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 6)),
                InkWell(
                    onTap: (){
                     Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 40,
                      textDirection: TextDirection.rtl,))
              ],
            )

        ),
      ],
    );
  }
}

