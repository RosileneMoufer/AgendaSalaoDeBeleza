import 'package:agendasalaodebeleza/component/dialog/dialog.dart';
import 'package:agendasalaodebeleza/firebase/time_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleTimePage extends StatefulWidget {
  @override
  _ScheduleTimePageState createState() => _ScheduleTimePageState();
}

class _ScheduleTimePageState extends State<ScheduleTimePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: const Text("Agendamentos"),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    Size size = MediaQuery.of(context).size;

    return Consumer<TimeManager>(builder: (_, timeManager, __) {
      timeManager.getScheduledTime();

      return Container(
        color: Colors.white,
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(timeManager.listTime.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Container(
                  width: size.width,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Colors.purple.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${timeManager.listTime[index].time}",
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          dialogConfirmDeletion(context, timeManager.listTime[index]);
                        },
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      );
    });
  }
}
