import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_call_zego_cloud/Screens/Auth/Sign_Up_Page/sign_up_page.dart';
import '../../../Components/Widgets/custom_size_box.dart';
import '../../../Export/export.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Global Key .
  final formKey = GlobalKey<FormState>();
  // Firebase Section
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // TextEditingController
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  //Size .
  Size? size;

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
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
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        try {
                          auth
                              .signInWithEmailAndPassword(
                                  email: email.text.toString(),
                                  password: password.text.toString())
                              .then((value) {
                            log("Successfully");
                            // Clear this fields
                            email.clear();
                            password.clear();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ));
                          });
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            log('The password provided is Weak.');
                          } else if (e.code == 'user-not-found') {
                            log('Not User found.');
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
                            builder: (context) => const SignUpPage(),
                          ));
                    },
                    child: const Text(
                      "Create A User",
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
