import 'package:agendasalaodebeleza/component/dialog/dialog.dart';
import 'package:agendasalaodebeleza/firebase/time_manager.dart';
import 'package:agendasalaodebeleza/pages/scheduled_time/scheduled_time_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data_time.dart';
import '../../firebase/time.dart';
import '../calendar/calendar.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late List<String> initialLetterDays;
  late Calendar calendar;
  late String _monthAndYear;
  late int clickedCalendarIndex;
  late int clickedTimeIndex;
  late int chosenTime;
  late int chosenDay;
  late String nameOfTheDayOfTheWeek;
  late List<Time> listScheduledTime;

  @override
  void initState() {
    super.initState();

    initialLetterDays = ["D", "S", "T", "Q", "Q", "S", "S"];
    calendar = Calendar();
    clickedCalendarIndex = -1;
    clickedTimeIndex = -1;
    _monthAndYear = calendar.currentMonthAndYear();
    chosenDay = calendar.currentDay();
    nameOfTheDayOfTheWeek = calendar.nameOfTheDayOfTheWeek(
        calendar.currentYear(), calendar.currentMonth(), calendar.currentDay());
    listScheduledTime = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text("Salão de Beleza"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ScheduleTimePage(),
                    ),
                );
              },
              child: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    Size size = MediaQuery.of(context).size;

    return Consumer<TimeManager>(
      builder: (_, timeManager, __) {
        return Container(
          color: Colors.white,
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon:
                        const Icon(Icons.arrow_back_ios, color: Colors.purple),
                        onPressed: () {
                          setState(() {
                            _monthAndYear = calendar.monthAndYear(back: true);
                          });
                        },
                      ),
                      Row(
                        children: [
                          Text(
                            _monthAndYear,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.purple,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.purple,
                        ),
                        onPressed: () {
                          setState(() {
                            _monthAndYear = calendar.monthAndYear(next: true);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Wrap(
                  spacing: 3,
                  direction: Axis.horizontal,
                  children: List.generate(initialLetterDays.length, (index) {
                    return Container(
                      width: size.width * 0.13,
                      height: size.width * 0.13,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        initialLetterDays[index],
                        style: const TextStyle(color: Colors.purple),
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 3,
                    runSpacing: 4,
                    children: List.generate(calendar.days.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            clickedCalendarIndex = index;
                            chosenDay = calendar.days[index];
                            nameOfTheDayOfTheWeek = calendar.nameOfTheDayOfTheWeek(
                                calendar.year,
                                (calendar.month + 1),
                                calendar.days[index]);
                          });
                        },
                        child: Container(
                          width: size.width * 0.13,
                          height: size.width * 0.13,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: (clickedCalendarIndex == index)
                                ? Colors.greenAccent.withOpacity(0.1)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.1),
                              width: 1.5,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Text(
                            calendar.days[index].toString(),
                            style: TextStyle(color: calendar.colors[index]),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0, bottom: 4.0),
                  child: Column(
                    children: [
                      const Text(
                        "Horários",
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Column(
                        children: List.generate(time.length, (index) {
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
                                    "$nameOfTheDayOfTheWeek, $chosenDay - ${time[index]} h",
                                    style: const TextStyle(
                                      color: Colors.purple,
                                      fontSize: 16,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      chosenTime = time[index];

                                      String date = "$nameOfTheDayOfTheWeek, "
                                      "$chosenDay de ${calendar.listMonth[calendar.month]} de "
                                      "${calendar.year} - $chosenTime h";

                                      timeManager.setTime(date).whenComplete(() {
                                        dialogConfirmInsertion(context);
                                      });
                                    },
                                    child: const Icon(
                                      Icons.check,
                                      color:  Colors.purple,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
