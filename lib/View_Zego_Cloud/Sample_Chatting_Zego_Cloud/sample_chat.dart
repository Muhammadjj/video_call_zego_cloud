import 'package:video_call_zego_cloud/View_Zego_Cloud/Sample_Chatting_Zego_Cloud/zim_chat_list.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../Export/export.dart';

class ZimLoginPage extends StatefulWidget {
  const ZimLoginPage({super.key});

  @override
  State<ZimLoginPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ZimLoginPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController userId = TextEditingController();

  @override
  void initState() {
    super.initState();
    userName = TextEditingController();
    userId = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    userId.dispose();
    userName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Zego Cloud Zim Login Page  .'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            TextFormField(
              controller: userName,
              decoration: const InputDecoration(hintText: "User Name"),
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: userId,
              decoration: const InputDecoration(hintText: "User Id"),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () async {
                  await ZIMKit()
                      .connectUser(id: userId.text, name: userName.text);
                  if (mounted) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ZimChatList(id: userId.text, name: userName.text),
                        ));
                  }
                  //     .then((value) {
                  //   Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const ZimChatList(),
                  //       ));
                  // }).onError((error, stackTrace) {
                  //   debugPrint("Zim Zego Cloud Error");
                  // });
                },
                child: const Text("LogIn Zego Zim"))
          ],
        ));
  }
}
