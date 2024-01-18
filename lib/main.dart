import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:video_call_zego_cloud/Components/Widgets/call_theme.dart';
import 'package:video_call_zego_cloud/Screens/Auth/Login_Page/login_page_main.dart';
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
      home: auth.currentUser == null ? const LoginPage() : const HomePage(),
    );
  }
}
