import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:almatjar/network/local/shared_prefrences.dart';
import 'package:almatjar/screens/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
List <OnBoarding> items =[
  OnBoarding(image: 'assets/images/onboard_1.jpg',
    title: 'OnBord Title..1', body: 'OnBord Title..1'
),OnBoarding(image: 'assets/images/onboard_2.jpg',
      title: 'OnBord Title..2', body: 'OnBord Title..2'
  ),OnBoarding(image: 'assets/images/shop.png',
      title: 'OnBord Title..3', body: 'OnBord Title..3'
  )];

var pageController = PageController();
bool islast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white10,
          elevation: 0,
          actions: [TextButton(onPressed: () {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
          }, child: Text('SKIP'))],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index) async {
                    if (index == items.length-1) {
                      setState(() async{
                        islast = true;
                      await CacheHelper.saveData(key: 'onBoarding', value: true);
                      }
                      );

                    }
                  },
                  controller: pageController,
                  physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => PageBuilder(items[index],
                    ),itemCount: items.length)
              ),

            SizedBox(height: 40,),
              Row(
                children: [
                SmoothPageIndicator(controller: pageController, count: items.length,
                  effect: ExpandingDotsEffect(
                      activeDotColor: Colors.deepOrange, radius: 20,dotHeight: 10,dotWidth: 10 ,spacing: 4)
                  ,),
                  Spacer(),
                  FloatingActionButton(

                    onPressed: () {
                      islast? Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false) :
                      pageController.nextPage
                      (duration: Duration(milliseconds: 300), curve:Curves.ease );
                      },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

class OnBoarding {
  String image = '';
  String title = '';
  String body = '';
  OnBoarding({required this.image, required this.title, required this.body});
}

Widget PageBuilder(OnBoarding item) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
           Image(
        image: AssetImage(
          '${item.image}',
        ),
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      SizedBox(
        height: 40,
      ),
      Text(
        '${item.title}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        '${item.body}',
        style: TextStyle(
          fontSize: 18,
        ),
      )
    ],
  );
}
