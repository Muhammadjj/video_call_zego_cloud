import 'package:video_call_zego_cloud/Export/export.dart';

abstract class ZEGOCloudTheme {
  // 主题颜色
  static ThemeData zegoCloudTheme = ThemeData(
    fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple,
        actionsIconTheme: IconThemeData(color: Colors.white)),
  );
}
