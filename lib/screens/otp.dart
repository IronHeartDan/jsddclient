import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jsddclient/calendar/calender.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTPScreen extends StatefulWidget {
  final String phone;

  const OTPScreen({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode = null;
  final TextEditingController _pinPutController = TextEditingController();

  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldkey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Verify Phone',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 23.0),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 300.0,
            width: 300.0,
            child: Image.network(
                "https://image.flaticon.com/icons/png/512/541/541051.png"),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0), color: Colors.white),
            child: Column(
              children: [
                // Container(
                //     height: 300.0,
                //     width: double.infinity,
                //     color: Colors.blue[800],
                //     child: Image.asset(
                //       "assets/images/cyber-security.png",
                //       color: Colors.white,
                //     )),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  // margin: EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: Visibility(
                      visible: _verificationCode == null ? false : true,
                      child: Text(
                        'Code is sent to ${widget.phone}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 26.0),
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(20.0),
                    padding: const EdgeInsets.all(20.0),
                    child: PinPut(
                        fieldsCount: 6,
                        focusNode: _pinPutFocusNode,
                        controller: _pinPutController,
                        submittedFieldDecoration: _pinPutDecoration.copyWith(
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue,
                                  offset: Offset.infinite,
                                  spreadRadius: 0.0)
                            ],
                            color: Colors.blue[700]),
                        selectedFieldDecoration: _pinPutDecoration,
                        followingFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: Colors.black.withOpacity(.5),
                          ),
                        ),
                        onSubmit: (pin) async {
                          try {
                            await FirebaseAuth.instance
                                .signInWithCredential(
                                    PhoneAuthProvider.credential(
                                        verificationId: _verificationCode!,
                                        smsCode: pin))
                                .then((value) => {
                                      if (value.user != null)
                                        {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Calender()),
                                              (route) => false)
                                        }
                                    });
                          } catch (e) {
                            FocusScope.of(context).unfocus();
                            _scaffoldkey.currentState!.showSnackBar(
                                SnackBar(content: Text('invalid OTP')));
                          }
                        })),
                const Text(
                  "Didn't receive code? Request again.",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              // print('user logged in');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Calender()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120),
        codeSent: (String verificationId, int? forceResendingToken) {
          setState(() {
            _verificationCode = verificationId;
          });
        });
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }
}
