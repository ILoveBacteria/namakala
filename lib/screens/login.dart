import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(40.0),
          child: Column(
            children: [
            _buildSignIn(),
            const SizedBox(height: 50),
            _buildEmail(),
            const SizedBox(height: 50),
            _buildPassword()
            ],
          ),
        )
      ),
    );
  }

  Widget _buildEmail() {
    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFF6CA8F1),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 6.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: const TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            // labelText: 'Email',
            hintText: 'Enter your email',
            hintStyle: TextStyle(fontFamily: 'OpenSans', color: Colors.black38),
            border: InputBorder.none),
      ),
    );
  }

  Widget _buildPassword() {
    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFF6CA8F1),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 6.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: const TextField(
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Enter your password',
            hintStyle: TextStyle(fontFamily: 'OpenSans', color: Colors.black38),
            border: InputBorder.none),
      ),
    );
  }

  Widget _buildSignIn() {
    return const Text(
      'Sign In',
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
