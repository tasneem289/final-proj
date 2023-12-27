import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:re7latekk/DatialsOfCarUser.dart';
import 'package:re7latekk/addCarrr.dart';
import 'package:re7latekk/homeUser.dart';


class Car {
  final String carId;
  final String color;
  final String model;
  final String seater;
  final String rental;
  final String imageUrl;

  Car({
    required this.carId,
    required this.color,
    required this.model,
    required this.seater,
    required this.rental,
    required this.imageUrl,
  });
}

class CarListScreenUser extends StatelessWidget {
  final String selectedSeats;
  final String selectedLocation;

  const CarListScreenUser({
    Key? key,
    required this.selectedSeats,
    required this.selectedLocation,
  }) : super(key: key);

  Future<ImageProvider> _getImageProvider(String imageUrl) async {
    if (imageUrl != null) {
      try {
        if (imageUrl is String && imageUrl.startsWith('https://')) {
          // If it's a direct HTTPS URL, use NetworkImage
          print('Direct URL: $imageUrl');
          return NetworkImage(imageUrl);
        } else if (imageUrl is String && imageUrl.startsWith('gs://')) {
          // If it's a Firebase Storage reference, use NetworkImage
          print('Firebase Storage URL: $imageUrl');
          return NetworkImage(imageUrl);
        } else {
          // Assume it's a path in Firebase Storage and fetch the URL
          final downloadUrl = await FirebaseStorage.instance
              .ref()
              .child(imageUrl)
              .getDownloadURL();
          print('Image URL: $downloadUrl');
          return NetworkImage(downloadUrl);
        }
      } catch (e) {
        print('Error loading image: $e');
      }
    }
    // Use a default image if 'imageUrl' is null or loading fails
    return AssetImage('Images/car.jpg');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars with $selectedSeats Seats'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Companies')
            .where('address', isEqualTo: selectedLocation)
            .snapshots(),
        builder: (context, companySnapshot) {
          if (companySnapshot.hasError) {
            return Center(child: Text('Error: ${companySnapshot.error}'));
          }

          if (companySnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!companySnapshot.hasData || companySnapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No companies found in selected city.'),
            );
          }

          List<String> companyIds =
              companySnapshot.data!.docs.map((doc) => doc.id).toList();

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('cars')
                .where('addedBy', whereIn: companyIds)
                .where('seater', isEqualTo: selectedSeats)
                .snapshots(),
            builder: (context, carSnapshot) {
              if (carSnapshot.hasError) {
                return Center(child: Text('Error: ${carSnapshot.error}'));
              }

              if (carSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!carSnapshot.hasData || carSnapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text('No cars found with $selectedSeats seats.'),
                );
              }

              print('Number of cars found: ${carSnapshot.data!.docs.length}');
              print('Company IDs: $companyIds');

              return ListView.builder(
                itemCount: carSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var carData = carSnapshot.data!.docs[index].data()
                      as Map<String, dynamic>;

                  print('Car data: $carData');

                  var car = Car(
                    carId: carSnapshot.data!.docs[index].id,
                    color: carData['color'],
                    model: carData['model'],
                    seater: carData['seater'],
                    rental: carData['rental'],
                    imageUrl: carData['image_url'],
                  );

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
                                      future: _getImageProvider(car.imageUrl),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: snapshot.data
                                                    as ImageProvider,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                strokeAlign: BorderSide
                                                    .strokeAlignCenter,
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
                                                strokeAlign: BorderSide
                                                    .strokeAlignCenter,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          // Handle Detail button press
                                          _viewCarDetails(context, car);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xFF045F91),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          _viewCarDetails(context, car);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          side: BorderSide(
                                              width: 1,
                                              color: Color(0xFF045F91)),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                },
              );
            },
          );
        },
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
                    builder: (context) => userhome(),
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
                    builder: (context) => const userhome(),
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

  void _viewCarDetails(BuildContext context, Car car) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetialsOFCarsUser(car: car),
      ),
    );
  }
}
