  import 'dart:async';
  import 'package:audioplayers/audioplayers.dart';
  import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
  import 'package:ereport_mobile_app/src/core/styles/color.dart';
  import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
  import 'package:ereport_mobile_app/src/data/viewmodel/splash_screen_viewmodel.dart';
  import 'package:flutter/material.dart';
  import 'package:ereport_mobile_app/src/core/constants/images.dart';
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
      await Future.delayed(const Duration(seconds: 2), () {});
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        final viewmodel = Provider.of<SplashScreenViewModel>(context, listen: false);
        switch(viewmodel.state) {
          case ResultState.unLogged:
            Navigator.pushReplacementNamed(context, '/onBoardingScreen');
            break;
          case ResultState.logged:
            Navigator.pushReplacementNamed(context, '/bottomNavigation');
            break;
          case ResultState.loggedNotFilledData:
            Navigator.pushReplacementNamed(context, '/registerScreen');
            break;
          default:
            debugPrint('unknown');
            Future.delayed(const Duration(seconds: 2), () {
              didChangeDependencies();
            });
            break;
        }
        viewmodel.disposeViewModel();
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
                const SizedBox(height: 50),
                Hero(
                  tag: Global.logoHeroTag,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Column(
                      children: [
                        Image.asset(
                            DefaultImages.logo,
                            height: MediaQuery.of(context).size.height * 0.17,
                            width: MediaQuery.of(context).size.width * 0.38
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Center(
                    child: (viewmodel.state == ResultState.error)?
                        Column(
                          children: [
                            Text(TextStrings.splashScreenError,style: petrolabTextTheme.bodyLarge),
                          ],
                        ):
                        const CircularProgressIndicator(
                          color: primaryColor,
                        )
                ),
              ],
            ),
          ),
        )
      );
    }
  }