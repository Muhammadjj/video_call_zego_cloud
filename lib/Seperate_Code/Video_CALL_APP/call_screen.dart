import 'package:flutter/material.dart';
import '../Utils/zego_cloud_info.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatefulWidget {
  const CallPage({
    Key? key,
  }) : super(key: key);
  // final String callID;

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  String userID = DateTime.now().millisecondsSinceEpoch.toString();
  String userName = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appID: ZegoCloudInfo.appID,
      // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      appSign: ZegoCloudInfo.appSign,
      userID: userID,
      userName: userName,
      callID: "my_name_is_jawad",
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
