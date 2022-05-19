import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          child: Container(
            width: double.infinity,
            height: 500.0,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 6.0,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildSignIn(),
                const SizedBox(height: 50),
                _buildEmail(),
                const SizedBox(height: 50),
                _buildPassword(),
                const SizedBox(height: 50),
                _buildSignInButton(),
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget _fieldContainer(Widget child) {
    return Container(
      height: 60.0,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 6.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: child
    );
  }

  Widget _buildEmail() {
    return _fieldContainer(
      TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Enter your email',
            hintStyle: GoogleFonts.nunito(
              color: Colors.black38,
            ),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.account_circle_outlined)
        ),
      )
    );
  }

  Widget _buildPassword() {
    return _fieldContainer(
      TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Enter your password',
          hintStyle: GoogleFonts.nunito(
            color: Colors.black38,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.password_outlined)),
    ));
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
