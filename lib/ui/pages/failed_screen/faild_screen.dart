import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';


import '../../../app/core/resource/assets_manager.dart';
import '../../../app/core/resource/color_manager.dart';
import '../skill_exercises_screen/skill_exercise_screen.dart';

class FaildScreen extends StatefulWidget {
  const FaildScreen({super.key});
  @override
  _FaildScreenState createState()=>_FaildScreenState();
}
class _FaildScreenState extends State<FaildScreen>{
  final AudioPlayer _audioPlayer = AudioPlayer();
  FlutterTts flutterTts = FlutterTts();


  Future<void> _playSound() async {
    try {
      await _audioPlayer.play(AssetSource('audio/game-over.mp3'));
    } catch (e) {
      debugPrint("Error playing sound: $e");
    }  }

  Future<void> speakMessage() async {
    await flutterTts.setLanguage("ar-SA");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak("لا بأس ! يمكنك المحاولة مرة اخرى");

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
              Text("لا بأس",style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.bold),),
              Text("يمكنك المحاولة مرةاخرى",style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.bold)),
              Image.asset(ImageAssets.sad,width: 150.w,height: 150.h,),
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