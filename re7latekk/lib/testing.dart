import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      body: SingleChildScrollView(
        child: CarGrid(),
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
            color: Color(0xFFF9F9F9),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> carData =
                    documents[index].data() as Map<String, dynamic>;

                return GestureDetector(
                  onTap: () {
                    _viewCarDetails(context, carData, documents[index].id);
                  },
                  child:
                      CarListItem(carData: carData, carId: documents[index].id),
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

class CarListItem extends StatelessWidget {
  final Map<String, dynamic> carData;
  final String carId;

  CarListItem({Key? key, required this.carData, required this.carId});

  Future<ImageProvider> _getImageProvider() async {
    if (carData['image_url'] != null) {
      try {
        if (carData['image_url'] is String &&
            (carData['image_url'] as String).startsWith('https://')) {
          // If it's a direct HTTPS URL, use NetworkImage
          print('Direct URL: ${carData['image_url']}');
          return NetworkImage(carData['image_url']);
        } else if (carData['image_url'] is String &&
            (carData['image_url'] as String).startsWith('gs://')) {
          // If it's a Firebase Storage reference, use NetworkImage
          print('Firebase Storage URL: ${carData['image_url']}');
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        height: 264,
        padding: const EdgeInsets.only(
          top: 20,
          left: 16,
          right: 16,
          bottom: 12,
        ),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 170,
                      height: 77.05,
                      child: FutureBuilder(
                        future: _getImageProvider(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: snapshot.data as ImageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '\$${carData['rental'] ?? ''}',
                          style: TextStyle(
                            color: Color(0xFF0C0C0C),
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0, 0.0)
                            ..rotateZ(1.57),
                          child: Container(
                            width: 18,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0xFFE6E6E6),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${carData['seater'] ?? ''} seats',
                          style: TextStyle(
                            color: Color(0xFFAAAAAA),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0, 0.0)
                            ..rotateZ(1.57),
                          child: Container(
                            width: 18,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0xFFE6E6E6),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${carData['model'] ?? ''}',
                          style: TextStyle(
                            color: Color(0xFFAAAAAA),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle Rent Now button press
                            // Add your logic here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF045F91),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Rent Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            // Handle Detail button press
                            // Add your logic here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            side:
                                BorderSide(width: 1, color: Color(0xFF045F91)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Detail',
                            style: TextStyle(
                              color: Color(0xFF045F91),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
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
