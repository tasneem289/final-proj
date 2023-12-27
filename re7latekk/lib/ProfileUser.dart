import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({Key? key}) : super(key: key);

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
  late Stream<DocumentSnapshot> _userStream;

  @override
  void initState() {
    super.initState();
    _userStream = FirebaseFirestore.instance
        .collection('userscars')
        .doc('YOUR_USER_ID_HERE')
        .snapshots();
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
                child: Stack(
                  children: [
                    // ... [Your Positioned widgets and other design elements]
                  ],
                ),
              ),
              StreamBuilder<DocumentSnapshot>(
                stream: _userStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.data!.data() == null) {
                    return Center(child: Text("No user data available."));
                  }

                  var userData = snapshot.data!.data()! as Map<String, dynamic>;
                  return Column(
                    children: [
                      SizedBox(
                        width: 87,
                        height: 25,
                        child: Text(
                          'Username: ${userData['username']}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        height: 25,
                        child: Text(
                          'Email: ${userData['email']}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 125,
                        height: 25,
                        child: Text(
                          'Phone Number: ${userData['phoneNumber']}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // ... [You can add more fields if needed]
                    ],
                  );
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('Home icon pressed. Performing action...');
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            child: ElevatedButton(
                              onPressed: () {
                                print(
                                    'Home icon pressed. Performing action...');
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.zero,
                              ),
                              child: Image.asset('lib/Images/home.png'),
                            ),
                          ),
                        ),
                        // ... Other GestureDetector widgets remain the same ...
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
