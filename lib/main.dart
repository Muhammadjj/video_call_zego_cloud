import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import 'package:video_call_zego_cloud/Components/Widgets/call_theme.dart';
import 'package:video_call_zego_cloud/Seperate_Code/Utils/zego_cloud_info.dart';

import 'Export/export.dart';
import 'View_Zego_Cloud/Live_Streaming/live_streaming_login_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initial Zego Cloud Chat init()
  await ZIMKit()
      .init(appID: ZegoCloudInfo.appID, appSign: ZegoCloudInfo.appSign);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Use this check Android Orientation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(const VideoCallChatApp());
}

class VideoCallChatApp extends StatefulWidget {
  const VideoCallChatApp({super.key});

  @override
  State<VideoCallChatApp> createState() => _VideoCallChatAppState();
}

class _VideoCallChatAppState extends State<VideoCallChatApp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Video Call Chat App',
        theme: ZEGOCloudTheme.zegoCloudTheme,
        // home: auth.currentUser == null ? const LoginPage() : const HomePage(),
        home: const LiveStreamingLoginPage());
  }
}
