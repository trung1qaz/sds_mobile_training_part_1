import 'package:flutter/material.dart';

void main() =>
    runApp(MaterialApp(home: LoginScreen(), debugShowCheckedModeBanner: false));

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final taxCtrl = TextEditingController();
  final userCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  bool triedLogin = false;

  String? get taxError => triedLogin && taxCtrl.text.length != 10
      ? "Mã số thuế phải có 10 chữ số"
      : null;
  String? get userError => triedLogin && userCtrl.text.isEmpty
      ? "Tên đăng nhập không được để trống"
      : null;
  String? get passError =>
      triedLogin && (passCtrl.text.length < 6 || passCtrl.text.length > 50)
      ? "Mật khẩu phải từ 6 đến 50 ký tự"
      : null;

  void login() {
    setState(() => triedLogin = true);
    if (taxError == null && userError == null && passError == null) {
      final valid =
          taxCtrl.text == "1111111111" &&
          userCtrl.text == "demo" &&
          passCtrl.text == "123456";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            valid ? "Đăng nhập thành công!" : "Sai thông tin đăng nhập.",
          ),
        ),
      );
    }
  }

  Widget input(
    String label,
    TextEditingController ctrl,
    String? error, {
    bool obscure = false,
    TextInputType type = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: ctrl,
          obscureText: obscure,
          keyboardType: type,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orangeAccent),
            ),
            errorText: error,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/icon/Logo.png'),
            const SizedBox(height: 20),
            input("Mã số thuế", taxCtrl, taxError, type: TextInputType.number),
            input("Tài khoản", userCtrl, userError),
            input("Mật khẩu", passCtrl, passError, obscure: true),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Đăng nhập",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
            Spacer(),
            Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/icon/headphone.jpg', width: 18),
                      SizedBox(width: 1), // Adds spacing between the image and text
                      Text('Trợ giúp'),
                    ],
                  ),
                ),
                Spacer(),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/icon/facebook.jpg', width: 20),
                      SizedBox(width: 2), // Adds spacing between the image and text
                      Text('Group'),
                    ],
                  ),
                ),
                Spacer(),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/icon/search.jpg', width: 20),
                      SizedBox(width: 2), // Adds spacing between the image and text
                      Text('Tra cứu'),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//
//
// Spacer(),
// Image.asset('assets/icon/facebook.jpg',width: 40,),
// Text('Group'),
// Spacer(),
// Image.asset('assets/icon/search.jpg',width: 40,),
// Text('Tra cứu'),
