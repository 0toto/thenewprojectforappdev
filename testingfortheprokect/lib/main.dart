import 'package:flutter/material.dart';
import './signUpPage.dart';
import './homeMenu.dart';
import './database_helper.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Log In Page',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _dbHelper = DataBaseHelper();

  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _dbHelper.init();
  }

  Future<bool> _loginUser(String name, String password) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final users = await _dbHelper.queryAllRows();

    try {
      final user = users.firstWhere(
            (user) => user[DataBaseHelper.columnName] == name,
      );

      if (user[DataBaseHelper.columnPassword] == password) {
        setState(() => _isLoading = false);
        return true;
      }
    } catch (e) {
      print(e);
    }

    setState(() {
      _isLoading = false;
      _errorMessage = 'Invalid name or password';
    });
    return false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF4c91f1),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Stack(
              children: <Widget>[
                Container(
                  child: Image(
                    image: NetworkImage(
                      'https://media.discordapp.net/attachments/398250264890703874/1098744835726393354/image.png?width=777&height=586', // Replace with your image URL
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 300.0, left: 35, right: 35),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
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
                        SizedBox(height: 10,),
                        TextFormField(
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
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white),),
                            onPressed: _isLoading ? null : () async {
                              if (_formKey.currentState!.validate()) {
                                final name = _nameController.text;
                                final password = _passwordController.text;
                                final isLogged = await _loginUser(name, password);
                                if (isLogged) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeMenu(),
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text('Invalid Login'),
                                      content: const Text('The name and password you entered do not match.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                  _nameController.clear();
                                  _passwordController.clear();
                                }
                              }
                            },
                            child: _isLoading
                                ? const CircularProgressIndicator()
                                : const Text('Log In', style: TextStyle(color: Colors.grey),),
                          ),
                        ),
                        if (_errorMessage.isNotEmpty)
                          Text(
                            _errorMessage,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        Padding(padding: EdgeInsets.only(left: 35),
                          child: Row(
                            children: <Widget>[
                              Text('Already have an account?'),
                              TextButton(
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SignUpPage()));
                                },
                                child: const Text('Sign Up', style: TextStyle(color: Colors.white),),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}