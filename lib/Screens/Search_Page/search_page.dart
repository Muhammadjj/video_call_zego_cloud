import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Components/Widgets/custom_size_box.dart';
import '../../Export/export.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var userName;

  // Firebase Sections
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search For A User"),
        ),
        body: Column(
          children: [
            const CustomSizedBox(heightRatio: 0.03),
            // ! Search Text Field .
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Enter UserName"),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  userName = value;
                  setState(() {});
                },
              ),
            ),
            // ! Searching Using this Firebase Sections .
            if (userName != null)
              if (userName!.length > 3)
                FutureBuilder<QuerySnapshot>(
                  future: firestore
                      .collection("users")
                      .where("userName", isEqualTo: userName)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        return const Text("User Not Found");
                      }

                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data?.docs.length ?? 0,
                          itemBuilder: (context, index) {
                            DocumentSnapshot doc = snapshot.data!.docs[index];
                            return ListTile(
                              title: Text("${doc["userName"]}"),
                              trailing: FutureBuilder(
                                future: doc.reference
                                    .collection("followers")
                                    .doc(auth.currentUser!.uid)
                                    .get(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data?.exists ?? false) {
                                      return ElevatedButton(
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.lime)),
                                          onPressed: () async {
                                            await doc.reference
                                                .collection("followers")
                                                .doc(auth.currentUser!.uid)
                                                .delete();
                                            setState(() {});
                                          },
                                          child: const Text("UnFollow"));
                                    }
                                    return ElevatedButton(
                                        style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.lime)),
                                        onPressed: () async {
                                          await doc.reference
                                              .collection("followers")
                                              .doc(auth.currentUser!.uid)
                                              .set({
                                            "time": DateTime.now(),
                                          });
                                          setState(() {});
                                        },
                                        child: const Text("Follow"));
                                  } else {
                                    return const CircularProgressIndicator
                                        .adaptive();
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator.adaptive();
                    }
                  },
                )
          ],
        ),
      ),
    );
  }
}
