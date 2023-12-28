import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:re7latekk/companyHome.dart';

class addcar extends StatelessWidget {
  const addcar({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      debugShowCheckedModeBanner: false,
      home: const AddCar(),
    );
  }
}

class AddCar extends StatefulWidget {
  const AddCar({Key? key});

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _seatsController = TextEditingController();
  final TextEditingController _rentalController = TextEditingController();
  File? _imageFile;
  late String _url = '';

  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Add the form key here
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: HexColor('#055f91'),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _imageFile == null,
                  child: SizedBox(
                    width: double.infinity,
                    height: 350,
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            _selectImage();
                          },
                          child: Center(
                            child: _imageFile != null
                                ? Image.file(_imageFile!)
                                : Image.asset('Images/car.jpg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Visibility(
                    visible: _imageFile != null,
                    child: SizedBox(
                      width: double.infinity,
                      height: 350,
                      child: GridView.builder(
                        itemCount: _imageFile != null ? 1 : 0,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Image.file(
                            _imageFile!,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 30),
                    child: Column(
                      children: [
                        CustomTextForm(
                          hintText: 'COLOUR',
                          controller: _colorController,
                        ),
                        const SizedBox(height: 10),
                        CustomTextForm(
                          hintText: 'CAR MODEL',
                          controller: _modelController,
                        ),
                        const SizedBox(height: 10),
                        CustomTextForm(
                          hintText: 'SEATER',
                          controller: _seatsController,
                        ),
                        const SizedBox(height: 10),
                        CustomTextForm(
                          hintText: 'RENTAL PRICE',
                          controller: _rentalController,
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: 130,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: HexColor('#055f91'),
                          ),
                          child: TextButton(
                            child: const Text(
                              'ADD CAR',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _addCar();
                            },
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
      ),
    );
  }

  void _selectImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> uploadImage(BuildContext context) async {
    try {
      FirebaseStorage storage =
          FirebaseStorage.instanceFor(bucket: 'gs://re7la-app.appspot.com');
      Reference? ref;

      if (_imageFile != null) {
        ref = storage.ref().child(p.basename(_imageFile!.path));
        UploadTask storageUploadTask = ref.putFile(_imageFile!);
        TaskSnapshot? taskSnapshot =
            await storageUploadTask.whenComplete(() {});

        if (taskSnapshot != null) {
          String url = await taskSnapshot.ref.getDownloadURL();
          print('url $url');
          setState(() {
            _url = url; // Correct assignment
          });
        } else {
          print('Upload failed');
        }
      } else {
        print('No image selected');
      }
    } catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text((ex as Exception).toString())),
      );
    }
  }

  Future<void> _addCar() async {
    try {
      if (_formKey.currentState!.validate()) {
        // Upload the image to Firebase Storage and wait for completion
        await uploadImage(context);

        String currentUserId = FirebaseAuth.instance.currentUser!.uid;

        // Add the car data to Firestore
        DocumentReference carRef =
            await FirebaseFirestore.instance.collection('cars').add({
          'color': _colorController.text,
          'model': _modelController.text,
          'seater': _seatsController.text,
          'rental': _rentalController.text,
          'image_url': _url,
          'addedBy': currentUserId,
        });

        _formKey.currentState!.reset();
        _colorController.clear();
        _modelController.clear();
        _rentalController.clear();
        _seatsController.clear();
        _imageFile = null;

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Car added successfully'),
        ));

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error adding car: $error'),
      ));
    }
  }
}

class CustomTextForm extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomTextForm({
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.0),
        ),
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey.shade300,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null; // Return null for valid input
      },
    );
  }
}
