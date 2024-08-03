import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/services/helpers/ip_info_api.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/drawer/drawer_widget.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/ui/auth/login.dart';
import 'package:jobhub/views/ui/device_mgt/widgets/device_info.dart';
import 'package:provider/provider.dart';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceManagement extends StatefulWidget {
   const DeviceManagement({super.key});


  @override
  State<DeviceManagement> createState() => _DeviceManagementState();
}

class _DeviceManagementState extends State<DeviceManagement> {

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
   Map<String, dynamic> map = {};

  @override
  void initState() {
    super.initState();
        initPlatformState();
            init();

    
  }
  Future init() async {

    // final ipAddress = await IpInfoApi.getIPAddress();
    final ipAddress = await IpInfoApi.getIPAddress();


    if (!mounted) return;

    setState(() => map = {
        'IP Address': ipAddress,
         
          

        
        });
  }
     
  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    deviceData =   _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    setState(() {
      _deviceData = deviceData;
    });
  }


      Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
  

      'manufacturer': build.manufacturer,
      'model': build.model,
     

    };
  }

  @override
  Widget build(BuildContext context) {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    var onBoarding = Provider.of<OnBoardNotifier>(context);
    String date = DateTime.now().toString();
    var loginDate = date.substring(0, 11);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Device Management",
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: const DrawerWidget(),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpacer(size: 50),
                  Text(
                    "You are logged in into your account on these devices",
                    style: appstyle(16, Color(kDark.value), FontWeight.normal),
                  ),
                  const HeightSpacer(size: 50),
          
                
                  DevicesInfo(
                    date: loginDate,
                    device: '${_deviceData['manufacturer']}  ${_deviceData['model']} ',
                    ipAdress: '${map['IP Address']}',
                    location: 'Una',
                    platform: 'Mobile App',
                  )
                ],
              ),
            ),
            Consumer<LoginNotifier>(
              builder: (context, loginNotifier, child) {
                return Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: GestureDetector(
                    onTap: () {
                      zoomNotifier.currentIndex = 0;
                      loginNotifier.logout();
                      onBoarding.isLastPage = false;
                      Get.to(() => const LoginPage());
                    },
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ReusableText(
                          text: "Sign out from all devices",
                          style: appstyle(
                              16, Color(kOrange.value), FontWeight.w600)),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
