/*
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Add this import
import 'package:re7latekk/addCarrr.dart';
import 'package:re7latekk/companyViewCar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CarGrid(),
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
            IconButton(
              icon: Icon(Icons.menu),
              iconSize: 32,
              color: Color(0xFF045F91),
              onPressed: () {
                print('Fourth IconButton Pressed');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CarGrid extends StatelessWidget {
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  CarGrid({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('cars')
          .where('addedBy', isEqualTo: currentUserId)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

          return Container(
            width: 430,
            height: 932,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Color(0xFFF9F9F9)),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> carData =
                    documents[index].data() as Map<String, dynamic>;

                return GestureDetector(
                  onTap: () {
                    _viewCarDetails(context, carData, documents[index].id);
                  },
                  child:
                      CarGridItem(carData: carData, carId: documents[index].id),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  void _viewCarDetails(
      BuildContext context, Map<String, dynamic> carData, String carId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarView(carData: carData, docId: carId),
      ),
    );
  }
}

class CarGridItem extends StatelessWidget {
  final Map<String, dynamic> carData;
  final String carId;

  CarGridItem({Key? key, required this.carData, required this.carId});

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
      }
    }
    // Use a default image if 'image_url' is null or loading fails
    return AssetImage('Images/car.jpg');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _viewCarDetails(context, carData, carId);
      },
      child: Container(
        width: 182,
        height: 270,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: FutureBuilder(
          future: _getImageProvider(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  Positioned(
                    left: 6,
                    top: 44,
                    child: Container(
                      width: 170,
                      height: 77.05,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: snapshot.data as ImageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 29,
                    top: 132.70,
                    child: SizedBox(
                      width: 130,
                      height: 21.40,
                      child: Text(
                        carData['model'] ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Rowdies',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 164.38,
                    child: SizedBox(
                      width: 13,
                      height: 21.40,
                      child: Text(
                        carData['seater'] ?? '',
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
                  const Positioned(
                    left: 55,
                    top: 164.38,
                    child: SizedBox(
                      width: 74,
                      height: 21.40,
                      child: Opacity(
                        opacity: 0.50,
                        child: Text(
                          'SEATER',
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
                  ),
                  Positioned(
                    left: 73,
                    top: 190,
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
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  void _viewCarDetails(
      BuildContext context, Map<String, dynamic> carData, String carId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarView(carData: carData, docId: carId),
      ),
    );
  }
}
*/