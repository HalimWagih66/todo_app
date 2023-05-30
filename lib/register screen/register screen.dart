import 'package:flutter/material.dart';
import 'package:todo_app/register%20screen/validation%20Email.dart';
import '../shared/components/TextFormField/custom_form_field.dart';
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("assets/images/register screen/register_background.png"),
          fit: BoxFit.fill,
        )
      ),
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
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.25,
                  ),
                  CustomFormField(
                      textLabel: "Full Name",
                    inputField: fullNameController,
                    functionValidate: (text){
                        if(text?.isEmpty == true || text?.trim().isEmpty == true){
                          return "Please Enter Name";
                        }
                        if(text?.contains(" ") == false){
                          return "Please enter at least the binary name";
                        }
                    },
                    BorderField: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,style: BorderStyle.solid,width: 2)
                    ),
                    prefix_Icon: Icons.person,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                    textLabel: "E-mail Address",
                    inputField: emailController,
                    functionValidate: (text){
                      if(text?.isEmpty == true || text?.trim().isEmpty == true){
                        return "Please Enter E-mail Address";
                      }
                      if(!ValidationEmail.isEmail(text!)){
                        return "Please enter the email correctly";
                      }
                    },
                    BorderField: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue,style: BorderStyle.solid,width: 2)
                    ),
                    prefix_Icon: Icons.email,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                    textLabel: "Password",
                    inputField: passwordController,
                    functionValidate: (text){
                      if(text == null || text?.isEmpty == true || text?.trim().isEmpty == true){
                        return "Please Enter Password";
                      }
                      if(text!.length < 6){
                        return "Please enter a password that is more than 6 digits";
                      }
                    },
                    BorderField: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue,style: BorderStyle.solid,width: 1)
                    ),
                    onPressedsuffix_Icon: (){
                      isHidePassword = !isHidePassword;
                      eyePassword  = isHidePassword == true ? Icons.remove_red_eye:Icons.remove_red_eye_outlined;
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
                    textLabel: "Confirm Password",
                    inputField: passwordConfirmationController,
                    functionValidate: (text){
                      if(text == null || text?.isEmpty == true || text?.trim().isEmpty == true){
                        return "Please Enter Confirm Password";
                      }
                      if(text != passwordController.text){
                        return "This password does not match the main password";
                      }
                    },
                    BorderField: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue,style: BorderStyle.solid,width: 1)
                    ),
                    onPressedsuffix_Icon: (){
                      isHidePassword = !isHidePassword;
                      eyePassword  = isHidePassword == true ? Icons.remove_red_eye:Icons.remove_red_eye_outlined;
                      setState(() {});
                    },
                    prefix_Icon: Icons.password,
                    suffix_Icon: eyePassword,
                    obscure_Text: isHidePassword,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.07,),
                  ElevatedButton(onPressed: (){
                    createAccount();
                  }, child: Container(
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Create Account",style: TextStyle(color: Colors.grey,fontSize: 18)),
                       Icon(Icons.arrow_forward_outlined,color: Colors.grey),
                     ],
                   ),
                  ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 33),
                      backgroundColor: Colors.white,
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  TextButton(onPressed: (){}, child: Text("I already have an account")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void createAccount(){
    formKey.currentState?.validate();
  }
}
