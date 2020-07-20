import 'package:firebase_database/firebase_database.dart';

class AdsModel {
  String _id ;
  int _uid;
  String _category;
  String _name ;
  String _time ;
  String _status ;
  String _description ;
  String _area ;
  double _price;
  String _emailUser ;
  String _deviceNo;
  String _image1;
  String _image2;
  String _image3;
  String _image4;
  String _image5;
  String _image6;
  String _image7;
  int _phone;


  AdsModel(
      this._id,
      this._uid,
      this._category,
      this._name,
      this._time,
      this._status,
      this._description,
      this._area,
      this._price,
      this._emailUser,
      this._deviceNo,
      this._image1,
      this._image2,
      this._image3,
      this._image4,
      this._image5,
      this._image6,
      this._image7,
      this._phone);

  AdsModel.map(dynamic obj){
    this._id = obj['id'];
    this._uid = obj['uid'];
    this._name = obj['name'];
    this._category = obj['category'];
    this._time = obj['time'];
    this._status = obj['statues'];
    this._description = obj['description'];
    this._area = obj['area'];
    this._price = obj['price'];
    this._emailUser = obj['emailUser'];
    this._deviceNo = obj['image1'];
    this._image1 = obj['image2'];
    this._image2 = obj['image3'];
    this._image3 = obj['image4'];
    this._image4 = obj['image5'];
    this._image5 = obj['image5'];
    this._image6 = obj['image6'];
    this._image7 = obj['image7'];
    this._phone = obj['phone'];
  }

  String get id => _id;
  int get uid => _uid;
  String get name => _name;
  String get category => _category;
  String get time => _time;
  String get statues => _status;
  String get description => _description;
  String get area => _area ;
  double get price => _price;
  String get emailUser => _emailUser ;
  String get deviceNo => _deviceNo;
  String get image1 => _image1;
  String get image2 => _image2;
  String get image3 => _image3;
  String get image4 => _image4;
  String get image5 => _image5;
  String get image6 => _image6;
  String get image7 => _image7;
  int get phone => _phone;

  AdsModel.FromSnapShot(DataSnapshot snapshot){
    _id = snapshot.key;
    _uid = snapshot.value['uid'];
    _category = snapshot.value['category'];
    _name = snapshot.value['name'];
    _time = snapshot.value['time'];
    _status = snapshot.value['statues'];
    _description = snapshot.value['description'];
   _area = snapshot.value['area'] ;
   _price = snapshot.value['price'];
    _emailUser = snapshot.value['emailUser'];
    _deviceNo = snapshot.value['deviceNo'];
    _image1 = snapshot.value['image1'];
    _image2 = snapshot.value['image2'];
    _image3 = snapshot.value['image3'];
    _image4 = snapshot.value['image4'];
    _image5 = snapshot.value['image5'];
    _image6 = snapshot.value['image6'];
    _image7 = snapshot.value['image7'];
    _phone = snapshot.value['phone'];
  }

  toSnapShot(){
    var value = {
    'uid':_uid,
      'category':_category,
      'name' : _name,
      'time': _time,
      'statues': _status,
      'description': _description,
    'area':_area ,
    'price':_price,
    'emailUser':_emailUser ,
    'deviceNo':_deviceNo,
    'image1':_image1,
    'image2':_image2,
    'image3':_image3,
    'image4':_image4,
    'image5':_image5,
    'image6':_image6,
    'image7':_image7,
      'phone':_phone,
    };
    return value;
  }

}