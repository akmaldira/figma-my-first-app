import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            bottom: -300,
            child: Container(
              width: 524,
              height: 524,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color(0xFF21C8F6),
                        Color(0xFF637BFF),
                      ])),
              child: Container(
                alignment: const Alignment(0, -2.5),
                child: Image.asset("assets/images/loginImage.png"),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}