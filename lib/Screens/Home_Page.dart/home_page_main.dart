import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_call_zego_cloud/Screens/Auth/Login_Page/login_page_main.dart';
import 'package:video_call_zego_cloud/Screens/Search_Page/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Firebase Services .
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // TextEditingController
  TextEditingController postText = TextEditingController();
  // All Screen Size .
  late Size size;

  @override
  void initState() {
    super.initState();
    postText = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    postText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Social App"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ),
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      drawer: drawerWidgets(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0)),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: postText,
                    decoration:
                        const InputDecoration(labelText: "Post Something ..."),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            var data = {
                              "time": DateTime.now(),
                              "type": "Text",
                              "content": postText.text.toString(),
                              "uid": auth.currentUser!.uid,
                            };
                            firestore.collection("posts").add(data);
                            postText.clear();
                            setState(() {});
                          },
                          child: const Text("Post"))
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                child: FutureBuilder<QuerySnapshot>(
              future: firestore
                  .collection("users")
                  .doc(auth.currentUser?.uid)
                  .collection("timeline")
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data?.docs.isEmpty ?? true) {
                    return const Text("No Post For You !");
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.docs.length ?? 0,
                      itemBuilder: (context, index) {
                        QueryDocumentSnapshot doc = snapshot.data!.docs[index];

                        return Text(doc.toString());
                      },
                    );
                  }
                } else {
                  return const LinearProgressIndicator();
                }
              },
            ))
          ],
        ),
      ),
    );
  }

//! Drawer Working .
  Drawer drawerWidgets(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            onTap: () {
              auth.signOut().then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                    (route) => false);
              });
            },
            title: const Text("Sign Out"),
          )
        ],
      ),
    );
  }
}
