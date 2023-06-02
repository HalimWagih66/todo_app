import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/provider_application.dart';
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
  int maxLines;
  int minLines;
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
        this.onPressedsuffix_Icon,
        this.maxLines = 1,
        this.minLines = 1,
      });

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ProviderApplication>(context);
    return TextFormField(
      keyboardType: textInputType,
      obscureText: obscure_Text,
      controller: inputField,
      validator: functionValidate,
      maxLines: maxLines,
      minLines: minLines,
      style: TextStyle(fontFamily: fontFamily,color: appProvider.isDarkEnabled()?Color(
          0xffdadada):Colors.black,letterSpacing: 1.5,),
      decoration: InputDecoration(
        labelStyle: TextStyle(
          fontFamily: "Poppins",
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.grey
        ),
        enabledBorder:BorderField?.copyWith(borderSide: BorderSide(width: 1,style: BorderStyle.solid,color: Colors.grey.shade300)),
        focusedBorder: BorderField,
        errorBorder: BorderField?.copyWith(borderSide: BorderSide(width: 1,style: BorderStyle.solid,color: Colors.red)),
        label: Text(textLabel),
        prefixIcon: prefix_Icon != null ?Icon(
          prefix_Icon,color: Colors.grey,
        ):null,

        suffixIcon: IconButton(
          onPressed: (){
            if(onPressedsuffix_Icon == null){
              return;
            }
            onPressedsuffix_Icon!();
          },
          icon: Icon(
            suffix_Icon,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
