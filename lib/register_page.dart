import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();

      final email = _emailController.text.trim();
      final password = _passwordController.text;

      // Cek apakah sudah terdaftar
      final existingEmail = prefs.getString('username');
      if (existingEmail != null && existingEmail == email) {
        // Jika akun sudah ada
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Akun sudah terdaftar. Silakan login.')),
        );
        return;
      }

      // Simpan akun baru
      await prefs.setString('username', email);
      await prefs.setString('password', password);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registrasi berhasil. Silakan login.')),
      );

      // Navigasi ke login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 52, 142),
        title: const Text("Daftar Mbanking"),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth > 600 ? 40.0 : 20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildLabel("Nama Lengkap", screenWidth),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Contoh: Desak Made Candra',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              _buildLabel("Email", screenWidth),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'name@student.undiksha.ac.id',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  final email = value.trim();
                  final isUndiksha = RegExp(
                    r'^[a-zA-Z0-9._%+-]+@student\.undiksha\.ac\.id$',
                  );
                  if (!isUndiksha.hasMatch(email)) {
                    return 'Gunakan email student.undiksha.ac.id';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              _buildLabel("Password", screenWidth),
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
                  if (value == null || value.length < 6) {
                    return 'Password minimal 6 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              _buildLabel("Konfirmasi Password", screenWidth),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscurePassword,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Konfirmasi password tidak sama';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 17, 52, 142),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    'Daftar',
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 18 : 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
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
