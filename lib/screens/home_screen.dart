import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almatjar/cubit/cubit.dart';
import 'package:almatjar/cubit/states.dart';

import '../models/home_model.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer <ShopCubit , ShopStates>(  listener: (context ,state){},
        builder: (context, state){
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              CircleAvatar(
                child: Image(
                  image: AssetImage('assets/images/matjar.png'),
                ),
                backgroundColor: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text('Almatjar', style:  TextStyle(color: Colors.black),)
            ],
          ),
        ),
        body: cubit.Pages[cubit.current],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.deepOrange,
          color: Colors.white,
          items: cubit.bottomItems,
          index: cubit.current,
          height: ((5.7/100)*MediaQuery.of(context).size.height),
          animationDuration: Duration(milliseconds: 500,),
          onTap: (index) {
            cubit.Change(index);
          },

        ),

      );});
  }
}
