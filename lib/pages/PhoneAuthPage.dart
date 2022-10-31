import 'dart:async';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:to_do/Service/Auth_Service.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({Key? key}) : super(key: key);

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  TextEditingController phoneController = TextEditingController();
  AuthClass authClass = AuthClass();
  String verificationIdFinal = "";
  String smsCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          "SignUp",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              textField(),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      color: Colors.grey,
                    )),
                    const Text(
                      "Enter 6 digit OTP",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Expanded(
                        child: Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      color: Colors.grey,
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              otpField(),
              const SizedBox(
                height: 30,
              ),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                  text: "Send OTP again in ",
                  style: TextStyle(fontSize: 16, color: Colors.yellowAccent),
                ),
                TextSpan(
                  text: "00:$start",
                  style:
                      const TextStyle(fontSize: 16, color: Colors.pinkAccent),
                ),
                const TextSpan(
                  text: " sec",
                  style: TextStyle(fontSize: 16, color: Colors.yellowAccent),
                ),
              ])),
              const SizedBox(
                height: 130,
              ),
              InkWell(
                onTap: (){
                  authClass.signInWithPhoneNumber(verificationIdFinal, smsCode, context);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  height: 60,
                  width: MediaQuery.of(context).size.height - 60,
                  decoration: BoxDecoration(
                    color: Color(0xffff9601),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      "Lets Go",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xfffbe2ae),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void startTime() {
    const onSec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onSec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width,
      fieldWidth: 58,
      otpFieldStyle: OtpFieldStyle(
          backgroundColor: const Color(0xff1d1d1d), borderColor: Colors.white),
      style: const TextStyle(fontSize: 17, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smsCode = pin;
        });
      },
    );
  }

  Widget textField() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        color: const Color(0xff1d1d1d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: phoneController,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white, fontSize: 17),
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter your phone Number",
          hintStyle: const TextStyle(color: Colors.white54, fontSize: 17),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 17, horizontal: 14),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            child: Text(
              "(+996)",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          suffixIcon: InkWell(
            onTap: wait
                ? null
                : () async {
                    startTime();
                    setState(() {
                      start = 30;
                      wait = true;
                      buttonName = "Resend";
                    });
                    await authClass.verifyPhoneNumber(
                        "+996 ${phoneController.text}", context, setData);
                  },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 17, horizontal: 15),
              child: Text(
                buttonName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setData(verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    startTime();
  }
}
