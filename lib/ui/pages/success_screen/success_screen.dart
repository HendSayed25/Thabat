import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:thabat/app/core/resource/assets_manager.dart';
import 'package:thabat/ui/pages/home_screen/home_screen.dart';
import 'package:thabat/ui/pages/skill_exercises_screen/skill_exercise_screen.dart';

import '../../../app/core/resource/color_manager.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});
  @override
  _SuccessScreenState createState()=>_SuccessScreenState();
}
class _SuccessScreenState extends State<SuccessScreen>{
  final AudioPlayer _audioPlayer = AudioPlayer();
  FlutterTts flutterTts = FlutterTts();


  Future<void> _playSound() async {
    try {
      await _audioPlayer.play(AssetSource('audio/applause.mp3'));
    } catch (e) {
      debugPrint("Error playing sound: $e");
    }  }

  Future<void> speakMessage() async {
    await flutterTts.setLanguage("ar-SA");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);

    await flutterTts.speak("عمل رائع! لقد أتممت التمرين بنجاح.");

  }

  @override
  void initState() {
    super.initState();
    _playSound();
    speakMessage();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        color: AppColors.backGroundSuccessAndFailed,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("عمل رائع",style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.bold),),
              Text("لقد اتممت التمرين بنجاح",style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.bold)),
              Image.asset(ImageAssets.star,width: 150.w,height: 150.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle
                    ),                    child: IconButton(onPressed:() {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => SkillExercies()),);
                    }, icon: Image.asset(ImageAssets.reload,width: 30.w,height: 35.h,)),
                  ),
                  SizedBox(width: 110.w,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle
                    ),
                    child: IconButton(onPressed:() {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()),);
                    }, icon: Image.asset(ImageAssets.home,width: 35.w,height: 35.h,)),
                  )

                ],
              )
            ],
          ),
        ),
      ) ,
    );
  }

}