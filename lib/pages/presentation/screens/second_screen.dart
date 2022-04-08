import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.auto_awesome_outlined,
          color: Colors.white,
        ),
        Container(
          padding: const EdgeInsets.only(
              top: 32.0, left: 32.0, right: 32.0,),
          child: const Text(
            "Aqui você se renova e sai com a autoestima elevada.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }
}
