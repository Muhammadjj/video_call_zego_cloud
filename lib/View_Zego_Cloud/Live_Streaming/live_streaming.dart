import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

import '../Components/Utils/zego_cloud_info.dart';

class LiveStreamingBasePage extends StatefulWidget {
  const LiveStreamingBasePage({super.key});

  @override
  State<LiveStreamingBasePage> createState() => _LiveStreamingBasePageState();
}

class _LiveStreamingBasePageState extends State<LiveStreamingBasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Zego Cloud Zim Login Page.'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ZegoLiveStream(
                            userId: "111111",
                            userName: "Start Live Stream",
                            liveId: "123123"),
                      ));
                },
                child: const Text("Start Live Stream")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ZegoLiveStream(
                            userId: "121212",
                            userName: "Join",
                            liveId: "123123"),
                      ));
                },
                child: const Text("Join Live Stream")),
          ],
        ));
  }
}

// ! Live Streaming Separate Code .
class ZegoLiveStream extends StatefulWidget {
  const ZegoLiveStream(
      {super.key,
      required this.userId,
      required this.userName,
      required this.liveId});
  final String userId;
  final String userName;
  final String liveId;
  @override
  State<ZegoLiveStream> createState() => _ZegoLiveStreamState();
}

class _ZegoLiveStreamState extends State<ZegoLiveStream> {
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltLiveStreaming(
        appID: ZegoCloudInfo.appID,
        appSign: ZegoCloudInfo.appSign,
        userID: widget.userId,
        userName: widget.userName,

        /// ! hm jb live id ko pass krwaty ha to hmy apne (Admin) aur apny new (joiner) ki live
        /// ! id same rkne ha q ka agr ak jase id ho ge to (Admin) aur new (Joiner) ak hi id
        /// ! pr apni talking kr skty ha .
        liveID: widget.liveId,
        config: widget.userId == "111111"
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience());
  }
}
