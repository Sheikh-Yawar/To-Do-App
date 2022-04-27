import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyAnimation extends StatelessWidget {
  const EmptyAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 80,
        ),
        Lottie.asset(
          "assets/images/emptyAnimation.json",
          height: 300,
          width: 500,
          repeat: true,
        ),
        const Text(
          "Nothing Here!",
        )
      ],
    );
  }
}
