import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.favorite_border,
          color: Colors.white,
        ),
        Container(
          padding: const EdgeInsets.only(
              top: 32.0, left: 32.0, right: 32.0,),
          child: const Text(
            "Nosso salão de beleza é dedicado a você, mulher, "
                "que merece toda atenção e cuidado.",
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
