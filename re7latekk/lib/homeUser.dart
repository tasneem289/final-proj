import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:re7latekk/RolePage.dart';
import 'package:re7latekk/SerachScreenUser.dart';

class userhome extends StatelessWidget {
  const userhome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark().copyWith(
      //  scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      //),

      home: Scaffold(
        backgroundColor: const Color(0xFAFAFAFA),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home_outlined),
                iconSize: 32,
                color: const Color(0xFF045F91),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RolePage(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                iconSize: 32,
                color: const Color(0xFF045F91),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RolePage(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.notifications_none),
                iconSize: 32,
                color: const Color(0xFF045F91),
                onPressed: () {
                  print('Third IconButton Pressed');
                },
              ),
              Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    iconSize: 32,
                    color: const Color(0xFF045F91),
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
        body: const UserHome(),
      ),
    );
  }
}

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  String selectedLocation = 'Cairo'; // Default value
  String selectedDestination = 'Aswan'; // Default value
  DateTime _selectedDate = DateTime.now();
  bool seater1 = false;
  bool seater2 = false;
  bool seater3 = false;
  bool way = false;
  DateTime? selectedDate = DateTime.now();
  void showMyDatePicker() async {
    selectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    setState(() {});
  }

  void navigateToCarListScreen(String selectedSeats, String selectedLocation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarListScreenUser(
          selectedSeats: selectedSeats,
          selectedLocation: selectedLocation,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 430,
            height: 722.6,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Color(0xFAFAFAFA)),
            child: Stack(
              children: [
                Positioned(
                  left: 15,
                  top: 122,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        seater1 = !seater1;
                        seater2 = false;
                        seater3 = false;
                      });
                    },
                    child: Container(
                      // width: 129,
                      // height: 119,
                      width: 114.98,
                      height: 119,
                      decoration: BoxDecoration(
                        border: seater1
                            ? Border.all(
                                color: Colors.blue,
                              )
                            : Border.all(width: 0.0, color: Colors.white),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 10,
                            top: 22,
                            child: Container(
                              width: 100,
                              height: 73,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('Images/car3.jpg'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 29,
                            top: 94,
                            child: SizedBox(
                              width: 70,
                              height: 16,
                              child: Text(
                                '12 seater',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Rowdies',
                                  fontWeight: FontWeight.bold,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 138,
                  top: 122,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        seater2 = !seater2;
                        seater1 = false;
                        seater3 = false;
                      });
                    },
                    child: Container(
                      width: 114.98,
                      height: 119,
                      decoration: BoxDecoration(
                        border: seater2
                            ? Border.all(
                                color: Colors.blue,
                              )
                            : Border.all(width: 0.0, color: Colors.white),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          const Positioned(
                            left: 30,
                            top: 94,
                            child: SizedBox(
                              width: 70,
                              height: 16,
                              child: Text(
                                '7 seater',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Rowdies',
                                  fontWeight: FontWeight.bold,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 14.33,
                            top: 36,
                            child: Container(
                              width: 85.49,
                              height: 45.26,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("Images/car2.jpg"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 260,
                  top: 122,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        seater3 = !seater3;
                        seater1 = false;
                        seater2 = false;
                      });
                    },
                    child: Container(
                      width: 114.98,
                      height: 119,
                      decoration: BoxDecoration(
                        border: seater3
                            ? Border.all(
                                color: Colors.blue,
                              )
                            : Border.all(width: 0.0, color: Colors.white),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          const Positioned(
                            left: 28,
                            top: 94,
                            child: SizedBox(
                              width: 70,
                              height: 16,
                              child: Text(
                                '5 seater',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Rowdies',
                                  fontWeight: FontWeight.bold,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 13,
                            top: -2,
                            right: 10,
                            child: Container(
                              width: 99,
                              height: 99,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("Images/carSearch.jpg"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //Done

                Positioned(
                  left: 10,
                  top: 312,
                  right: 10,
                  child: Container(
                    width: 405,
                    height: 432,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 80,
                          top: 18,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                way = false;
                              });
                              // Handle One way button press
                              print('One way button pressed');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 7),
                              backgroundColor:
                                  way ? Colors.white : const Color(0xFF045F91),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'One way',
                                  style: TextStyle(
                                    color: way
                                        ? const Color(0xFF045F91)
                                        : Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    height: 0.10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 208,
                          top: 18,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                way = true;
                              });
                              // Handle Return button press
                              print('Return button pressed');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 7),
                              backgroundColor:
                                  way ? const Color(0xFF045F91) : Colors.white,
                              side: BorderSide(
                                width: 1,
                                color: way
                                    ? const Color(0xFF045F91)
                                    : Colors.white,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Return ',
                                  style: TextStyle(
                                    color: way
                                        ? Colors.white
                                        : const Color(0xFF5585C2),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    height: 0.10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 84,
                          child: Container(
                            width: 342,
                            height: 65,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0xFFB3B3B3)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Stack(
                              children: [
                                const Positioned(
                                  left: 64,
                                  top: 15,
                                  child: Text(
                                    'From (Location)',
                                    style: TextStyle(
                                      color: Color(0xFF999292),
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0.14,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 64,
                                  top: 35,
                                  child: Text(
                                    selectedLocation, // Use the selected value here
                                    style: const TextStyle(
                                      color: Color(0xFF606060),
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      height: 0.09,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 200,
                                  top: 20,
                                  child: SizedBox(
                                    width: 200,
                                    height: 40,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        dropdownColor: Colors.white,
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xFF045F91),
                                        ),
                                        iconSize: 24,
                                        value: selectedLocation,
                                        onChanged: (String? newValue) {
                                          if (newValue != null) {
                                            setState(() {
                                              selectedLocation = newValue;
                                            });
                                          }
                                        },
                                        items: <String>[
                                          'Cairo',
                                          'Minia',
                                          'Other Location 2',
                                          'Other Location 3'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: SizedBox(
                                              width: 200,
                                              height: 40,
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Color(0xFF045F91),
                                                    size: 24,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    value,
                                                    style: const TextStyle(
                                                      color: Color(0xFF888686),
                                                      fontSize: 14,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 12,
                                  top: 16,
                                  child: Container(
                                    width: 37,
                                    height: 37,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("Images/carIcon.jpg"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 162,
                          child: Container(
                            width: 342,
                            height: 65,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0xFFB3B3B3)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Stack(
                              children: [
                                const Positioned(
                                  left: 64,
                                  top: 15,
                                  child: Text(
                                    'To (Destination)',
                                    style: TextStyle(
                                      color: Color(0xFF999292),
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0.14,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 64,
                                  top: 35,
                                  child: Text(
                                    selectedDestination, // Use the selected value here
                                    style: const TextStyle(
                                      color: Color(0xFF606060),
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      height: 0.09,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 200,
                                  top: 20,
                                  child: SizedBox(
                                    width: 200,
                                    height: 40,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        dropdownColor: Colors.white,
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xFF045F91),
                                        ),
                                        iconSize: 24,
                                        value: selectedDestination,
                                        onChanged: (String? newValue) {
                                          if (newValue != null) {
                                            setState(() {
                                              selectedDestination = newValue;
                                            });
                                          }
                                        },
                                        items: <String>[
                                          'Aswan',
                                          'Minia',
                                          'Other Location 2',
                                          'Other Location 3'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: SizedBox(
                                              width: 200,
                                              height: 40,
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Color(0xFF045F91),
                                                    size: 24,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    value,
                                                    style: const TextStyle(
                                                      color: Color(0xFF888686),
                                                      fontSize: 14,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 11,
                                  top: 18,
                                  child: Container(
                                    width: 37,
                                    height: 37,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("Images/carIcon.jpg"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          top: 241,
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 9, left: 12, right: 25, bottom: 9),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0xFFB3B3B3)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    showMyDatePicker();
                                  },
                                  child: Container(
                                    width: 22,
                                    height: 22,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage("Images/calaender.jpg"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 19),
                                // Step 3: Display the selected date in the Text widget
                                Text(
                                  '${selectedDate?.day ?? ''}, ${selectedDate?.month ?? ''}, ${selectedDate?.year ?? ''}',
                                  style: const TextStyle(
                                    color: Color(0xFF888686),
                                    fontSize: 13,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    height: 0.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 90,
                          top: 345,
                          child: SizedBox(
                            width: 200,
                            height: 47,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 180,
                                    height: 47,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFF045F91),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left:
                                      0, // Adjusted left position to start from the left edge
                                  top:
                                      0, // Adjusted top position to start from the top edge
                                  child: SizedBox(
                                    width:
                                        200, // Adjusted width to match the Container width
                                    height:
                                        47, // Added height property to ensure the entire button is tappable
                                    child: ElevatedButton(
                                      onPressed: () {
                                        String selectedSeats = seater1
                                            ? '12'
                                            : (seater2
                                                ? '7'
                                                : (seater3
                                                    ? '5'
                                                    : '0')); // Make sure to use strings
                                        navigateToCarListScreen(
                                            selectedSeats, selectedLocation);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: const Color(
                                            0xFF045F91), // Background color
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                      ),
                                      child: const Center(
                                        // Centering the text within the button
                                        child: Text(
                                          'SEARCH',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                          ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
    onTap: () {
      // Handle Account
    },
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
