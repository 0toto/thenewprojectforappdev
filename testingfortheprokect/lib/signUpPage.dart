import 'package:flutter/material.dart';
import './main.dart';
import './database_helper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _dbHelper = DataBaseHelper();

  @override
  void initState() {
    super.initState();
    _dbHelper.init();
  }

  bool isPasswordValid(String password) {
    // Add your password validation logic here
    // For example, a valid password should have at least 8 characters
    return password.length >= 8;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4c91f1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    child: Image(
                      image: NetworkImage(
                        'https://media.discordapp.net/attachments/398250264890703874/1098744835726393354/image.png?width=777&height=586', // Replace with your image URL
                      ),
                    ),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15, left: 35, right: 35),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15, left: 35, right: 35),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (!isPasswordValid(value)) {
                            return 'Password should have at least 8 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 35),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 5,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final name = _nameController.text;
                                  final password = _passwordController.text;
                                  final row = {
                                    DataBaseHelper.columnName: name,
                                    DataBaseHelper.columnPassword: password,
                                  };
                                  await _dbHelper.insert(row);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginPage()),
                                  );
                                }
                              },
                              child: const Text('Sign Up', style: TextStyle(color: Colors.grey),),
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 35),
                      child: Row(
                        children: <Widget>[
                          Text('Already have an account?'),
                          TextButton(
                            onPressed: () async {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                            child: const Text('Log In', style: TextStyle(color: Colors.white),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
