import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almatjar/cubit/cubit.dart';
import 'package:almatjar/cubit/states.dart';
import 'package:almatjar/screens/register_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../network/local/shared_prefrences.dart';
import '../pages/home_page.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    bool isvisible = false;


    return BlocProvider(
      create: (BuildContext context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state)async {
          if(state is ShopLoginSuccessfulState){
         await   CacheHelper.saveData(key: 'login', value : true );
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context)=>HomePage()),
                  (route) => false);
        }},
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                    child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 3,
                            ),
                            Image(
                              image: AssetImage('assets/images/matjar.png'),
                            ),
                            Text('Almatjar')
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Email Address';
                          }
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            prefixIcon: Icon(Icons.email_outlined),
                            labelText: 'Email Address'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: isvisible
                            ? TextInputType.text
                            : TextInputType.visiblePassword,
                        obscureText: isvisible ? false : true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Password';
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  isvisible = !isvisible;
                                  ShopCubit.get(context)
                                      .changeVisiblity(isvisible);},
                                icon: !isvisible
                                    ? Icon(Icons.visibility_outlined)
                                    : Icon(Icons.visibility_off)),
                            labelText: 'Password'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      state is! ShopLoginLoadingState ? MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                  context: context);
                                }
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              color: Colors.deepOrange,
                              minWidth: double.infinity,
                              height: 45,
                              elevation: 5,
                            )
                          : CircularProgressIndicator(
                              color: Colors.deepOrange,
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account ?'),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
                              },
                              child: Text('Register Now'))
                        ],
                      )
                    ],
                  ),
                )),
              ),
            ),
          );
        },
      ),
    );
  }
}