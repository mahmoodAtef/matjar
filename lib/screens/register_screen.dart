import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isvisible = false;
    var registerEmailController = TextEditingController();
    var registerPasswordController = TextEditingController();
    var confirmRegisterPasswordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white10,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        'REGISTER',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: registerEmailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty){
                            return 'Please enter Email Address';
                          }
                        },
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
                        controller: registerPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isvisible ? false : true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  isvisible = isvisible;
                                },
                                icon: isvisible
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility)),
                            labelText: 'Password'),
                        validator: (value) {
                          if (value!.isEmpty){
                            return 'Please enter Password';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: confirmRegisterPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isvisible ? false : true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  isvisible = isvisible;
                                },
                                icon: isvisible
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility)),
                            labelText: 'Confirm Password'),
                        validator: (value) {
                          if (value!.isEmpty){
                            return 'Please Confirm Password';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: () {
                          formKey.currentState!.validate();
                        },
                        child: Text(
                          'Create account',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: Colors.deepOrange,
                        minWidth: double.infinity,
                        height: 45,
                      )
                    ]),
              ),
            ),
          ),
        ));
  }
}
