import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database/models/user.dart' as MyUser;
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/layout%20screen/home%20screen.dart';
import 'package:todo_app/register%20screen/register%20screen.dart';
import 'package:todo_app/register%20screen/validation%20Email.dart';
import 'package:todo_app/shared/components/dialog/dialog%20utils.dart';
import '../provider/auth_provider.dart';
import '../shared/components/TextFormField/custom_form_field.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHidePassword = true;

  IconData eyePassword = Icons.remove_red_eye;
  TextEditingController emailController = TextEditingController(text: "halemwagih6@gmail.com");

  TextEditingController passwordController = TextEditingController(text: "1234567890");

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(
                "assets/images/register screen/register_background.png"),
            fit: BoxFit.fill,
          )),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create Account"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.27,
                  ),
                  Text("Welcome Back!",
                      style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  CustomFormField(
                    textLabel: "E-mail Address",
                    inputField: emailController,
                    functionValidate: (text) {
                      if (text?.isEmpty == true ||
                          text?.trim().isEmpty == true) {
                        return "Please Enter E-mail Address";
                      }
                      if (!ValidationEmail.isEmail(text!)) {
                        return "Please enter the email correctly";
                      }
                    },
                    BorderField: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue,
                            style: BorderStyle.solid,
                            width: 2)),
                    prefix_Icon: Icons.email,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                    textLabel: "Password",
                    inputField: passwordController,
                    functionValidate: (text) {
                      if (text == null ||
                          text?.isEmpty == true ||
                          text?.trim().isEmpty == true) {
                        return "Please Enter Password";
                      }
                      if (text!.length < 6) {
                        return "Please enter a password that is more than 6 digits";
                      }
                    },
                    BorderField: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue,
                            style: BorderStyle.solid,
                            width: 1)),
                    onPressedsuffix_Icon: () {
                      isHidePassword = !isHidePassword;
                      eyePassword = isHidePassword == true
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined;
                      setState(() {});
                    },
                    prefix_Icon: Icons.password,
                    suffix_Icon: eyePassword,
                    obscure_Text: isHidePassword,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .07,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Login",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18)),
                          Icon(Icons.arrow_forward_outlined,
                              color: Colors.grey),
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 33),
                      backgroundColor: Colors.white,
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RegisterScreen.routeName);
                      },
                      child: Center(
                          child: Text(
                        "I don't have an account",
                        textAlign: TextAlign.center,
                      ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == false) return;
    try {
      DialogUtils.dialogLoading(context);
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      MyUser.User? user = await MyDataBase.readUser(result.user?.uid ?? "");
      var authProvider = Provider.of<AuthProvider>(context,listen: false);
      if(user == null){
        DialogUtils.showMessage(context: context,title: "Erorr", message: "Dear, this account is not registered before, please read the data again", dialogType: DialogType.error,posActionName: "Ok");
        return;
      }
      authProvider.updateUser(user);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(
          context: context,
          title: "Registration Successful",
          message: "Do you want to go to the home screen",
          posActionName: "Ok",
          posAction: () {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
          dialogType: DialogType.success);
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == 'user-not-found') {
        DialogUtils.showMessage(
            context: context,
            title: "User Not Found",
            message: 'No user found for that email.',
            dialogType: DialogType.error,
            nigActionName: "Cancel");
      } else if (e.code == 'wrong-password') {
        Text('Wrong password provided for that user.');
        DialogUtils.showMessage(
            context: context,
            title: "wrong password",
            message: 'Wrong password provided for that user.',
            dialogType: DialogType.error,
            nigActionName: "Cancel");
      }
    }
  }
}
