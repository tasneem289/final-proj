import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:re7latekk/addCarrr.dart';

enum AddressChoice { Cairo, Giza, Tanta, Fayoum, Minia, Assiut, Sohag, Aswan }

class SignUpCompany extends StatelessWidget {
  const SignUpCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme:
            const TextSelectionThemeData(selectionColor: Colors.black),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: const RegistrationFields(),
      ),
    );
  }
}

class RegistrationFields extends StatefulWidget {
  const RegistrationFields({Key? key}) : super(key: key);

  @override
  _RegistrationFieldsState createState() => _RegistrationFieldsState();
}

class _RegistrationFieldsState extends State<RegistrationFields> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? fullName, email, password, phoneNumber, taxNumber;
  AddressChoice? selectedAddressChoice;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  Future<void> registerCompany() async {
    // Perform sign-up logic
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddCar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(color: Colors.grey, fontSize: 16);
    const inputStyle = TextStyle(color: Colors.black, fontSize: 18);

    buildAddressDropdown(TextStyle labelStyle, TextStyle inputStyle) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonFormField<AddressChoice>(
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'ADDRESS',
                labelStyle: labelStyle,
              ),
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              style: inputStyle,
              value: selectedAddressChoice,
              onChanged: (AddressChoice? value) {
                setState(() {
                  selectedAddressChoice = value;
                });
              },
              items: AddressChoice.values.map((AddressChoice choice) {
                return DropdownMenuItem<AddressChoice>(
                  value: choice,
                  child: Text(
                    choice.toString().split('.').last,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList(),
              dropdownColor: Colors.white,
            ),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode:
            _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 330,
              height: 330,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Images/SignUpCompany.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Color(0xFF164863),
                      fontSize: 28,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildGrayBoxTextField(
                    'FULL NAME',
                    'Enter your full name',
                    labelStyle,
                    inputStyle,
                    onChanged: (value) {
                      setState(() {
                        fullName = value.trim();
                      });
                    },
                    validator: (value) =>
                        validateRequiredField(value, 'full name'),
                  ),
                  const SizedBox(height: 5),
                  buildGrayBoxTextField(
                    'PHONE NUMBER',
                    'Enter your phone number',
                    labelStyle,
                    inputStyle,
                    onChanged: (value) {
                      setState(() {
                        phoneNumber = value;
                      });
                    },
                    validator: (value) =>
                        validateRequiredField(value, 'phone number'),
                  ),
                  const SizedBox(height: 5),
                  buildGrayBoxTextField(
                    'TAX NUMBER',
                    'Enter your tax number',
                    labelStyle,
                    inputStyle,
                    onChanged: (value) {
                      setState(() {
                        taxNumber = value;
                      });
                    },
                    validator: (value) =>
                        validateRequiredField(value, 'tax number'),
                  ),
                  const SizedBox(height: 5),
                  buildAddressDropdown(labelStyle, inputStyle),
                  const SizedBox(height: 5),
                  buildGrayBoxTextField(
                    'EMAIL',
                    'Enter your email',
                    labelStyle,
                    inputStyle,
                    onChanged: (value) {
                      setState(() {
                        email = value.trim();
                      });
                    },
                    validator: (value) => validateEmail(value),
                  ),
                  const SizedBox(height: 5),
                  buildGrayBoxTextField(
                    'PASSWORD',
                    'Enter your password',
                    labelStyle,
                    inputStyle,
                    obscureText: true,
                    validator: (value) => validatePassword(value),
                    onChanged: (value) {
                      setState(() {
                        password = value.trim();
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          _autoValidate = true;
                        });

                        if (_formKey.currentState!.validate()) {
                          await registerCompany();

                          try {
                            UserCredential userCredential =
                                await _auth.createUserWithEmailAndPassword(
                              email: email!,
                              password: password!,
                            );

                            if (userCredential.user != null) {
                              await _firestore
                                  .collection('Companies')
                                  .doc(userCredential.user!.uid)
                                  .set({
                                'full_name': fullName,
                                'phoneNumber': phoneNumber,
                                'taxNumber': taxNumber,
                                'address': selectedAddressChoice
                                    .toString()
                                    .split('.')
                                    .last,
                                'email': email,
                              });
                            }
                          } catch (e) {
                            print(e);
                            final snackBar = SnackBar(
                                content: Text(
                                    'Error registering company. ${e.toString()}'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      },
                      child: Container(
                        width: 180,
                        height: 47,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          color: Color(0xFF045F91),
                        ),
                        child: const Center(
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
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

  Widget buildGrayBoxTextField(
    String label,
    String hint,
    TextStyle labelStyle,
    TextStyle inputStyle, {
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    bool obscureText = false,
  }) {
    return TextFormField(
      style: TextStyle(color: Colors.black, fontSize: 18),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: labelStyle,
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
    );
  }

  String? validateRequiredField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
        .hasMatch(value)) {
      return 'Invalid Email Format';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+,-./:;<=>?@[\]^_`{|}~])')
        .hasMatch(value)) {
      return 'Password must include uppercase, lowercase, number, and special character';
    }
    return null;
  }
}
