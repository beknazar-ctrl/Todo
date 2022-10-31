import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do/Service/Auth_Service.dart';
import 'package:to_do/pages/HomePage.dart';
import 'package:to_do/pages/PhoneAuthPage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool circular = false;
  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              buttonItem("assets/Google.svg", 'Continue with Google', 25,(){
                authClass.googleSignIn(context);
              }),
              const SizedBox(
                height: 15,
              ),
              buttonItem("assets/phone-call.svg", "Continue with Mobile", 30,(){
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => const PhoneAuthPage()));
              }),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Or",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              textItem("Email...", _emailController, false),
              const SizedBox(
                height: 15,
              ),
              textItem("Password...", _pwdController, true),
              const SizedBox(
                height: 40,
              ),
              colorButton(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'If you alredy have an Account?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'SignUp',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Forgot Password?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget colorButton() {
    return InkWell(
      onTap: () async {
        setState(() {
          circular = true;
        });
        try {
          firebase_auth.UserCredential userCredential =
              await firebaseAuth.createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _pwdController.text,
          );
          print(userCredential.user?.email);
          setState(() {
            circular = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => HomePage()),
              (route) => false);
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [
            Color(0xfffd746c),
            Color(0xffff9068),
            Color(0xfffd746c),
          ]),
        ),
        child: Center(
          child: circular
              ? const CircularProgressIndicator()
              : const Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }

  Widget buttonItem(String imagepath, String buttonName, double size,Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
          color: Colors.black,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imagepath,
                height: size,
                width: size,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                buttonName,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textItem(
    String labelText,
    TextEditingController controller,
    bool obscureText,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  width: 1.5,
                  color: Colors.amber,
                )),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.grey,
              ),
            )),
      ),
    );
  }
}
