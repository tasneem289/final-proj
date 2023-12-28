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
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Center(
                  child: Text(
                    'RE7LETAK For Cars',
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
    return const Icon(
      Icons.arrow_forward_ios_sharp,
      size: 20,
    );
  }

  Widget myDivider() {
    return const Divider(
      height: 10,
      color: Color.fromARGB(255, 230, 227, 227),
      indent: 20,
      endIndent: 20,
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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: InkWell(
        onTap: () {
          _viewCarDetails(context, carData, carId);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                child: FutureBuilder(
                  future: _getImageProvider(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Image(
                        image: snapshot.data as ImageProvider,
                        fit: BoxFit.cover,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(
                  255,
                  255,
                  255,
                  255,
                ), // The new background color
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(25)),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      carData['model'] ?? '',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${carData['seater'] ?? ''} SEATER',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      carData['color'] ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
