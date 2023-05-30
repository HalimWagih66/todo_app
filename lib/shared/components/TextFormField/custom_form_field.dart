import 'package:flutter/material.dart';
typedef FunctionValidate = String? Function(String?);
class CustomFormField extends StatelessWidget {
  TextEditingController inputField;
  FunctionValidate functionValidate;
  bool obscure_Text;
  TextInputType textInputType;
  String textLabel;
  IconData? prefix_Icon;
  IconData? suffix_Icon;
  String fontFamily;
  InputBorder? BorderField;
  Function? onPressedsuffix_Icon;
  CustomFormField(
      {required this.inputField,
      required this.functionValidate,
      this.obscure_Text = false,
      this.textInputType = TextInputType.text,
      required this.textLabel,
      this.prefix_Icon,
      this.suffix_Icon,
      this.fontFamily = "Poppins",
       this.BorderField,
        this.onPressedsuffix_Icon
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      obscureText: obscure_Text,
      controller: inputField,
      validator: functionValidate,
      style: TextStyle(fontFamily: fontFamily),
      decoration: InputDecoration(
        labelStyle: TextStyle(
          fontFamily: "Poppins",
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.black
        ),
        enabledBorder:BorderField?.copyWith(borderSide: BorderSide(width: 1,style: BorderStyle.solid,color: Colors.grey.shade300)),
        focusedBorder: BorderField,
        errorBorder: BorderField?.copyWith(borderSide: BorderSide(width: 1,style: BorderStyle.solid,color: Colors.red)),
        label: Text(textLabel),
        prefixIcon: Icon(
          prefix_Icon,
        ),

        suffixIcon: IconButton(
          onPressed: (){
            if(onPressedsuffix_Icon == null){
              return;
            }
            onPressedsuffix_Icon!();
          },
          icon: Icon(
            suffix_Icon,
          ),
        ),
      ),
    );
  }
}
