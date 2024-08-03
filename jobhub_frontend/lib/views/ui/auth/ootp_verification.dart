
import 'package:flutter/material.dart';
import 'package:jobhub/services/helpers/otp_api.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class OOTPVerificationPage extends StatefulWidget {
  final String? email;
  final String? otpHash;
  
  const OOTPVerificationPage({super.key, this.email, this.otpHash});

  @override
  State<OOTPVerificationPage> createState() => _OOTPVerificationPageState();
}

class _OOTPVerificationPageState extends State<OOTPVerificationPage> {
  String otpCode='';
  bool isAPIcallProcess=false;
  GlobalKey<FormState> globalKey=GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
      body: ProgressHUD(
        inAsyncCall: isAPIcallProcess,
        opacity: .3,
        key:UniqueKey(),
        child:Form(child: lloginVerificationUI(),
        key:globalKey,
        ),

      ),
    ) );
  }
  
  lloginVerificationUI() {
    return  Center (
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Verification code",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Enter 4 digit code that you receive on your email ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),

          SizedBox(
            width: 200,
            child: FormHelper.inputFieldWidget(
              context,
              "code",
              "",
              (onValidateVal){
                if(onValidateVal.isEmpty){
                  return 'Required';
                }
              },
              (onSaved){
                otpCode = onSaved;
              },
              borderRadius: 10,
              borderColor: Colors.grey,
              maxLength: 4,
              isNumeric: true
            ),
          ),
          const SizedBox(height: 10,),
          FormHelper.submitButton("Continue", (){
                       if(validateAndSave())   {
                        setState(() {
                            isAPIcallProcess=true;
                        });

                        APIService.verifyOTP(widget.email!,widget.otpHash!,otpCode).then((response) {
                          setState(() {
                            isAPIcallProcess=false;
                        });
                        if(response.data!=null){
                          // otp verifcation page
                          FormHelper.showSimpleAlertDialog(
                            context, 
                            "email verified",
                             response.message,
                              "OK",
                               (){
                                Navigator.pop(context);
                               }
                               );
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
