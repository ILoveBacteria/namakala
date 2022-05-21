import 'package:flutter/material.dart';
import 'package:namakala/widgets/screen_setting.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50.0,
            bottom: 10.0
          ),
          child: Column(
            children: [
              ScreenSetting.buildTitleText('Profile'),
              const SizedBox(height: 50.0,),
              Container(
                width: 100.0,
                height: 100.0,
                decoration: const BoxDecoration(
                  color: Colors.cyanAccent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 20.0,),
              const Text('Moein Arabi'),
              const SizedBox(height: 10.0,),
              const Text('+989120284896'),
              const SizedBox(height: 20.0,),
              Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                height: 300.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.green,
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Account Information'),
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    Container(
                      width: double.infinity,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Purchase History'),
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    Container(
                      width: double.infinity,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('My Market'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
