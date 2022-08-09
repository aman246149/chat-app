import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/otp_screen.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? countrycode = "+91";
  TextEditingController phonenumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Scaffold(
          body: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'ChatApp',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              const SizedBox(
                height: 25,
              ),
              Consumer<AuthProvider>(
                builder: (context, value, child) {
                  return value.errormsg.isNotEmpty
                      ? Text(
                          value.errormsg,
                          style: const TextStyle(color: Colors.red),
                        )
                      : Container();
                },
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    CountryListPick(
                      initialSelection: countrycode,
                      useUiOverlay: false,
                      onChanged: (countrycod) {
                        countrycode = countrycod!.code;
                      },
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextField(
                        controller: phonenumber,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone Number',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<AuthProvider>(
                builder: (context, value, child) {
                  return value.isLoading == true
                      ? Center(
                          child: const CircularProgressIndicator(
                            color: Colors.green,
                          ),
                        )
                      : Container(
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            child: const Text('Get OTP'),
                            onPressed: () {
                              value.setSignIn(
                                  countrycode! + phonenumber.text, context);
                             
                            },
                          ));
                },
              )
            ],
          ),
        ));
  }
}
