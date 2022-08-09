import 'dart:async';

import 'package:chat_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OTPscreen extends StatefulWidget {
  const OTPscreen({Key? key}) : super(key: key);

  @override
  State<OTPscreen> createState() => _OTPscreenState();
}

class _OTPscreenState extends State<OTPscreen> {
  String currentText = "";

  StreamController<ErrorAnimationType>? errorController;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter  Your OTP"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: PinCodeTextField(
              keyboardType: TextInputType.phone,
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              autoFocus: true,
              pinTheme: PinTheme(
                selectedFillColor: Colors.green,
                inactiveColor: Colors.white,
                inactiveFillColor: Colors.blue.withOpacity(0.3),
                activeColor: Colors.white,
                shape: PinCodeFieldShape.underline,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.blue.shade50,
              enableActiveFill: true,
              errorAnimationController: errorController,
              controller: textEditingController,
              onCompleted: (v) {
                print("Completed");
              },
              onChanged: (value) {
                print(value);
                setState(() {
                  currentText = value;
                });
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
              appContext: context,
            ),
          ),
          TextButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .setOtp(currentText);
                print(currentText);
                Navigator.pop(context,currentText);
              },
              child: Text(
                "Verify OTP",
                style: TextStyle(fontSize: 18),
              ))
        ],
      ),
    );
  }
}
