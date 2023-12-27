import 'package:flutter/material.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(
          children: [
            Details(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xfafbf7f7),
          items: [
            BottomNavigationBarItem(
              backgroundColor: const Color(0xfafbf7f7),
              icon: const Icon(Icons.notifications),
              label: ' Notifications',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.menu),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.add_circle_outline),
              label: 'plus',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Home',
            )
          ],
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 430,
          height: 932,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: const Color(0xfaf8f5f5)),
          child: Stack(
            children: [
              Positioned(
                left: 36,
                top: 10,
                child: Container(
                  width: 20,
                  height: 20,
                  color: const Color(0xfff4f6f8),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Color(0xff241382)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 70,
                child: Container(
                  width: 375,
                  height: 230,
                  decoration: ShapeDecoration(
                    color: const Color(0xfff9f8f7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 36,
                        top: 20,
                        child: Text(
                          'S 500 Sedan',
                          style: TextStyle(
                            color: const Color(0xFF0C0C0C),
                            fontSize: 24,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 36,
                        top: 70,
                        child: Text(
                          '4.9',
                          style: TextStyle(
                            color: const Color(0xFF0C0C0C),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 90,
                        top: 70,
                        child: Text(
                          '(230 Reviews)',
                          style: TextStyle(
                            color: const Color(0xFFAAAAAA),
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 90,
                        child: Center(
                          child: const Icon(
                            Icons.swap_horiz,
                            color: Color(0xff210ba4),
                            size: 30,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 100,
                        top: 150,
                        child: Center(
                          child: Container(
                            width: 200,
                            height: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: const NetworkImage(
                                  'https://images.dealer.com/ddc/vehicles/2023/Lexus/LS%20500/Sedan/color/Atomic%20Silver-1J7-103,98,94-640-en_US.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 340,
                child: Container(
                  width: 375,
                  height: 100,
                  decoration: ShapeDecoration(
                    color: const Color(0xfff9f8f7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 20,
                        top: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Specs",
                                  style: TextStyle(
                                    color: Color(0xff2d0a6d),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: MaterialButton(
                                    color: Colors.white,
                                    textColor: Colors.black87,
                                    minWidth: 50,
                                    height: 50,
                                    hoverColor: Colors.greenAccent,
                                    focusColor: Colors.greenAccent,
                                    highlightColor: Colors.greenAccent,
                                    shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(color: Colors.black38),
                                    ),
                                    onPressed: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: const Text(
                                        "Colour \n Black",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: MaterialButton(
                                    color: Colors.white,
                                    textColor: Colors.black87,
                                    minWidth: 70,
                                    height: 55,
                                    hoverColor: Colors.greenAccent,
                                    focusColor: Colors.greenAccent,
                                    highlightColor: Colors.greenAccent,
                                    shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(color: Colors.black38),
                                    ),
                                    onPressed: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: const Text(
                                        "Seater\n   5",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: MaterialButton(
                                    color: Colors.white,
                                    textColor: Colors.black87,
                                    minWidth: 70,
                                    height: 55,
                                    hoverColor: Colors.greenAccent,
                                    focusColor: Colors.greenAccent,
                                    highlightColor: Colors.greenAccent,
                                    shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(color: Colors.black38),
                                    ),
                                    onPressed: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: const Text(
                                        "Model  \n 2023",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 450,
                child: Container(
                  width: 375,
                  height: 80,
                  decoration: ShapeDecoration(
                    color: const Color(0xfff9f8f7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Positioned(
                        child: Container(
                          width: 5,
                          height: 150,
                          decoration: ShapeDecoration(
                            color: const Color(0xfff9f8f7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '80\$  / hour     ',
                        style: TextStyle(
                          color: const Color(0xff121114),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Add your action for the "book" button
                        },
                        child: const Text('Book'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
