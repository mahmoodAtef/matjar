import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almatjar/cubit/cubit.dart';
import 'package:almatjar/cubit/states.dart';
import 'package:almatjar/network/local/shared_prefrences.dart';
import 'package:almatjar/screens/login_screen.dart';

import '../models/login_model.dart';
class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key) ;
  @override
  Widget build(BuildContext context) {

      var model = LoginModel();
      ShopCubit.get(context).getUserDate().then((value) => {model = ShopCubit.get(context).userModel,
         });
      var nameController = TextEditingController();
      var phoneController = TextEditingController();
      var emailController = TextEditingController();

    return  BlocConsumer<ShopCubit ,ShopStates>(builder: (context, state) =>
       state is ShopGetUserLoadingState ? Center(child: CircularProgressIndicator(),):
      Center(child:   Padding(padding: EdgeInsets.all(20)
          ,child:
          SingleChildScrollView(child: Column(
            mainAxisAlignment: MainAxisAlignment.center, children: [
            CircleAvatar(radius :55,backgroundImage:  NetworkImage('${model.data.image}')),
            SizedBox(height: 20,),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Name must\'t be empty';
                }
              },
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return  ' email must\'t be empty';
                }
              },
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)),
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return  'phone must\'t be empty';
                }
              },
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            SizedBox(height: 20,)
            ,  MaterialButton(
              onPressed: () {},
              child: Text(
                'Update Data',
                style: TextStyle(
                    color: Colors.white, fontSize: 20),
              ),
              color: Colors.deepOrange,
              height: 45,
              elevation: 5,
            ),
            SizedBox(height: 10,),
            Text('OR'),
            MaterialButton(height: 45,onPressed: (){
              CacheHelper.removeData(key: 'token');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },child: Row(children: [
              Text('Log out',style: TextStyle(fontSize: 18),),Icon(Icons.logout)
            ],mainAxisAlignment: MainAxisAlignment.center,),)
          ],),)),),
        listener: (context ,state){state is !ShopGetUserLoadingState ? { print ('name :'+model.data.name!),
        nameController.text = '${model.data.name}',
          emailController.text = '${model.data.email}',
          phoneController.text = '${model.data.phone}'}:
    print('data');});
  }
}


