import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopsmart/Common/APIConst.dart';
import 'package:shopsmart/Pages/SplashPage.dart';
import 'package:shopsmart/Validators/FormValidator.dart';
//import 'package:shopsmart/Pages/SignupPage.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// import 'package:shopsmart/Pages/AuthPage.dart';

final _formKeySplashPage = GlobalKey<FormState>();

final _namefield = GlobalKey<FormFieldState>();
final _emailfield = GlobalKey<FormFieldState>();
final _passwordfield = GlobalKey<FormFieldState>();
final _confirmpasswordfield = GlobalKey<FormFieldState>();


class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final myController = TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController passwordCompareController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();

  String textHolder = '';
  bool hide = true;
  bool _isShown = false;

  changeText(String txt) {
    setState(() {
      textHolder = txt;
    });
  }

  final userPool = CognitoUserPool(
    'ap-southeast-2_1Ek5jHjmc',
    'xxx',
  );

  static const PrimaryColor = Color.fromARGB(255, 16, 14, 24);


  //added code
  late String _password;
  double _strength = 0;
  // 0: No password
  // 1/4: Weak
  // 2/4: Medium
  // 3/4: Strong
  // 1: Great

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  String _displayText = 'Please enter a password';

   _checkPassword(String value) {
    _password = value.trim();

    if (_password.isEmpty) {
      setState(() {
        _strength = 0;
        _displayText = 'Please enter you password';
      });
    } else if (_password.length < 6) {
      setState(() {
        _strength = 1 / 4;
        _displayText = 'Your password is too short';
      });
    } else if (_password.length < 8) {
      setState(() {
        _strength = 2 / 4;
        _displayText = 'Your password is acceptable but not strong';
      });
    } else {
      if (!letterReg.hasMatch(_password) || !numReg.hasMatch(_password)) {
        setState(() {
          // Password length >= 8
          // But doesn't contain both letter and digit characters
          _strength = 3 / 4;
          _displayText = 'Your password is strong';
        });
      } else {
        // Password length >= 8
        // Password contains both letter and digit characters
        setState(() {
          _strength = 1;
          _displayText = 'Your password is great';
        });
      }
    }
    print(_displayText);
    // return _displayText;

  }



  @override
  Widget build(BuildContext context) {

    // new page needs scaffolding!
    return Scaffold(
      body: Container(
          color: PrimaryColor,
          child: Form(
            key: _formKeySplashPage,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 32.0,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/img/Shopsmart3(S).jpg',
                              scale: 2.5),
                          SizedBox(
                            height: 20,
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: TextFormField(
                      key: _namefield,
                      onChanged: (value) async {
                        setState(() {
                          _isShown = false;
                        });
                        _namefield.currentState!.validate();
                      },
                      // onChanged: (value) => _checkPassword(value),
                      maxLength: 200,
                      autofocus: true,
                      controller: nameController,
                      decoration: new InputDecoration(
                          // errorStyle: TextStyle(color: Colors.orange),
                          enabledBorder: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(133, 103, 172, 1),
                                width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: (Color.fromRGBO(133, 103, 172, 1)),
                                width: 2.0),
                          ),
                          border: const OutlineInputBorder(),
                          labelStyle: new TextStyle(
                            color: Color.fromRGBO(133, 103, 172, 1),
                          ),
                          labelText: 'Name'),
                      style: TextStyle(color: Color.fromRGBO(133, 103, 172, 1)),
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      validator: (String? value) {
                        return FormValidator.validateName(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: TextFormField(
                      key: _emailfield,
                      onChanged: (value) async {
                        setState(() {
                          _isShown = false;
                        });
                        _emailfield.currentState!.validate();
                      },
                      maxLength: 200,
                      autofocus: true,
                      controller: emailController,
                      decoration: new InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(133, 103, 172, 1),
                                width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: (Color.fromRGBO(133, 103, 172, 1)),
                                width: 2.0),
                          ),
                          border: const OutlineInputBorder(),
                          labelStyle: new TextStyle(
                            color: Color.fromRGBO(133, 103, 172, 1),
                          ),
                          labelText: 'Email'),
                      style: TextStyle(color: Color.fromRGBO(133, 103, 172, 1)),
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                        validator: (String? value) {
                          return FormValidator.validateEmail(value);
                        },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: TextFormField(
                      key: _passwordfield,
                      onChanged: (value) async {
                        setState(() {
                          _isShown = false;
                        });
                        _passwordfield.currentState!.validate();
                      },
                      obscureText: true,
                      maxLength: 200,
                      autofocus: true,
                      controller: passwordController,
                      decoration: new InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(133, 103, 172, 1),
                                width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: (Color.fromRGBO(133, 103, 172, 1)),
                                width: 2.0),
                          ),
                          border: const OutlineInputBorder(),
                          labelStyle: new TextStyle(
                            color: Color.fromRGBO(133, 103, 172, 1),
                          ),
                          labelText: 'Password'),
                      style: TextStyle(color: Color.fromRGBO(133, 103, 172, 1)),
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      validator: (String? value) {
                        return FormValidator.validatePassword(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: TextFormField(
                      key: _confirmpasswordfield,
                      // onChanged: (value) => _checkPassword(value),
                      onChanged: (value) async {
                        setState(() {
                          _isShown = false;
                        });
                        _confirmpasswordfield.currentState!.validate();
                      },
                      obscureText: true,
                      maxLength: 200,
                      autofocus: true,
                      controller: passwordCompareController,
                      decoration: new InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(133, 103, 172, 1),
                                width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: (Color.fromRGBO(133, 103, 172, 1)),
                                width: 2.0),
                          ),
                          border: const OutlineInputBorder(),
                          labelStyle: new TextStyle(
                            color: Color.fromRGBO(133, 103, 172, 1),
                          ),
                          labelText: 'Confirm Password'),
                      style: TextStyle(color: Color.fromRGBO(133, 103, 172, 1)),
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      validator: (String? value) {
                        String password=passwordController.text;
                        return FormValidator.validateConfirmPassword(value, password);
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Visibility(
                        visible: _isShown,
                        child: Text('\u26A0 $textHolder',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(236, 28, 36, 1))),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Builder(
                      builder: (context) {
                        // The basic Material Design action button.
                        return ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _isShown = false;
                            });
                            if (_formKeySplashPage.currentState!.validate()) {
                              try {
                                final cognitoUser =
                                    CognitoUser(emailController.text, userPool);
                                final authDetails = AuthenticationDetails(
                                  username: emailController.text,
                                  password: passwordController.text,
                                );

                                final CognitoUserSession session;
                                session = (await cognitoUser
                                    .authenticateUser(authDetails))!;
                              } on CognitoClientException catch (e) {
                                setState(() {
                                  _isShown = true;
                                });
                                debugPrint(e.code.toString());
                                //debugPrint(e.code! == 'UserNotFoundException');
                                if (e.code.toString() ==
                                    'UserNotFoundException') {
                                  changeText(APIConst.ACCOUNT_NOT_FOUND);
                                }
                              }
                              // debugPrint('cognitoUser');
                              // debugPrint(cognitoUser.authenticationFlowType);
                              // debugPrint('authDetails');
                              // debugPrint(authDetails.validationData.entries
                              //     .toString());
                              // debugPrint('session');
                              // debugPrint(session.isValid().toString());
                              // debugPrint(
                              //     session.accessToken.jwtToken.toString());
                              //debugPrint('inside the validation');

                              // if (user != null) {
                              //   debugPrint(user.emailVerified.toString());

                              //   if (!user.emailVerified) {
                              //     setState(() {
                              //       hide = !hide;
                              //     });
                              //     return changeText(
                              //         'Please verify your email before logging in');
                              //   }

                              //   return changeText('you\'re in!');
                              // } else if (user == null) {
                              //   setState(() {
                              //     hide = !hide;
                              //   });
                              //   return changeText(
                              //       'Unable to locate your details');
                              // }

                            }
                          },
                          child: Text('Create Shopsmart Account'),
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(133, 103, 172, 1),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 0),
                              textStyle: const TextStyle(fontSize: 18)),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      onPressed: () {},
                      child: const Text('Forgot Password?',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(133, 103, 172, 1))),
                    ),
                  ),
                  Column(children: <Widget>[
                    Row(
                      children: <Widget>[],
                    ),
                    Row(children: <Widget>[
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: Divider(
                              color: Color.fromRGBO(133, 103, 172, 1),
                              height: 36,
                            )),
                      ),
                      Text(
                        "OR",
                        style: const TextStyle(
                            color: Color.fromRGBO(133, 103, 172, 1)),
                      ),
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              color: Color.fromRGBO(133, 103, 172, 1),
                              height: 36,
                            )),
                      ),
                    ]),
                    Row(
                      children: <Widget>[],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Builder(
                        builder: (context) {
                          // The basic Material Design action button.
                          return ElevatedButton(
                            onPressed: () {
                              debugPrint('pressed');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SplashPage()));
                            },
                            child: Text('Login'),
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(133, 103, 172, 1),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 4),
                                textStyle: const TextStyle(fontSize: 18)),
                          );
                        },
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          )),
    );
  }
}
