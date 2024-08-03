

import 'package:flutter/material.dart';
import 'package:jobhub/services/helpers/otp_api.dart';
import 'package:jobhub/views/ui/auth/ootp_verification.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class OtpLoginPage extends StatefulWidget {
  const OtpLoginPage({super.key});

  @override
  State<OtpLoginPage> createState() => _OtpLoginPageState();
}

class _OtpLoginPageState extends State<OtpLoginPage> {
  String email='';
  bool isAPIcallProcess=false;
  GlobalKey<FormState> globalKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
      body: ProgressHUD(
        inAsyncCall: isAPIcallProcess,
        opacity: .3,
        key:UniqueKey(),
        child:Form(child: loginUI(),
        key:globalKey,
        ),

      ),
    ) );
  }
  
  loginUI() {
    return  Center (
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Login with Email",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),
          const Text("Enter wemail id ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

          FormHelper.inputFieldWidget(
            context,
            "email",
            "Email id",
            (onValidateVal){
              if(onValidateVal.isEmpty){
                return 'Required';
              }
            },
            (onSaved){
              email = onSaved;
            },
            borderRadius: 10,
            borderColor: Colors.grey,
          ),
          const SizedBox(height: 10,),
          FormHelper.submitButton("Continue", (){
                       if(validateAndSave())   {
                        setState(() {
                            isAPIcallProcess=true;
                        });

                        APIService.otpLogin(email).then((response) {
                          setState(() {
                            isAPIcallProcess=false;
                        });
                        if(response.data!=null){
                          // otp verifcation page
                          Navigator.pushAndRemoveUntil(
                            context, 
                            MaterialPageRoute(builder: (context)=>OOTPVerificationPage(
                              otpHash: response.data,
                              email:email
                            )), (route) => false);
                        }
                        });
                      
                       }
          })
        ],
      ),
    );
  }
  bool validateAndSave(){
    final form = globalKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }
    return false;
  }
}
