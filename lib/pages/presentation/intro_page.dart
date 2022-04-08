import 'package:agendasalaodebeleza/pages/presentation/screens/first_screen.dart';
import 'package:agendasalaodebeleza/pages/presentation/screens/second_screen.dart';
import 'package:agendasalaodebeleza/pages/presentation/screens/third_screen.dart';
import 'package:agendasalaodebeleza/pages/root/root_page.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late PageController controller;
  late int _currentPage;
  late int _totalPages;

  late List<Widget> pages;

  late Size size;

  @override
  void initState() {
    super.initState();

    _currentPage = 0;
    _totalPages = 3;
    controller = PageController(
      initialPage: 0,
    );

    pages = [FirstScreen(), SecondScreen(), ThirdScreen()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.purpleAccent, Colors.purple],
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              scrollDirection: Axis.horizontal,
              onPageChanged: _onPageChanged,
              children: List.generate(pages.length, (index) {
                return pages[index];
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Wrap(
              spacing: 10,
              children: List.generate(_totalPages, (index) {
                return Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: (index == _currentPage)
                        ? Colors.white
                        : Colors.grey.shade500,
                    borderRadius: BorderRadius.circular(30),
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => RootPage(),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                      width: 1.0,
                      color: Colors.white,
                      style: BorderStyle.solid),
                ),
                child: const Center(
                  child: Text(
                    "COMEÇAR",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }
}
