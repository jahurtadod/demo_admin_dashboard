import 'package:flutter/material.dart';

class BackgroundTwitter extends StatelessWidget {
  const BackgroundTwitter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBoxDecorattion(),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Image(
              image: AssetImage('assets/twitter-white-logo.png'),
              width: 400,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecorattion() => const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/twitter-bg.png'),
          fit: BoxFit.cover,
        ),
      );
}
