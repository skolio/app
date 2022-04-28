import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skolio/bloc/authenticationBloc.dart';
import 'package:skolio/screens/authentication/registerScreen.dart';
import 'package:skolio/screens/mainScreen.dart';
import 'package:skolio/widgets/authentication/loadingDialog.dart';
import 'package:skolio/widgets/main/infoDialog.dart';
import 'package:skolio/widgets/ownSnackBar.dart';
import 'package:skolio/widgets/general/ownTextField.dart';
import 'package:skolio/widgets/general/halfCircleWidget.dart';
import 'package:skolio/widgets/general/scrollBehavior.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Skolio"),
      ),
      body: ScrollConfiguration(
        behavior: OwnScrollBevahior(),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                kToolbarHeight,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.15 - 30,
                      ),
                      child: HalfCircle(),
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.15,
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(bottom: 5, left: 30),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset("assets/icons/panda.svg"),
                          SizedBox(width: 10),
                          Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 33,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 10),
                          SvgPicture.asset(
                            "assets/icons/panda.svg",
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: OwnTextField(
                    textEditingController: _emailController,
                    hintText: "Email",
                    textType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: OwnTextField(
                    textEditingController: _passwordController,
                    hintText: "Passwort",
                    obscure: true,
                  ),
                ),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    child: TextButton(
                      onPressed: () {
                        if (_emailController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            getSnackBar(
                                context, "Bitte gib deine Email Adresse an."),
                          );
                          return;
                        }
                        authenticationBloc
                            .forgotPassword(_emailController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          getSnackBar(
                            context,
                            "Dir wurde eine Email mit den Instruktionen zum Zurücksetzten deines Passwortes gesendet.",
                          ),
                        );
                      },
                      child: Text(
                        "Passwort vergessen?",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 66,
                  child: ElevatedButton(
                    onPressed: onPressedLogin,
                    child: Text("Login"),
                  ),
                ),
                Spacer(),
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      height: 1.2,
                    ),
                    children: [
                      TextSpan(
                        text: "Noch keinen Account?\n",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: "Hier Registrieren",
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).primaryColor,
                        ),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onPressedLogin() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        getSnackBar(
          context,
          "Es muss eine Email Adresse eingegeben werden.",
        ),
      );
      return;
    }

    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        getSnackBar(
          context,
          "Es muss ein Passwort eingegeben werden.",
        ),
      );
      return;
    }

    showDialog(context: context, builder: (context) => LoadingDialog());

    final result = await authenticationBloc.loginUser(
      _emailController.text,
      _passwordController.text,
    );

    Navigator.pop(context);

    if (result.code != "200") {
      ScaffoldMessenger.of(context).showSnackBar(
        getSnackBar(
          context,
          result.arguments["message"],
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => InfoDialog(),
    );
  }
}
