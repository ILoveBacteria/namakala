import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namakala/widgets/field.dart';
import 'package:namakala/utilities/decoration.dart';

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 30.0, right: 30.0),
            child: Column(
              children: [
                _buildSignInText(),
                const SizedBox(height: 50.0),
                Container(
                  width: double.infinity,
                  height: 500.0,
                  padding: const EdgeInsets.all(20.0),
                  decoration: containerDecoration(),
                  child: Column(
                    children: [
                      _buildEmail(),
                      const SizedBox(height: 50),
                      _buildPassword(),
                      const SizedBox(height: 50),
                      _buildSignInButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget _buildEmail() {
    return Field.container(
      TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Enter your email',
          hintStyle: Field.hintStyle(),
          border: Field.border(),
          prefixIcon: const Icon(Icons.account_circle_outlined)
        ),
      )
    );
  }

  Widget _buildPassword() {
    return Field.container(
      TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Enter your password',
          hintStyle: Field.hintStyle(),
          border: Field.border(),
          prefixIcon: const Icon(Icons.password_outlined)),
    ));
  }

  Widget _buildSignInText() {
    return Text(
      'Sign In',
      style: GoogleFonts.openSans(
        fontSize: 30.0,
        fontWeight: FontWeight.w700,
      )
    );
  }

  Widget _buildSignInButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(30.0)
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(
            'SIGN IN',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
            letterSpacing: 2.0
          )
        ),
      ),
    );
  }
}
