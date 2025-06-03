import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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
      if (valid) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()), //Hiện tại file này chx tồn tại, a bảo là xong phần 1 a cho phần 2 khác
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mã số thuế, mật khẩu hoặc tài khoản sai')),
        );
      }
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
        TextFormField(
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
  void dispose() {
    taxCtrl.dispose();
    userCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/icon/logo.svg'),
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
                      Image.asset('assets/icon/headphone.svg'),
                      SizedBox(width: 1),
                      Text('Trợ giúp'),
                    ],
                  ),
                ),
                Spacer(),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/icon/social_link.svg'),
                      SizedBox(width: 2),
                      Text('Group'),
                    ],
                  ),
                ),
                Spacer(),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/icon/vector.jpg'),
                      SizedBox(width: 2),
                      Text('Tra cứu'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
