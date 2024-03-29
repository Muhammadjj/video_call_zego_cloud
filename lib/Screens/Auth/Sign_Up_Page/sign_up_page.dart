import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_call_zego_cloud/Screens/Auth/Login_Page/login_page_main.dart';
import '../../../Components/Widgets/custom_size_box.dart';
import '../../../Export/export.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Global Key .
  final formKey = GlobalKey<FormState>();
  // Firebase Section
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // TextEditingController
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  //Size .
  Size? size;

  @override
  void initState() {
    super.initState();
    userName = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    userName.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          // app Bar
          appBar: AppBar(
            title: const Text("Sign Up"),
          ),
          // ! Validation Form .
          body: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(12.0),
              children: [
                const CustomSizedBox(heightRatio: 0.03),
                // UserName Text Field .
                TextFormField(
                  validator: ValidationBuilder().maxLength(10).build(),
                  controller: userName,
                  decoration: const InputDecoration(
                    label: Text("UserName"),
                    border: OutlineInputBorder(),
                  ),
                ),
                const CustomSizedBox(heightRatio: 0.03),
                // Email Text Field .
                TextFormField(
                  controller: email,
                  validator: ValidationBuilder().email().maxLength(50).build(),
                  decoration: const InputDecoration(
                    label: Text("Email"),
                    border: OutlineInputBorder(),
                  ),
                ),
                const CustomSizedBox(heightRatio: 0.03),
                // Password TextField .
                TextFormField(
                  controller: password,
                  validator:
                      ValidationBuilder().minLength(6).maxLength(50).build(),
                  decoration: const InputDecoration(
                      label: Text("Password"), border: OutlineInputBorder()),
                ),
                const CustomSizedBox(heightRatio: 0.06),

                //! Button Sections
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          await auth
                              .createUserWithEmailAndPassword(
                                  email: email.text.toString(),
                                  password: password.text.toString())
                              .then((value) {
                            log("Successfully");

                            // if (usercre.user != null) {
                            var data = {
                              "userName": userName.text.toString(),
                              "email": email.text.toString(),
                              "created_at": DateTime.now()
                            };

                            firestore
                                .collection("users")
                                .doc(auth.currentUser!.uid)
                                .set(data)
                                .then((value) {
                              log("store");
                            });
                            // }

                            // Clear this fields
                            // userName.clear();
                            // email.clear();
                            // password.clear();

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ));
                          });
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            log('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            log('The account already exists for that email.');
                          }
                        } catch (error) {
                          log("$error");
                        }
                      }
                    },
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.lime)),
                    child: const Text("Sign Up")),
                // ! Sign Up Text
                const CustomSizedBox(heightRatio: 0.01),
                Row(children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                    },
                    child: const Text(
                      "LogIn Page",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ])
              ],
            ),
          )),
    );
  }
}
