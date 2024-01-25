import 'package:video_call_zego_cloud/Seperate_Code/Utils/zego_cloud_info.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../Export/export.dart';

class ZimVideoCall extends StatefulWidget {
  const ZimVideoCall({super.key, required this.callID, required this.userID});
  final String callID;
  final String userID;
  @override
  State<ZimVideoCall> createState() => _ZimVideoCallState();
}

class _ZimVideoCallState extends State<ZimVideoCall> {
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        appID: ZegoCloudInfo.appID,
        appSign: ZegoCloudInfo.appSign,
        callID: widget.callID,
        userID: widget.userID,
        userName: "User ${widget.userID}",
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall());
  }
}
