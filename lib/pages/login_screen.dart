import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

  final _formKey = GlobalKey<FormState>();

  void login() {
    if (_formKey.currentState!.validate()) {
      final valid = taxCtrl.text == "1111111111" &&
          userCtrl.text == "demo" &&
          passCtrl.text == "123456";

      if (valid) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mã số thuế, mật khẩu hoặc tài khoản sai')),
        );
      }
    }
  }

  Widget input({
    required String label,
    required TextEditingController ctrl,
    required String? Function(String?) validator,
    bool obscure = false,
    TextInputType type = TextInputType.text, required String hintText,
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
          validator: validator,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orangeAccent),
            ),
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/icon/logo.svg'),
              const SizedBox(height: 20),
              input(
                label: "Mã số thuế",
                ctrl: taxCtrl,
                type: TextInputType.number,
                hintText:'Điền mã số thuế',
                validator: (value) {
                  if (value == null || value.length != 10) {
                    return "Mã số thuế phải có 10 chữ số";
                  }
                  return null;
                },
              ),
              input(
                label: "Tài khoản",
                ctrl: userCtrl,
                hintText:'Điền tài khoản',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tên đăng nhập không được để trống";
                  }
                  return null;
                },
              ),
              input(
                label: "Mật khẩu",
                ctrl: passCtrl,
                obscure: true,
                hintText:'Điền mật khẩu',
                validator: (value) {
                  if (value == null || value.length < 6 || value.length > 50) {
                    return "Mật khẩu phải từ 6 đến 50 ký tự";
                  }
                  return null;
                },
              ),
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
                        SvgPicture.asset('assets/icon/headphone.svg', width: 18),
                        SizedBox(width: 1),
                        Text('Trợ giúp'),
                      ],
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        SvgPicture.asset('assets/icon/social_link.svg', width: 18),
                        SizedBox(width: 2),
                        Text('Group'),
                      ],
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        SvgPicture.asset('assets/icon/vector.svg', width: 18),
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
      ),
    );
  }
}
