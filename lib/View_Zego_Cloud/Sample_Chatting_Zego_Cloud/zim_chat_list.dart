import 'package:video_call_zego_cloud/View_Zego_Cloud/Sample_Chatting_Zego_Cloud/zim_audio_call.dart';
import 'package:video_call_zego_cloud/View_Zego_Cloud/Sample_Chatting_Zego_Cloud/zim_video_call.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import '../../Export/export.dart';

class ZimChatList extends StatelessWidget {
  const ZimChatList({Key? key, required this.name, required this.id})
      : super(key: key);
  final String name;
  final String id;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {},
      child: Scaffold(
        appBar: AppBar(
          title: Text('Conversations  :  $name:$id '),
          actions: [],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              ZIMKit().showDefaultNewPeerChatDialog(context);
            },
            child: const Text("ADD")),
        body: ZIMKitConversationListView(
          onPressed: (context, conversation, defaultAction) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ZIMKitMessageListPage(
                  conversationID: conversation.id,
                  conversationType: conversation.type,
                  appBarActions: [
                    //! Video Call Sections
                    IconButton(
                        icon: const Icon(Icons.video_call),
                        onPressed: () {
                          String ids = conversation.id.toString() +
                              ZIMKit()
                                  .currentUser()!
                                  .baseInfo
                                  .userID
                                  .toString();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ZimVideoCall(callID: ids, userID: name),
                              ));
                        }),

                    //! Audio Call Sections
                    IconButton(
                        icon: const Icon(Icons.call),
                        onPressed: () {
                          String ids = conversation.id.toString() +
                              ZIMKit()
                                  .currentUser()!
                                  .baseInfo
                                  .userID
                                  .toString();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ZimAudioCall(callID: ids, userID: name),
                              ));
                        }),
                  ],
                );
              },
            ));
          },
        ),
      ),
    );
  }
}
