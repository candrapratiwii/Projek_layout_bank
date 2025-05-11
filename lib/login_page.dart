import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Fungsi untuk login
  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('username');
    final savedPassword = prefs.getString('password');

    // Jika akun sudah ada (seperti desak@student.undiksha.ac.id dengan password 123456)
    if (username == 'desak@student.undiksha.ac.id' && password == '123456') {
      // Simpan username dan password agar bisa digunakan untuk login selanjutnya
      prefs.setString('username', username);
      prefs.setString('password', password);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainMenuPage()),
      );
    }
    // Cek apakah username dan password yang dimasukkan sesuai dengan yang ada di SharedPreferences
    else if (username == savedUsername && password == savedPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainMenuPage()),
      );
    } else {
      String errorMessage = '';
      if (savedUsername == null || savedPassword == null) {
        errorMessage =
            'Belum ada akun terdaftar. Silakan daftar terlebih dahulu.';
      } else {
        if (username != savedUsername) {
          errorMessage = 'Username salah';
        }
        if (password != savedPassword) {
          errorMessage =
              errorMessage.isEmpty
                  ? 'Password salah'
                  : '$errorMessage dan password salah';
        }
      }

      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text('Login Gagal'),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 56,
            color: const Color.fromARGB(255, 17, 52, 142),
            child: Center(
              child: Text(
                'Koperasi Undiksha',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth > 600 ? 28 : 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth > 600 ? 40.0 : 20.0),
            child: Image.asset(
              'assets/logo.png',
              width: screenWidth * 0.5,
              height: screenWidth * 0.5,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth > 600 ? 100.0 : 60.0,
                ),
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 17, 52, 142),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildLabel('Username', screenWidth),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            hintText: 'name@student.undiksha.ac.id',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username tidak boleh kosong';
                            }
                            if (!value.contains('@')) {
                              return 'Gunakan format email yang benar';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        _buildLabel('Password', screenWidth),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _login();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                17,
                                52,
                                142,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              elevation: 5,
                              shadowColor: Colors.blue.withOpacity(0.5),
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth > 600 ? 18 : 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Daftar Akun',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (_) => AlertDialog(
                                        title: const Text('Lupa Password'),
                                        content: const Text(
                                          'Silakan hubungi admin untuk mereset password.',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed:
                                                () =>
                                                    Navigator.of(context).pop(),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                );
                              },
                              child: const Text(
                                'Lupa Password?',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            color: const Color.fromARGB(255, 17, 52, 142).withOpacity(0.2),
            child: Center(
              child: Text(
                'copyright @2025 by Undiksha',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth > 600 ? 16 : 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text, double screenWidth) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: screenWidth > 600 ? 18 : 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
