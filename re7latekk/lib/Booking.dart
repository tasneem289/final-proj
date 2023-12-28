import 'package:flutter/material.dart';

void main() {
  runApp(const Booking());
}

class Booking extends StatelessWidget {
  const Booking({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: [
          Successful(),
        ]),
      ),
    );
  }
}

class Successful extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 430,
          height: 932,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFAFAFAFA)),
          child: Stack(
            children: [
              Positioned(
                left: 29,
                top: 25,
                child: Container(
                  width: 32,
                  height: 32,
                  /* decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'Images/Booking.jpeg'), // Replace with the actual path to your image
                      fit: BoxFit.fill,
                    ),
                  
                  ),
                  */
                ),
              ),
              Positioned(
                left: 81,
                top: 145,
                child: Container(
                  width: 268,
                  height: 268,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'Images/Booking.jpeg'), // Replace with the actual path to your image
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 61,
                top: 486,
                child: SizedBox(
                  width: 352,
                  child: Text(
                    'Your reservation has been completed successfully ...',
                    style: TextStyle(
                      color: Color(0xFF045F91),
                      fontSize: 36,
                      fontFamily: 'Rowdies',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
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
