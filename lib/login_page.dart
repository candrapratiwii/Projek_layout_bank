import 'package:flutter/material.dart';
import 'home_page.dart'; // Import HomePage untuk navigasi

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      if (usernameController.text == passwordController.text) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Username dan password harus sama dengan NIM!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(height: MediaQuery.of(context).padding.top),
            
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 15),
              color: Color(0xFF1A237E),
              child: Center(
                child: Text(
                  'Koperasi Undiksha',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Image.asset(
                        'assets/logo.png',
                        width: 150,
                        height: 150,
                      ),
                      SizedBox(height: 30),
                      
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 1),
                            ),
                          ],
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        padding: EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Username', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              SizedBox(height: 5),
                              TextFormField(
                                controller: usernameController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                validator: (value) => value!.isEmpty ? 'Username tidak boleh kosong' : null,
                              ),
                              SizedBox(height: 15),
                              
                              Text('Password', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              SizedBox(height: 5),
                              TextFormField(
                                controller: passwordController,
                                obscureText: !_isPasswordVisible,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible = !_isPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) => value!.isEmpty ? 'Password tidak boleh kosong' : null,
                              ),
                              SizedBox(height: 20),
                              
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF1A237E),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                                  ),
                                  onPressed: _login,
                                  child: Text('Login', style: TextStyle(fontSize: 16, color: Colors.white)),
                                ),
                              ),
                              
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text('Daftar Mbanking', style: TextStyle(color: Color(0xFF1A237E), fontSize: 12)),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text('Lupa password?', style: TextStyle(color: Color(0xFF1A237E), fontSize: 12)),
                                  ),
                                ],
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
            
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10),
              color: Color(0xFFD1D9E6),
              child: Center(
                child: Text('copyright @2022 by Undiksha', style: TextStyle(fontSize: 12, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}