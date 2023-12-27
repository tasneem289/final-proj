/*
import 'package:flutter/material.dart';
import 'dart:io';



class CarView extends StatelessWidget {
  final Map<String, dynamic> carData;

  const CarView({Key? key, required this.carData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(
          children: [
            View(carData: carData),
          ],
        ),
      ),
    );
  }
}

class View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 430,
          height: 942,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFFF9F9F9)),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 430,
                  height: 456,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 166,
                child: Container(
                  width: 430,
                  height: 247,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: carData['image_url'] != null
                          ? FileImage(File(carData['image_url']))
                          : AssetImage('Images/car.jpg') as ImageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 55,
                top: 84,
                child: SizedBox(
                  width: 222,
                  height: 40,
                  child: Text(
                    carData['model'] ?? '',
                    style: TextStyle(
                      color: Color(0xFF3E3D3D),
                      fontSize: 24,
                      fontFamily: 'Rowdies',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 17,
                top: 519,
                child: Opacity(
                  opacity: 0.50,
                  child: Text(
                    'SPECIFICATION',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Rowdies',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 17,
                top: 598,
                child: Container(
                  width: 87,
                  height: 87,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 87,
                          height: 87,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFCFCFC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 6,
                        top: 20,
                        child: Opacity(
                          opacity: 0.50,
                          child: Text(
                            'COLOUR',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'Rowdies',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 6,
                        top: 42,
                        child: SizedBox(
                          width: 52,
                          height: 21.40,
                          child: Text(
                            carData['color'] ?? '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Rowdies',
                              fontWeight: FontWeight.w300,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 122,
                top: 598,
                child: Container(
                  width: 87,
                  height: 87,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 87,
                          height: 87,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFCFCFC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 3,
                        top: 20,
                        child: SizedBox(
                          width: 65,
                          child: Opacity(
                            opacity: 0.50,
                            child: Text(
                              'CAR MODEL',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontFamily: 'Rowdies',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 6,
                        top: 42,
                        child: SizedBox(
                          width: 52,
                          height: 21.40,
                          child: Text(
                            '2023',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Rowdies',
                              fontWeight: FontWeight.w300,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 226,
                top: 598,
                child: Container(
                  width: 87,
                  height: 87,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 87,
                          height: 87,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFCFCFC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 3,
                        top: 20,
                        child: SizedBox(
                          width: 42,
                          child: Opacity(
                            opacity: 0.50,
                            child: Text(
                              'SEATER',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontFamily: 'Rowdies',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 6,
                        top: 42,
                        child: SizedBox(
                          width: 14,
                          height: 21,
                          child: Text(
                            carData['seater'] ?? '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Rowdies',
                              fontWeight: FontWeight.w300,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 331,
                top: 598,
                child: Container(
                  width: 87,
                  height: 87,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 87,
                          height: 87,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFCFCFC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 3,
                        top: 18,
                        child: SizedBox(
                          width: 75,
                          child: Opacity(
                            opacity: 0.50,
                            child: Text(
                              'RENTAL PRICE',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontFamily: 'Rowdies',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 6,
                        top: 42,
                        child: SizedBox(
                          width: 56,
                          height: 21,
                          child: Text(
                            carData['rental'] ?? '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Rowdies',
                              fontWeight: FontWeight.w300,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 390,
                top: 645,
                child: Opacity(
                  opacity: 0.50,
                  child: Text(
                    'EGP',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Rowdies',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 23,
                top: 782,
                child: Container(
                  width: 142,
                  height: 47.90,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 142,
                          height: 47.90,
                          decoration: ShapeDecoration(
                            color: Color(0xFF045F91),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 142,
                          height: 47,
                          child: ElevatedButton(
                            onPressed: () {
                              // Add your action for the EDIT button here
                              // For example, you can navigate to a new screen or perform any other action
                              print(
                                  'EDIT button pressed. Performing action...');
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF045F91),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              'EDIT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Rowdies',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 251,
                top: 782,
                child: Container(
                  width: 142,
                  height: 60,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 142,
                          height: 47,
                          decoration: ShapeDecoration(
                            color: Color(0xFF045F91),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 142,
                          height: 47,
                          child: ElevatedButton(
                            onPressed: () {
                              // Add your action for the DELETE button here
                              // For example, you can navigate to a new screen or perform any other action
                              print(
                                  'DELETE button pressed. Performing action...');
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF045F91),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              'DELETE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Rowdies',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 899,
                child: Container(
                  width: 430,
                  height: 43,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 430,
                          height: 43,
                          decoration: BoxDecoration(color: Colors.white),
                        ),
                      ),
                      Positioned(
                        left: 141,
                        top: 6,
                        child: GestureDetector(
                          onTap: () {
                            // Add your action for the Plus icon here
                            print('Plus icon pressed. Performing action...');
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            child: ElevatedButton(
                              onPressed: () {
                                // Add your action for the Plus icon here
                                print(
                                    'Plus icon pressed. Performing action...');
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.zero,
                              ),
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage("lib/images/Plus.jpeg"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 33,
                        top: 6,
                        child: GestureDetector(
                          onTap: () {
                            // Add your action for the Home icon here
                            print('Home icon pressed. Performing action...');
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            child: ElevatedButton(
                              onPressed: () {
                                // Add your actionfor the Home icon here
                                print(
                                    'Home icon pressed. Performing action...');
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.zero,
                              ),
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage("lib/images/Home.jpeg"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 249,
                        top: 6,
                        child: GestureDetector(
                          onTap: () {
                            // Add your action for the Notification icon here
                            print(
                                'Notification icon pressed. Performing action...');
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            child: ElevatedButton(
                              onPressed: () {
                                // Add your action for the Notification icon here
                                print(
                                    'Notification icon pressed. Performing action...');
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.zero,
                              ),
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage("lib/images/Notifaction.jpeg"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 357,
                        top: 11,
                        child: GestureDetector(
                          onTap: () {
                            // Add your action for the List icon here
                            print('List icon pressed. Performing action...');
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            child: ElevatedButton(
                              onPressed: () {
                                // Add your action for the List icon here
                                print(
                                    'List icon pressed. Performing action...');
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.zero,
                              ),
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage("lib/images/List.jpeg"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 23,
                top: 26,
                child: GestureDetector(
                  onTap: () {
                    // Add your action for the Back icon here
                    print('Back icon pressed. Performing action...');
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your action for the Back icon here
                        print('Back icon pressed. Performing action...');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage("lib/images/Back.jpeg"),
                      ),
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

*/
