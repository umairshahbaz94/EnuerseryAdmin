import 'package:enersuryadmin/Gardner.dart';
import 'package:enersuryadmin/ProductManage/Product.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:sign_button/sign_button.dart';

class LoginScreen1 extends StatefulWidget {
  static final routename = 'login';
  @override
  _LoginScreen1State createState() => _LoginScreen1State();
}

class _LoginScreen1State extends State<LoginScreen1> {
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //       Provider.of<Currentlocation>(context, listen: false).currentlocation();
  // }
  // final GlobalKey<FormState> _formKey = GlobalKey();
  // var _isLoading = false;
  // Map<String, String> _authData = {
  //   'email': '',
  //   'password': '',
  // };

  // void _showErrorDialog(String message) {
  //   showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: Text(message),
  //       content: Text(message),
  //       actions: <Widget>[
  //         TextButton(
  //           child: Text('Okay'),
  //           onPressed: () {
  //             Navigator.of(ctx).pop();
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  bool remember = false;
  final List<String> errors = [];

  void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({required String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // if all are valid then go to success screen

      if ("admin@gmail.com" == email) {
        var pass = "Admin123";

        if (pass==password) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProdcut()),
            );
        } else {
          EasyLoading.showError("Admin Not Found");
        }
      }
      else
      {

        try {
          EasyLoading.show(status: 'loading...');
          final newUser = await _auth.signInWithEmailAndPassword(
              email: email, password: password);
          print(email);
          if (newUser != null) {
            EasyLoading.dismiss();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Gardner()),
            );
            // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
            //successfully login
            //
            //navigate the user to main page
            // i am just showing toast message here
          }
        } catch (e) {
          EasyLoading.showError('Login Password Not Match');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
            onWillPop: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen1()),
          );

          return new Future(() => false);
        },
          child: Scaffold(
        drawer: Drawer(child: ListTile(leading: Text("LOGOUT")),),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        child: Column(
                          children: <Widget>[
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  "WELCOME ",
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: (MediaQuery.of(context).size.width -
                                            MediaQuery.of(context).padding.top) *
                                        0.060,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 15.0),
                                    child: Icon(
                                      Icons.person_outline,
                                      color: Color(0xff8d43d6),
                                    ),
                                  ),
                                  Container(
                                    height: 10.0,
                                    width: 1.0,
                                    color: Colors.grey.withOpacity(0.5),
                                    margin: const EdgeInsets.only(
                                        left: 00.0, right: 10.0),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        border: InputBorder.none,
                                        hintText: 'Enter your Email Address',
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 10),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            !value.contains('@')) {
                                          return 'Invalid email!';
                                        }
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          email = value;
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 15.0),
                                    child: Icon(
                                      Icons.lock_open,
                                      color: Color(0xff8d43d6),
                                    ),
                                  ),
                                  Container(
                                    height: 10.0,
                                    width: 1.0,
                                    color: Colors.grey.withOpacity(0.5),
                                    margin: const EdgeInsets.only(
                                        left: 00.0, right: 10.0),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        border: InputBorder.none,
                                        hintText: 'Enter your Password here',
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 10),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty || value.length < 6) {
                                          return 'Password is too short!';
                                        }
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          password = value;
                                        });
                                      },
                                      obscureText: true,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 10),
                                ),
                                onPressed: () {
                                  // Navigator.of(context).pushNamed(
                                  //   ForgotPasswordScreen.route,
                                  // );
                                },
                                child: const Text('Forgot Password?'),
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        )),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.symmetric(
                                                    vertical: 1,
                                                    horizontal:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            MediaQuery.of(context)
                                                                .padding
                                                                .top) *
                                                0.08),
                                        backgroundColor:
                                            MaterialStateProperty.all(Color(
                                                0xff8d43d6)), // <-- Button color
                                        overlayColor: MaterialStateProperty
                                            .resolveWith<Color?>((states) {
                                          if (states
                                              .contains(MaterialState.pressed))
                                            return Color(
                                                0xffB788E5); // <-- Splash color
                                        }),
                                      ),
                                      child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2.0),
                                              child: Text(
                                                "Login",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontStyle: FontStyle.italic),
                                              ),
                                            ),
                                            Transform.translate(
                                              offset: Offset(15.0, 0.0),
                                              child: Container(
                                                // padding: const EdgeInsets.on(1.0),
                                                child: TextButton(
                                                  child: Icon(
                                                    Icons.arrow_forward,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () => {
                                                    // Navigator.of(context)
                                                    //     .pushReplacementNamed(
                                                    //   HomeScreen.route,
                                                    // )
                                                    _submit()
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      onPressed: () => {_submit()},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 2.0),
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          child: FittedBox(
                                              child: Text(
                                                  "Don\'t have an account?"))),
                                      // Container(
                                      //   child: TextButton(
                                      //     style: TextButton.styleFrom(
                                      //       textStyle:
                                      //           const TextStyle(fontSize: 10),
                                      //     ),
                                      //     onPressed: () {
                                      //       // Navigator.push(
                                      //       //   context,
                                      //       //   MaterialPageRoute(
                                      //       //       builder: (context) =>
                                      //       //           Mysignuppage()),
                                      //       // );
                                      //     },
                                      //     child:
                                      //         const Text('Create new account.'),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Text(
                                      "OR",
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FittedBox(
                              child: Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                //padding: const EdgeInsets.only(left: 20.0),
                                child: SignInButton(
                                    width: 130,
                                    btnText: "Facebook",
                                    buttonType: ButtonType.facebook,
                                    buttonSize: ButtonSize.small,
                                    onPressed: () {}),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5.0),
                              //padding: const EdgeInsets.only(left: 20.0),
                              child: SignInButton(
                                  width: 130,
                                  btnText: "Google",
                                  buttonType: ButtonType.google,
                                  buttonSize: ButtonSize.small,
                                  onPressed: () {
                                    print('click');
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
