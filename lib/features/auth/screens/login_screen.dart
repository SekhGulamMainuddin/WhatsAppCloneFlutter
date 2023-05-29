import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_using_flutter/common/colors.dart';
import 'package:whatsapp_clone_using_flutter/common/widgets/custom_button.dart';
import 'package:whatsapp_clone_using_flutter/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone_using_flutter/features/auth/screens/otp_verify_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = "/login-screen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String country = "United States";
  String countryCode = "1";
  final phoneController = TextEditingController();
  bool codeSending = false;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  selectCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          this.country = country.name;
          countryCode = country.phoneCode;
        });
      },
    );
  }

  sendOTP() {
    setState(() {
      codeSending= true;
    });
    ref.read(authControllerProvider).sendOTPToPhone(
      "+$countryCode${phoneController.text.trim()}",
      (verificationId, resendToken) {
        codeSending= false;
        Navigator.pushNamed(
          context,
          OTPVerifyScreen.routeName,
          arguments: verificationId,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter your phone number"),
        elevation: 0,
        backgroundColor: backgroundColor,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: whiteColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text:
                            "WhatsApp will send an SMS message to verify your phone number. ",
                        children: [
                          TextSpan(
                              text: "What's my number",
                              style: TextStyle(color: Colors.blueAccent))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: selectCountry,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: tabColor, width: 2),
                        ),
                      ),
                      width: size.width * 0.6,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              country,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              size: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: size.width * 0.6,
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: tabColor, width: 2),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.add,
                                  size: 20,
                                  color: greyColor,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  countryCode,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: tabColor, width: 2),
                              ),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: phoneController,
                              decoration: const InputDecoration(
                                hintText: "Phone Number",
                                isDense: true,
                                contentPadding: EdgeInsets.only(bottom: 5),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: tabColor, width: 1),
                                ),
                              ),
                              cursorColor: tabColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Carrier SMS charges may apply",
                    style: TextStyle(
                      color: greyColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: 70,
                    child: CustomButton(
                      text: "NEXT",
                      onPressed: sendOTP,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              )
            ],
          ),
          if (codeSending)
            const Center(
              child: CircularProgressIndicator(
                color: tabColor,
              ),
            ),
        ],
      ),
    );
  }
}
