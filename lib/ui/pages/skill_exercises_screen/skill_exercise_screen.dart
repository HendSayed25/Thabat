import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thabat/ui/pages/skill_exercises_screen/widget/triangle_shape.dart';
import 'package:thabat/app/core/resource/color_manager.dart';

import '../../../app/core/resource/assets_manager.dart';
import '../home_screen/home_screen.dart';

class SkillExercies extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_SkillExerciseState();

}
class _SkillExerciseState extends State<SkillExercies>{
  bool showHint = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80,horizontal: 40),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(onPressed:() {
                     _showStopDialog(context);
                    }, icon: Image.asset(ImageAssets.stop,width: 70.w,height: 70.h,),color: Colors.white,),
                  Spacer(),
                  IconButton(onPressed:() {
                      setState(() {
                        showHint = true;
                      });
                      //disappear it after 3 sec
                      Future.delayed(Duration(seconds: 3), () {
                        setState(() {
                          showHint = false;
                        });
                      });
                    }, icon: Image.asset(ImageAssets.lampIcon,width: 50.w,height: 50.h,),color: Colors.white,),
                ],
              ),
              SizedBox(height: 20.h,),
              Expanded(child: TriangleTracker(showHint: showHint,)),
            ],
          ),
        ),
      ),

    );
  }

}

void _showStopDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.backGroundSuccessAndFailed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ايقاف مؤقت", style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.bold)),
            Divider(),
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle
              ),
                child: IconButton(onPressed: (){
                  Navigator.of(context).pop();
                },
                    icon: Icon(Icons.play_arrow,color: Colors.white, size: 40))),
            SizedBox(width: 10),
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle
              ),  child: IconButton(onPressed:() {
              Navigator.push(context,MaterialPageRoute(builder: (context) => SkillExercies()),);
            }, icon: Image.asset(ImageAssets.reload,width: 30.w,height: 30.h,)),
            ),
            SizedBox(width: 100.w,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle
              ),
              child: IconButton(onPressed:() {
                Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()),);
              }, icon: Image.asset(ImageAssets.home,width: 30.w,height: 30.h,)),
            )
          ],
        ),
      );
    },
  );
}