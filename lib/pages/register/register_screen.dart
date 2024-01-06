import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_store/pages/signin/signin_screen.dart';

import '../../bloc/authbloc/auth_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Text('Ecommerce Store',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold

                    ),

                  ),
                  Text('Sign In',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold

                    ),

                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    enableSuggestions: true,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      _firstName = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'First Name',
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter First Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  TextFormField(
                    enableSuggestions: true,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      _lastName = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.white
                        )
                      ),
                      hintText: 'Last Name',
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Last Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  TextFormField(
                    enableSuggestions: true,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      _email = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Email',
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Invalid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    enableSuggestions: true,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) {
                      _password = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Password',
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Password is too short';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    enableSuggestions: true,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) {
                      _confirmPassword = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Confirm Password',
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    validator: (value) {
                      if (value != _password) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: ()  {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => SignInScreen()),
                              (route) => false,
                        );
                      },
                      child: Text(
                        'Already have an account? Sign In',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await context.read<AuthCubit>().signUpWithEmailAndPassword(
                              firstName: _firstName,
                              lastName: _lastName,
                              email: _email,
                              password: _password,
                              context: context,
                            );
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => SignInScreen()),
                                  (route) => false,
                            );
                          } catch (e) {
                            // Handle registration failure, if needed
                            print('Registration failed: $e');
                          }
                        }
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
