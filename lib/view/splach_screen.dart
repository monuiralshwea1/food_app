import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';
import '../route/RoutingPage.dart';



class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(seconds: 5),
            () => Get.offAllNamed(ScreenName.entryPoint)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: primaryColor,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/big_1.png'))),
          ),
        ));
  }
}
