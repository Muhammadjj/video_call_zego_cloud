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
          title: Text('Conversations  :  $name '),
          actions: const [],
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
                );
              },
            ));
          },
        ),
      ),
    );
  }
}
