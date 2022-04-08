import 'package:agendasalaodebeleza/firebase/time_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../firebase/time.dart';

Future<void> dialogConfirmDeletion(BuildContext context, Time time) {
  Size size = MediaQuery.of(context).size;

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Consumer<TimeManager>(builder: (_, timeManager, __) {
          return SizedBox(
            width: size.width * 0.9,
            height: size.height * 0.1,
            child: Column(
              children: [
                const Text("Deseja excluir?",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        timeManager.delete(time);
                        Navigator.of(context).pop();
                      },
                      child: const Text("Sim"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Não"),
                    ),
                  ],
                )
              ],
            ),
          );
        }),
      );
    },
  );
}

Future<void> dialogConfirmInsertion(BuildContext context) {
  Size size = MediaQuery.of(context).size;

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
            width: size.width * 0.9,
            height: size.height * 0.1,
            child: Column(
              children: [
                const Text("Agendado!",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 32,),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                )
              ],
            )),
      );
    },
  );
}
