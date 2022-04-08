import 'dart:ui';
import 'package:flutter/material.dart';

class Calendar {
  // Os meses são retornados da função DateTime a partir do numero 1.
  // Como estamos utilizando List para retornar o nome do mês correspondente,
  // diminuimos 1 do valor da variável month para nos referirmos ao valor do mês
  // na List<String> listMonth.

  late DateTime currentDate;

  late List<String> date;
  late List<String> yearAndMonthAndDay;
  late List<int> days;
  late List<Color> colors;

  late int day;
  late int month;
  late int year;

  List<int> nDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  List<String> listMonth = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro",
  ];

  Calendar() {
    runCalendar();
  }

  void runCalendar() {
    currentDate = DateTime.now();
    date = currentDate.toString().split(' ');
    yearAndMonthAndDay = date[0].toString().split('-');

    days = [];
    colors = [];

    day = int.parse(yearAndMonthAndDay[2]);
    month = int.parse(yearAndMonthAndDay[1]) - 1;
    year = int.parse(yearAndMonthAndDay[0]);

    getDays();
  }

  String currentMonthAndYear() {
    String monthAndYear = listMonth[month] + " $year";

    return monthAndYear;
  }

  String monthAndYear({bool back = false, bool next = false}) {
    if (back && (next == false)) {
      if (month > 0) {
        month--;
      } else {
        month = 11;
        year--;
      }
    }

    if (next && (back == false)) {
      if (month < (listMonth.length - 1)) {
        month++;
      } else {
        month = 0;
        year++;
      }
    }

    String monthAndYear = listMonth[month] + " $year";
    getDays();

    return monthAndYear;
  }

  List<int> getDays() {
    // Queremos um calendário com 6 linhas e 7 colunas, logo a quantidade de
    // dias que será exibido no calendário será 42, valor atribuído à variável
    // totalDaysInTheCalendar.

    day = DateTime.now().day;
    days = [];
    colors = [];
    bool lastDay = false;
    int _day = 1;
    int totalDaysInTheCalendar = 42;
    int maxDays = nDays[month];
    int previousMonth = 0;
    int firstDay = DateTime(year, (month + 1), 1).weekday;
    int _dayOfWeek = 0;

    if (month == 0) {
      previousMonth = 11;
    } else {
      previousMonth = month - 1;
    }

    int totalDays = nDays[previousMonth] - firstDay + 1;
    if (isLeap(previousMonth) && (month == 1)) {
      totalDays++;
    }

    // verifica se é bissexto
    if (month == 1) {
      if (isLeap(month)) {
        maxDays++;
      }
    }

    for (int i = 0; i < totalDaysInTheCalendar; i++) {
      _dayOfWeek = dayOfWeek(year, (month + 1), _day);

      if (i < firstDay) {
        days.add(totalDays);
        colors.add(Colors.grey);

        totalDays++;
      } else {
        if (i == firstDay) {
          _day = 1;
        } else if (_day > maxDays) {
          _day = 1;

          lastDay = true;
        }

        days.add(_day);

        if ((_day == day) &&
            (!lastDay) &&
            ((month + 1) == DateTime.now().month) &&
            (year == DateTime.now().year)) {
          colors.add(Colors.purpleAccent);
        } else if (lastDay) {
          colors.add(Colors.grey);
        } else if ((_dayOfWeek == 6) || (_dayOfWeek == 7)) {
          colors.add(Colors.brown);
        }else {
          colors.add(Colors.purple);
        }

        _day++;
      }
    }

    return days;
  }

  bool isLeap(int month) {
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
      return true;
    }

    return false;
  }

  int dayOfWeek(int year, int month, int day) {
    return DateTime(year, month, day).weekday;
  }

  String nameOfTheDayOfTheWeek(int currentYear, int currentMonth, int currentDay) {
    String nameOfTheDay = "Sábado";
    int _dayOfWeek = dayOfWeek(currentYear, currentMonth, currentDay);

    switch(_dayOfWeek) {
      case 1:
        nameOfTheDay = "Segunda-Feira";
        break;
      case 2:
        nameOfTheDay = "Terça-Feira";
        break;
      case 3:
        nameOfTheDay = "Quarta-Feira";
        break;
      case 4:
        nameOfTheDay = "Quinta-Feira";
        break;
      case 5:
        nameOfTheDay = "Sexta-Feira";
        break;
      case 6:
        nameOfTheDay = "Sábado";
        break;
      case 7:
        nameOfTheDay = "Domingo";
        break;
      default:
        break;
    }

    return nameOfTheDay;
  }

  int currentYear() {
    return DateTime.now().year;
  }

  int currentMonth() {
    return DateTime.now().month;
  }

  int currentDay() {
    return DateTime.now().day;
  }
}
