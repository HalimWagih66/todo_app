import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/database/models/user.dart' as MyUser;
import 'package:todo_app/login/login%20screen.dart';
import 'package:todo_app/provider/auth_provider.dart';
import 'package:todo_app/register%20screen/validation%20Email.dart';
import '../database/my_database.dart';
import '../provider/provider_application.dart';
import '../shared/components/TextFormField/custom_form_field.dart';
import '../shared/components/dialog/dialog utils.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isHidePassword = true;

  IconData eyePassword = Icons.remove_red_eye;

  TextEditingController fullNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordConfirmationController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ProviderApplication>(context);
    return Container(
      decoration: BoxDecoration(
          color: appProvider.getColorApplication(),
          image: DecorationImage(
            image: AssetImage(
                "assets/images/register screen/register_background.png"),
            fit: BoxFit.fill,
          )
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.create_account),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.25,
                  ),
                  CustomFormField(
                    textLabel: AppLocalizations.of(context)!.full_name,
                    inputField: fullNameController,
                    functionValidate: (text) {
                      if (text?.isEmpty == true || text
                          ?.trim()
                          .isEmpty == true) {
                        return AppLocalizations.of(context)!.please_enter_your_name;
                      }
                      if (text?.contains(" ") == false) {
                        return AppLocalizations.of(context)!.please_enter_at_least_the_binary_name;
                      }
                    },
                    BorderField: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue,
                            style: BorderStyle.solid,
                            width: 2)
                    ),
                    prefix_Icon: Icons.person,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                    textLabel: AppLocalizations.of(context)!.email_address,
                    inputField: emailController,
                    functionValidate: (text) {
                      if (text?.isEmpty == true || text
                          ?.trim()
                          .isEmpty == true) {
                        return AppLocalizations.of(context)!.please_enter_email_address;
                      }
                      if (!ValidationEmail.isEmail(text!)) {
                        return AppLocalizations.of(context)!.please_enter_the_email_correctly;
                      }
                    },
                    BorderField: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue,
                            style: BorderStyle.solid,
                            width: 2)
                    ),
                    prefix_Icon: Icons.email,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                    textLabel: AppLocalizations.of(context)!.password,
                    inputField: passwordController,
                    functionValidate: (text) {
                      if (text == null || text?.isEmpty == true || text
                          ?.trim()
                          .isEmpty == true) {
                        return AppLocalizations.of(context)!.please_enter_password;
                      }
                      if (text!.length < 6) {
                        return AppLocalizations.of(context)!.please_enter_a_password_that_is_more_than_6_digits;
                      }
                    },
                    BorderField: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue,
                            style: BorderStyle.solid,
                            width: 1)
                    ),
                    onPressedsuffix_Icon: () {
                      isHidePassword = !isHidePassword;
                      eyePassword =
                      isHidePassword == true ? Icons.remove_red_eye : Icons
                          .remove_red_eye_outlined;
                      setState(() {});
                    },
                    prefix_Icon: Icons.password,
                    suffix_Icon: eyePassword,
                    obscure_Text: isHidePassword,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                    textLabel: AppLocalizations.of(context)!.confirm_password,
                    inputField: passwordConfirmationController,
                    functionValidate: (text) {
                      if (text == null || text?.isEmpty == true || text
                          ?.trim()
                          .isEmpty == true) {
                        return AppLocalizations.of(context)!.please_enter_Confirm_password;
                      }
                      if (text != passwordController.text) {
                        return AppLocalizations.of(context)!.this_password_does_not_match_the_main_password;
                      }
                    },
                    BorderField: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue,
                            style: BorderStyle.solid,
                            width: 1)
                    ),
                    onPressedsuffix_Icon: () {
                      isHidePassword = !isHidePassword;
                      eyePassword =
                      isHidePassword == true ? Icons.remove_red_eye : Icons
                          .remove_red_eye_outlined;
                      setState(() {});
                    },
                    prefix_Icon: Icons.password,
                    suffix_Icon: eyePassword,
                    obscure_Text: isHidePassword,
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * .07,),
                  ElevatedButton(onPressed: () {
                    createAccount();
                  }, child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.create_account,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: appProvider.isDarkEnabled()?Colors.black:Colors.grey)),
                        Icon(Icons.arrow_forward_outlined, color: appProvider.isDarkEnabled()?Colors.black:Colors.grey),
                      ],
                    ),

                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 15, horizontal: 33),
                      backgroundColor: appProvider.isDarkEnabled() ? Theme.of(context).primaryColor:Color(0xffDFECDB),
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  TextButton(onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, LoginScreen.routeName);
                  }, child: Text(AppLocalizations.of(context)!.i_already_have_an_account)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void createAccount() async {
    if (formKey.currentState?.validate() == false) return;
    try {
      DialogUtils.dialogLoading(context);
      var result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      MyUser.User user = MyUser.User(id: result.user?.uid ?? "",email: emailController.text,name: fullNameController.text);
      MyDataBase.addUser(result.user?.uid ?? "", user);
      var authProvider = Provider.of<AuthProvider>(context,listen: false);
      authProvider.updateUser(user);
      var appProvider = Provider.of<ProviderApplication>(context,listen: false);
      appProvider.changeLoginInUser(false);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(
          context: context,message:  AppLocalizations.of(context)!.your_account_has_been_successfully_registered,
          dialogType: DialogType.success, posActionName: AppLocalizations.of(context)!.ok, posAction: () {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        DialogUtils.showMessage(context: context,title: AppLocalizations.of(context)!.weak_password,message: AppLocalizations.of(context)!.the_password_provided_is_too_weak,dialogType: DialogType.error);
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.showMessage(context: context,title: AppLocalizations.of(context)!.email_address,message: AppLocalizations.of(context)!.the_account_already_exists_for_that_email,dialogType: DialogType.error);
      }
    } catch (e) {
      DialogUtils.showMessage(context: context,title: AppLocalizations.of(context)!.something_went_error,message: e.toString(),dialogType: DialogType.error);
    }
  }
}
