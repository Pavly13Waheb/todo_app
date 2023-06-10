import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:todo/authentication/UserDmAuth.dart';
import 'package:todo/authentication/signup.dart';
import 'package:todo/home_page.dart';
import '../widgets&model/provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class Login extends StatefulWidget {
  static String routeName = "Login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("assets/logo.png",
                fit: BoxFit.fill, width: 100, height: 100),
          ),
          Form(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      hintText: "E-Mail",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blue),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onSaved: (newValue) {
                      email = newValue!;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.length > 100) {
                        return "E-mail can't be more than 100 letter";
                      }
                      if (value.length < 5) {
                        return "E-mail can't be less than 5 letter";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.yellow, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      hintText: "Password",
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blue),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onSaved: (newValue) {
                      password = newValue!;
                    },
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.length > 100) {
                        return "Password can't be more than 100 letter";
                      }
                      if (value.length < 5) {
                        return "Password can't be less than 5 letter";
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Text(
                              "If you don't have account please ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  SignUp.routeName,
                                );
                              },
                              child: const Text(
                                "Signup",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  MaterialButton(
                    onPressed: () async {
                      loginUser();
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    color: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  loginUser() async {
    try {
      showLoading();
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserDm user = await getUserFromFirestore(credential.user!.uid);
      UserDm.currentUser = user;
      UserDm.currentEmail = email;
      hideLoading();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AwesomeDialog(
            context: context,
            title: "Error",
            body: Text(
              "No user found for that email.",
              style: TextStyle(fontSize: 30),
            ))
          ..show();
      } else if (e.code == 'wrong-password') {
        AwesomeDialog(
            context: context,
            title: "Error",
            body: Text(
              "wrong-password.",
              style: TextStyle(fontSize: 30),
            ))
          ..show();
      } else {
        AwesomeDialog(
          context: context,
          title: "Error",
          body: Text(
            "Something went wrong . Please try again later.",
            style: TextStyle(fontSize: 30),
          ),
        )..show();
      }
    }
    Navigator.pushNamed(context, HomePage.routeName);
  }

  void showLoading() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Text("Loading ... "), CircularProgressIndicator()]),
        );
      },
    );
  }

  hideLoading() {
    Navigator.pop(context);
  }

  Future getUserFromFirestore(String uid) async {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection(UserDm.collectionName);
    DocumentReference doc = userCollection.doc(uid);
    DocumentSnapshot snapshot = await doc.get();
    Map jason = snapshot.data() as Map;
    UserDm user = UserDm(id: uid, username: jason["username"], email: email);
    return user;
  }
}
