import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almatjar/network/local/shared_prefrences.dart';
import 'package:almatjar/screens/home_screen.dart';
import 'package:almatjar/screens/login_screen.dart';
import 'package:almatjar/screens/onboarding.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'network/remote/dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();

 bool ? islogin = await CacheHelper.getData(key: 'login') ;
  bool ? onboarding =await CacheHelper.getData(key: 'onBoarding');
   String ? token = await CacheHelper.getData(key: 'token');
 // islogin = onboarding = true ;
  print ('token : $token');
 Widget startPage = OnBoardingScreen() ;
 if (token != null){
   startPage = const MainScreen();
 }
 if (onboarding != null){
   if (islogin == true){
     startPage = const MainScreen();
   }
   else {
     startPage = const LoginScreen();
        }
 }
  BlocOverrides.runZoned(
        (){},
    blocObserver: MyBlocObserver(),);
  runApp(MyApp(startPage));
}

class MyApp extends StatelessWidget {
final Widget StartScreen ;
  const MyApp(this.StartScreen, {Key? key}) : super(key: key,);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (BuildContext  context )=>ShopCubit()..getHomeData()..getCategoriesData()..getUserDate()..getFavData(),
      child:  BlocConsumer<ShopCubit ,
          ShopStates>(listener: (context ,state){},builder: (context, state){ return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          fontFamily: 'MyFont',
        ),
        home:  MainScreen(),
      );},),);
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }

}