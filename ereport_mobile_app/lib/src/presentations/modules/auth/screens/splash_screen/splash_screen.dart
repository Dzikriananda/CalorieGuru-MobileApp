import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/splash_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/constants/global.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late bool isConnected;

  Future<void> playLocalAsset() async {
    final player = AudioPlayer();
    player.play(AssetSource('tseldefaultsound.mp3'));
  }



  @override
  void initState() {
    super.initState();
    playLocalAsset();

  }

  @override
  void didChangeDependencies() async {
    await Future.delayed(Duration(seconds: 2), () { // <-- Delay here
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final viewmodel = Provider.of<SplashScreenViewModel>(context, listen: false);
      if(viewmodel.state == ResultState.unLogged){
        Navigator.pushReplacementNamed(context, '/authScreen');
        viewmodel.dispose();
      }
      else if(viewmodel.state == ResultState.logged){
        Navigator.pushReplacementNamed(context, '/bottomNavigation');
        viewmodel.dispose();
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashScreenViewModel>(
      builder: (context, viewmodel, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50),
              Hero(
                tag: Global.logoHeroTag,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Column(
                    children: [
                      Image.asset(
                          DefaultImages.logo,
                          height: 150,
                          width: 150,
                      ),
                      Text(TextStrings.appTitle, style: splashScreenText),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
              const Center(child: CircularProgressIndicator(
                color: Colors.black,
                )
              ),
            ],
          ),
        ),
      )
    );
  }
}