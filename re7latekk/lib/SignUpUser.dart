import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:re7latekk/LogInCompany.dart';
import 'package:re7latekk/RolePage.dart';
import 'package:re7latekk/get_start.dart';
import 'package:re7latekk/homeUser.dart';

class SignUpForUser extends StatefulWidget {
  const SignUpForUser({Key? key}) : super(key: key);

  @override
  State<SignUpForUser> createState() => _ScreenState();
}

class _ScreenState extends State<SignUpForUser> {
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();
  var pass = TextEditingController();
  String? con = "Cairo";
  bool? checked = false;

  // Function to validate email format
  bool _validateEmail(String email) {
    // Use a regular expression to check if the email matches the desired pattern
    RegExp emailRegex = RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(email);
  }

  Future<void> _signUp() async {
    try {
      // Validate email format
      if (!_validateEmail(email.text)) {
        throw 'Invalid email format';
      }

      // Use Firebase Authentication to register the user
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: pass.text,
      );

      // If registration is successful, store additional user details in Firestore
      if (userCredential.user != null) {
        await FirebaseFirestore.instance
            .collection('userscars')
            .doc(userCredential.user!.uid)
            .set({
          'first_name': firstname.text,
          'last_name': lastname.text,
          'phone': phone.text,
          'email': email.text,
        });

        // Navigate to the next screen
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const userhome(),
          ),
        );
      }
    } catch (e) {
      print(e);

      // Display error message for invalid email format
      if (e == 'Invalid email format') {
        final snackBar = SnackBar(
            content: Text('Invalid email format. Please enter a valid email.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        // Display generic error message for other registration errors
        final snackBar =
            SnackBar(content: Text('Error registering user. ${e.toString()}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RolePage(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 5, 91, 161),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Join the exciting adventure!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 3, 86, 128),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  DefaultFieldForm(
                    controller: firstname,
                    keyboard: TextInputType.name,
                    label: 'First Name',
                    valid: (data) {
                      if (data!.isEmpty) {
                        return 'Field is Required';
                      } else if (data.length <= 2) {
                        return 'Name isn\'t Valid ';
                      } else if (RegExp(r'\d').hasMatch(data)) {
                        return 'Name should not contain numbers';
                      }
                    },
                    hint: 'Enter Your First Name',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DefaultFieldForm(
                    controller: lastname,
                    keyboard: TextInputType.name,
                    label: 'Last Name',
                    valid: (data) {
                      if (data!.isEmpty) {
                        return 'Field is Required';
                      } else if (data.length <= 2) {
                        return 'Name isn\'t Valid ';
                      } else if (RegExp(r'\d').hasMatch(data)) {
                        return 'Name should not contain numbers';
                      }
                    },
                    hint: 'Enter Your last Name',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey[400]!,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50, right: 10),
                      child: DropdownButton<String>(
                        items: [
                          "Cairo",
                          "Sohag",
                          "Alexandria",
                          "Minia",
                          "Assiut",
                          "Aswan",
                          "Giza",
                          "Bani Sweif",
                          "Tanta",
                          "Fayoum"
                        ]
                            .map(
                              (e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 92, 90,
                                        90), // Set the text color to black
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            con = value;
                          });
                        },
                        hint: const Text(
                          'City / Municipality',
                          style: TextStyle(
                              color: Color.fromARGB(255, 184, 183, 183)),
                        ),
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(10),
                        underline: Container(
                          height: 1.0,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide.none,
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                        value: con,
                        dropdownColor: Colors.white,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DefaultFieldForm(
                    controller: phone,
                    keyboard: TextInputType.phone,
                    label: 'Mobile Number',
                    valid: (data) {
                      if (data!.isEmpty) {
                        return 'Field is Required';
                      } else if (data.length < 10) {
                        return 'Mobile number is too short';
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(data)) {
                        return 'Invalid characters in the mobile number';
                      }
                    },
                    hint: 'Enter Your Number',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DefaultFieldForm(
                    controller: email,
                    keyboard: TextInputType.emailAddress,
                    label: 'Email Address',
                    valid: (data) {
                      if (data!.isEmpty) {
                        return 'Field is Required';
                      } else if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                          .hasMatch(data)) {
                        return 'Invalid Email Format';
                      }
                    },
                    hint: 'Enter Your Email Address',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DefaultFieldForm(
                    controller: pass,
                    keyboard: TextInputType.visiblePassword,
                    show: false,
                    label: 'Password',
                    suffix: Icons.remove_red_eye_outlined,
                    suffixPress: () {
                      // Handle suffix press if needed
                    },
                    valid: (data) {
                      if (data!.isEmpty) {
                        return 'Field is Required';
                      } else if (data.length < 8) {
                        return 'Password must be at least 8 characters long';
                      } else if (!RegExp(
                              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+,-./:;<=>?@[\]^_`{|}~])')
                          .hasMatch(data)) {
                        return 'Password must include uppercase, lowercase, number, and special character';
                      }
                    },
                    hint: 'Enter Your password',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: checked,
                        activeColor: Colors.blueGrey,
                        onChanged: (value) {
                          setState(
                            () {
                              checked = value;
                            },
                          );
                        },
                      ),
                      const Text(
                        'Agree the terms of use and privacy policy',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  DefaultButton(
                    checked: checked!,
                    formkey: formKey,
                    buttonWidget: const Text(
                      'SIGN UP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    ////////
                    function: _signUp,
                    width: 200,
                    backgroundColor: const Color(0xFF045F91),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => logincompany(),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Have an account? ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Log In',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DefaultButton extends StatelessWidget {
  Widget buttonWidget;
  Function() function;
  double width;
  Color? backgroundColor = Colors.black;
  bool isUpperCase;
  double radius;
  double height;
  Color borderColor;
  bool checked;
  GlobalKey<FormState>? formkey;
  DefaultButton({
    super.key,
    this.checked = false,
    this.formkey,
    this.height = 50,
    required this.buttonWidget,
    required this.function,
    this.backgroundColor,
    this.width = double.infinity,
    this.isUpperCase = true,
    this.radius = 15.0,
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: MaterialButton(
        onPressed: () async {
          if (formkey!.currentState!.validate()) {
            if (checked == true) {
              await function();
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const GetStart(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("you should Accept the terms ")),
              );
            }
          }
        },
        child: buttonWidget,
      ),
    );
  }
}

// ignore: must_be_immutable
class DefaultFieldForm extends StatefulWidget {
  TextEditingController controller;
  TextInputType keyboard;
  // ignore: prefer_typing_uninitialized_variables
  String? label;
  String? hint;
  IconData? prefix;
  bool show;
  // ignore: prefer_typing_uninitialized_variables
  var tap;
  // ignore: prefer_typing_uninitialized_variables
  var onchange;
  // ignore: prefer_typing_uninitialized_variables
  var onSubmit;
  IconData? suffix;
  Function()? suffixPress;
  TextStyle? labelStyle;
  TextStyle? hintStyle;
  final String? Function(String?)? valid; // Validator function

  DefaultFieldForm({
    super.key,
    required this.controller,
    required this.keyboard,
    required this.valid,
    this.hint,
    this.label,
    this.prefix,
    this.show = false,
    this.tap,
    this.onchange,
    this.onSubmit,
    this.suffix,
    this.suffixPress,
    this.labelStyle,
    this.hintStyle,
  });

  @override
  // ignore: navrary_private_types_in_public_api
  _DefaultFieldFormState createState() => _DefaultFieldFormState();
}

class _DefaultFieldFormState extends State<DefaultFieldForm> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Colors.black,
      ),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      validator: widget.valid ?? (data) {},
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: widget.hintStyle,
        labelText: widget.label,
        labelStyle: widget.labelStyle,
        contentPadding: const EdgeInsets.all(17),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        errorStyle: const TextStyle(color: Colors.red, fontSize: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        prefixIcon: Icon(widget.prefix, color: Colors.black),
        suffixIcon: widget.suffix != null && widget.suffixPress != null
            ? (widget.keyboard == TextInputType.visiblePassword
                ? IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                      if (widget.suffixPress != null) {
                        widget.suffixPress!();
                      }
                    },
                    color: Colors.blueGrey,
                  )
                : null)
            : null,
      ),
      keyboardType: widget.keyboard,
      onFieldSubmitted: widget.onSubmit,
      onChanged: widget.onchange,
      obscureText: widget.keyboard == TextInputType.visiblePassword
          ? !_showPassword
          : false,
      onTap: widget.tap,
    );
  }
}
