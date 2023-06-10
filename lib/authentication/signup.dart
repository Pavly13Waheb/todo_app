import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:todo/authentication/UserDmAuth.dart';
import 'package:todo/authentication/login.dart';

class SignUp extends StatefulWidget {
  static String routeName = "SignUp";

  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String username = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
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
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          hintText: "User Name",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blue),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (newValue) {
                          username = newValue!;
                          UserDm.currentUser = newValue as UserDm?;
                        },
                        onChanged: (value) {
                          username = value;
                        },
                        validator: (value) {
                          if (value!.length > 100) {
                            return "Username can't be more than 100 letter";
                          }
                          if (value.length < 5) {
                            return "Username can't be less than 5 letter";
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
                                  BorderSide(color: Colors.blue, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          hintText: "E-Mail",
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blue),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          hintText: "Password",
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blue),
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
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  child: Image.asset(
                                    "assets/google.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                  onTap: () {
                                    signInWithGoogle();
                                  },
                                ),
                                InkWell(
                                  child: Image.asset(
                                    "assets/facebook.png",
                                    height: 50,
                                    width: 50,
                                  ),
                                  onTap: () {
                                    signInWithFacebook();
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("If you have account please "),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Login",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 15,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          registerUser();
                        },
                        child: const Text("Create Account"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  registerUser() async {
    try {
      showLoading();
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await saveUserInFireStore(
          username: username, email: email, uid: credential.user!.uid);
      hideLoading();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AwesomeDialog(
            context: context,
            title: "Error",
            body: Text(
              "weak-password",
              style: TextStyle(fontSize: 30),
            ))
          ..show();
      } else if (e.code == 'email-already-in-use') {
        AwesomeDialog(
            context: context,
            title: "Error",
            body: Text(
              "email-already-in-use",
              style: TextStyle(fontSize: 30),
            ))
          ..show();
      }
    } catch (e) {
      AwesomeDialog(
          context: context,
          title: "Error",
          body: Text(
            "Something went wrong . Please try again later.",
            style: TextStyle(fontSize: 30),
          ))
        ..show();
    }
    Navigator.pushNamed(context, Login.routeName);
  }

  showLoading() {
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

  Future saveUserInFireStore(
      {required String email, required String username, required String uid}) {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection(UserDm.collectionName);
    DocumentReference userDoc = userCollection.doc(uid);
    return userDoc.set(
      {
        "id": uid,
        "email": email,
        "username": username,
      },
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
