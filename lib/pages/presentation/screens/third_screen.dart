import 'package:flutter/material.dart';

class ThirdScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.access_time_rounded,
          color: Colors.white,
        ),
        Container(
          padding: const EdgeInsets.only(
              top: 32.0, left: 32.0, right: 32.0,),
          child: const Text(
            "Estamos prontos para te atender no horário de sua preferência.",
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
