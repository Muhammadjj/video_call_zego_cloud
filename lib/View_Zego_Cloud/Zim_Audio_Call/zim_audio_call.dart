import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../Export/export.dart';
import '../Components/Utils/zego_cloud_info.dart';

class ZimAudioCall extends StatefulWidget {
  const ZimAudioCall({super.key, required this.callID, required this.userID});
  final String callID;
  final String userID;
  @override
  State<ZimAudioCall> createState() => _ZimVideoCallState();
}

class _ZimVideoCallState extends State<ZimAudioCall> {
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        appID: ZegoCloudInfo.appID,
        appSign: ZegoCloudInfo.appSign,
        callID: widget.callID,
        userID: widget.userID,
        userName: "User ${widget.userID}",
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall());
  }
}
