import 'dart:convert';

OtpLoginResModel otpLoginResModel(String str)=> OtpLoginResModel.fromJson(
  json.decode(str),
);

class OtpLoginResModel {
  OtpLoginResModel({
    required this.message,
    this.data,

  });

  late final String message;
  late final String? data;

  OtpLoginResModel.fromJson(Map<String,dynamic> json){
    message=json['message'];
    data=json['data'];
  }

  Map<String,dynamic> toJson(){
    final data=<String,dynamic>{};
    data["message"]=message;
    data["data"]=data;

    return data;
  }





}