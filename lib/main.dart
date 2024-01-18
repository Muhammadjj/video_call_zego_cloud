import 'package:flutter/services.dart';
import 'package:video_call_zego_cloud/Components/Widgets/call_theme.dart';
import 'package:video_call_zego_cloud/Screens/Auth/Sign_Up_Page/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Export/export.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Use this check Android Orientation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(const VideoCallChatApp());
}

class VideoCallChatApp extends StatelessWidget {
  const VideoCallChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Call Chat App',
      theme: ZEGOCloudTheme.zegoCloudTheme,
      home: const SignUpPage(),
    );
  }
}
