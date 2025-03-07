import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/Models/veriler.dart';
import 'package:yazilim_muh_proje/components/button.dart';
import 'package:yazilim_muh_proje/components/custom_text_field.dart';
import 'package:yazilim_muh_proje/Models/user.dart';
import 'package:yazilim_muh_proje/pages/login_with_email_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repassword = TextEditingController();
  final _name = TextEditingController();
  final _surname = TextEditingController();

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: []),
        backgroundColor: Colors.blue.shade400,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                Icons.shopify,
                color: Colors.blue.shade400,
                size: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Kayıt ol",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Devam etmek için kayıt olun.",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade400.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: "Ad",
                              onChanged: (name) {
                                _name.text = name;
                              },
                              controller: _name,
                              hint: "Ad",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextField(
                              label: "Soyad",
                              onChanged: (surname) {
                                _surname.text = surname;
                              },
                              controller: _surname,
                              hint: "Soyad",
                            ),
                          ),
                        ],
                      ),
                      CustomTextField(
                        label: "E-posta",
                        onChanged: (email) {
                          _email.text = email;
                        },
                        controller: _email,
                        hint: "E-posta",
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        label: "Şifre",
                        onChanged: (password) {
                          _password.text = password;
                        },
                        controller: _password,
                        hint: "Şifre",
                        password: true,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        label: "Şifre (Tekrar)",
                        onChanged: (repassword) {
                          _repassword.text = repassword;
                        },
                        controller: _repassword,
                        hint: "Şifre (Tekrar)",
                        password: true,
                      ),
                      const SizedBox(height: 20),
                      Button(
                        text: "Kaydet",
                        buttonColor: Colors.blue.shade400,
                        textColor: Colors.white,
                        fontSize: 13,
                        onPressed: () {
                          if (_password.text.isEmpty ||
                              _email.text.isEmpty ||
                              _name.text.isEmpty ||
                              _surname.text.isEmpty) {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: Text("Hata"),
                                    content: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(text: "Lütfen tüm alanları"),
                                          TextSpan(
                                            text: " eksiksiz",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          TextSpan(text: " doldurun."),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Tamam",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                            );
                            return;
                          }

                          if (!_isValidEmail(_email.text)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Geçersiz E-posta!"),
                                showCloseIcon: true,
                              ),
                            );
                            return;
                          }

                          // Validate passwords match
                          if (_password.text != _repassword.text) {
                            // Show error if passwords don't match
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: Text('Hata'),
                                    content: Text('Şifreler uyuşmuyor!'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Tamam',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                            );
                            return;
                          }

                          //Hata yoksa
                          // Create User object
                          User newUser = User(
                            email: _email.text,
                            password: _password.text,
                          );
                          // Add the new user to the list
                          Veriler.kullanicilar.add(newUser);
                          // Navigate to the KullanimKosullariPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginWithEmailPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
