/*
import 'package:flutter/material.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      debugShowCheckedModeBanner: false,
      home: ProfileUser(),
    );
  }
}

class ProfileUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          Container(
            width: 430,
            height: 932,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Color(0xFAFAFAFA)),
            child: Stack(children: [
              Positioned(
                left: 40,
                top: 37,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('Images/back.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 298,
                child: Container(
                  width: 378,
                  height: 48,
                  decoration: ShapeDecoration(
                    color: Color(0x00C4C4C4),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFFA8A8A8)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 396,
                child: Container(
                  width: 378,
                  height: 47,
                  decoration: ShapeDecoration(
                    color: Color(0x00C4C4C4),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFFA8A8A8)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 493,
                child: Container(
                  width: 378,
                  height: 48,
                  decoration: ShapeDecoration(
                    color: Color(0x00C4C4C4),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFFA8A8A8)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 271,
                child: SizedBox(
                  width: 87,
                  height: 25,
                  child: Text(
                    'Username',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 368,
                child: SizedBox(
                  width: 70,
                  height: 25,
                  child: Text(
                    'Email I’d',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 462,
                child: SizedBox(
                  width: 125,
                  height: 25,
                  child: Text(
                    'Phone Number',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 311,
                child: SizedBox(
                  width: 62,
                  height: 22,
                  child: Text(
                    'yANCHUI',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 408,
                child: SizedBox(
                  width: 149,
                  height: 21,
                  child: Text(
                    'yanchui@gmail.com',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 506,
                child: SizedBox(
                  width: 104,
                  height: 22,
                  child: Text(
                    '+14987889999',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 166,
                top: 110,
                child: Container(
                  width: 98,
                  height: 98,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('Images/Profile.jpeg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ]))));
  }
}
*/
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      debugShowCheckedModeBanner: false,
      home: ProfileUser(),
    );
  }
}

class ProfileUser extends StatefulWidget {
  @override
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  UserCredential? userCredential; // Initialize with null

  @override
  void initState() {
    super.initState();
    // Fetch the user credentials when the widget initializes
    getUserCredentials();
  }

  Future<void> getUserCredentials() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.signInAnonymously();
      print('User authenticated: ${userCredential.user?.uid}');
      setState(() {
        this.userCredential = userCredential;
      });
    } catch (e) {
      print("Error signing in anonymously: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 430,
                height: 932,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Color(0xFAFAFAFA)),
                child: FutureBuilder<DocumentSnapshot>(
                  future: userCredential != null
                      ? FirebaseFirestore.instance
                          .collection('userscars')
                          .doc(userCredential!.user!.uid)
                          .get()
                      : Future.error(
                          'User not authenticated'), // Handle null userCredential
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return Text('User data not found');
                    }

                    // Access the user data from Firestore
                    var userData =
                        snapshot.data!.data() as Map<String, dynamic>;

                    return Column(
                      children: [
                        Text('Username: ${userData['first_name']}'),
                        Text('Email: ${userData['email']}'),
                        Text('Phone Number: ${userData['phone']}'),
                      ],
                    );
                    
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
