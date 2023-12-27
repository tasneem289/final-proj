// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:re7latekk/LogInCompany.dart';
import 'package:re7latekk/RolePage.dart';
import 'package:re7latekk/homeUser.dart';

class SignUpForUser extends StatefulWidget {
  const SignUpForUser({Key? key}) : super(key: key);

  @override
  State<SignUpForUser> createState() => _ScreenState();
}

class _ScreenState extends State<SignUpForUser> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();
  var pass = TextEditingController();
  var con;
  bool? checked = false;

  Future<void> _signUp() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: pass.text,
      );

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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => userhome(),
          ),
        );
      }
    } catch (e) {
      print(e);
      final snackBar =
          SnackBar(content: Text('Error registering user. ${e.toString()}'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
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
                    IconButton(
                      icon:
                          Container(), // Empty container to expand the tap area
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RolePage(),
                          ),
                        );
                      },
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
                  valid: (value) {},
                  hint: 'Enter Your First Name',
                ),
                const SizedBox(
                  height: 15,
                ),
                DefaultFieldForm(
                  controller: lastname,
                  keyboard: TextInputType.name,
                  label: 'Last Name',
                  valid: (value) {},
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
                      color: Colors.grey[500]!,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50, right: 10),
                    child: DropdownButton(
                      items: [
                        "cairo",
                        "sohag",
                        "alexandria",
                        "minia",
                        "assiut",
                        "aswan",
                        "giza",
                        "Bani Sweif",
                        "Tanta",
                        "Fayoum"
                      ]
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
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
                        fontSize: 18,
                      ),
                      value: con,
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
                  valid: (value) {},
                  hint: 'Enter Your Number',
                ),
                const SizedBox(
                  height: 15,
                ),
                DefaultFieldForm(
                  controller: email,
                  keyboard: TextInputType.emailAddress,
                  label: 'Email Address',
                  valid: (value) {},
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
                  suffixPress: () {},
                  valid: (value) {},
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
                  buttonWidget: const Text(
                    'SIGN UP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
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

  DefaultButton({
    super.key,
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
          await function();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserHome(),
            ),
          );
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
  var valid;
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
  // ignore: library_private_types_in_public_api
  _DefaultFieldFormState createState() => _DefaultFieldFormState();
}

class _DefaultFieldFormState extends State<DefaultFieldForm> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      validator: widget.valid,
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
