import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  final String color;
  final String model;
  final int seater;
  final String rental;
  final String imageUrl;

  Car({
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars with $selectedSeats Seats'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Companies')
            .where('address',
                isEqualTo:
                    selectedLocation) // Replace 'selectedCity' with your logic to get the selected city
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
                .where('company', whereIn: companyIds)
                .where('seater',
                    isEqualTo:
                        selectedSeats) // selectedSeats is already a String
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

              return ListView.builder(
                itemCount: carSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var carData = carSnapshot.data!.docs[index].data()
                      as Map<String, dynamic>;

                  try {
                    var car = Car(
                      color: carData['color'],
                      model: carData['model'],
                      seater: carData[
                          'seater'], // 'seater' is a String in Firestore
                      rental: carData['rental'],
                      imageUrl: carData['image_url'],
                    );

                    return ListTile(
                      title: Text(car.model),
                      subtitle:
                          Text('Color: ${car.color}, Rental: ${car.rental}'),
                      leading: Image.network(car.imageUrl),
                    );
                  } catch (e) {
                    print('Error creating Car object: $e');
                    return Container();
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
