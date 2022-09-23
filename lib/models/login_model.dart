import 'dart:ui';

import 'package:almatjar/screens/login_screen.dart';

class LoginModel
{
late bool status  ;
 late String ? message ;
late UserData  data = UserData() ;
LoginModel();
 LoginModel.fromJson (Map json )
 {
status = json['status'];
message = json['message'];
data =  UserData.fromJson(json['data']) ;
 }
}
class UserData {
 late int ? id ;
 late String ? name ;
 late String ? email ;
 late String ?phone ;
 late String ? image ;
 late String ? token ;
 late int ? points ;
 late int ? credit ;
 UserData({
  this.id,
  this.name,
  this.email,
  this.phone,
  this.image ,
  this.token ,
  this.points ,
  this.credit
});
UserData.fromJson (Map json){
 id = json['id'];
 name = json['name'];
 email = json['email'];
 phone = json['phone'];
 image = json['image'];
 token = json['token'];
 points = json['points'];
 credit = json['credit'];
}
}