import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skolio/bloc/authenticationBloc.dart';
import 'package:skolio/model/userModel.dart';
import 'package:skolio/widgets/authentication/loadingDialog.dart';
import 'package:skolio/widgets/main/emailVerificationDialog.dart';
import 'package:skolio/widgets/general/halfCircleWidget.dart';
import 'package:skolio/widgets/general/ownTextField.dart';
import 'package:skolio/widgets/general/scrollBehavior.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordAgainController = TextEditingController();

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
                            "Registrierung",
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
                    textEditingController: _nameController,
                    hintText: "Name",
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
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: OwnTextField(
                    textEditingController: _passwordAgainController,
                    hintText: "Passwort bestätigen",
                    obscure: true,
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 66,
                  child: ElevatedButton(
                    onPressed: onPressedRegister,
                    child: Text("Registrieren"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onPressedRegister() async {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Es muss ein Name angegeben sein."),
        ),
      );
      return;
    }

    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Es muss eine Email Adresse angegeben sein."),
        ),
      );
      return;
    }

    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Es muss eine Passwort angegeben sein."),
        ),
      );
      return;
    }

    if (_passwordAgainController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Bitte bestätige dein Passwort."),
        ),
      );
      return;
    }

    if (_passwordController.text != _passwordAgainController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Die beiden Passwörter stimmen nicht überein."),
        ),
      );
      return;
    }

    showDialog(context: context, builder: (context) => LoadingDialog());

    UserModel userModel = UserModel.fromMap(
      {
        "uid": "",
        "username": _nameController.text,
        "email": _emailController.text,
        "trainingPlan": [],
      },
      {},
    );

    final result = await authenticationBloc.registerUser(
      userModel,
      _passwordController.text,
    );

    Navigator.pop(context);

    if (result.code == "200") {
      Navigator.pop(context);

      showDialog(
        context: context,
        builder: (context) => EmailVerificationDialog(),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.arguments["message"]),
        ),
      );
    }
  }
}
