import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:re7latekk/RolePage.dart';
import 'package:re7latekk/addCarrr.dart';
import 'package:re7latekk/companyHome.dart';
import 'package:re7latekk/testing.dart';

class CarView extends StatelessWidget {
  final Map<String, dynamic> carData;
  final String docId;

  const CarView({Key? key, required this.carData, required this.docId})
      : super(key: key);

  Future<void> _deleteCar(BuildContext context, String carId) async {
    try {
      await FirebaseFirestore.instance.collection('cars').doc(carId).delete();
      print('Car deleted successfully!');
    } catch (e) {
      print('Error deleting car: $e');
    }
  }

  Future<ImageProvider> _getImageProvider() async {
    if (carData['image_url'] != null) {
      try {
        if (carData['image_url'] is String &&
            (carData['image_url'] as String).startsWith('https://')) {
          // If it's a direct HTTPS URL, use NetworkImage
          return NetworkImage(carData['image_url']);
        } else if (carData['image_url'] is String &&
            (carData['image_url'] as String).startsWith('gs://')) {
          // If it's a Firebase Storage reference, use NetworkImage
          return NetworkImage(carData['image_url']);
        } else {
          // Assume it's a path in Firebase Storage and fetch the URL
          final imageUrl = await FirebaseStorage.instance
              .ref()
              .child(carData['image_url'])
              .getDownloadURL();
          print('Image URL: $imageUrl');
          return NetworkImage(imageUrl);
        }
      } catch (e) {
        print('Error loading image: $e');
        // Return a default image in case of an error
        return AssetImage('Images/car.jpg');
      }
    }
    // Use a default image if 'image_url' is null
    return AssetImage('Images/car.jpg');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  width: 400,
                  height: 700,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Color(0xFFF9F9F9)),
                  child: Stack(
                    children: [
                      FutureBuilder<ImageProvider>(
                        future: _getImageProvider(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Positioned(
                              left: 100,
                              top: 120,
                              child: Container(
                                width: 220,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: snapshot.data!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                                'Error loading image: ${snapshot.error}');
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                      const Positioned(
                        left: 17,
                        top: 380,
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
                      const Positioned(
                        left: 17,
                        top: 380,
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
                        left: 15,
                        top: 450,
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
                              const Positioned(
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
                        left: 118,
                        top: 450,
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
                              const Positioned(
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
                                    carData['model'] ?? '',
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
                        left: 220,
                        top: 450,
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
                              const Positioned(
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
                        left: 320,
                        top: 450,
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
                              const Positioned(
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
                                left: 4,
                                top: 42,
                                child: SizedBox(
                                  width: 56,
                                  height: 21,
                                  child: Text(
                                    carData['rental'] ?? '',
                                    style: const TextStyle(
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
                      const Positioned(
                        left: 350,
                        top: 500,
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
                        top: 580,
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
                                      _deleteCar(context, docId);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ),
                                      );
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
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home_outlined),
              iconSize: 32,
              color: Color(0xFF045F91),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              iconSize: 32,
              color: Color(0xFF045F91),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddCar(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications_none),
              iconSize: 32,
              color: Color(0xFF045F91),
              onPressed: () {
                print('Third IconButton Pressed');
              },
            ),
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(Icons.menu),
                  iconSize: 32,
                  color: Color(0xFF045F91),
                  onPressed: () {
                    // Open the drawer
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Center(
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              myListTitle('Account', "Images/account.jpg"),
              myDivider(),
              myListTitle('Notifications', "Images/notification.jpg"),
              myDivider(),
              myListTitle('Language', "Images/lang.jpg"),
              myDivider(),
              myListTitle('Terms & Conditions', "Images/terms.jpg"),
              myDivider(),
              myListTitle('Privacy Policy', "Images/privacy.jpg"),
              myDivider(),
              myListTitle('About', "Images/about.jpg"),
              myDivider(),
              myListTitle('Logout', "Images/logout.jpg"),
              myDivider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget myListTitle(String text, String imgUrl) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imgUrl),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Color.fromARGB(255, 41, 40, 38),
              fontSize: 18,
            ),
          ),
          arrowIcon(),
        ],
      ),
      onTap: () {},
    );
  }

  Widget arrowIcon() {
    return Icon(
      Icons.arrow_forward_ios_sharp,
      size: 20,
    );
  }

  Widget myDivider() {
    return Divider(
      height: 10,
      color: Color.fromARGB(255, 230, 227, 227),
      indent: 20,
      endIndent: 20,
    );
  }
}
