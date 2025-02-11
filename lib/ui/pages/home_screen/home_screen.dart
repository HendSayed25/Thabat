import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thabat/ui/pages/home_screen/widget/custom_button.dart';

import '../../../app/core/resource/assets_manager.dart';
import '../../../app/core/resource/color_manager.dart';
import '../skill_exercises_screen/skill_exercise_screen.dart';


class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState()=>_HomeScreenState();

}
class _HomeScreenState extends State<HomeScreen>{

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80,horizontal: 30),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text("مرحبا",style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.bold,color: AppColors.backGroundColor),),
              Text("ابدا تمارينك اليوم بحماس",style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.bold,color: AppColors.backGroundColor)),
              SizedBox(height: 50.h,),
              CustomButton(imageBtn: ImageAssets.run,textBtn: "التمارين الجسدية",onPressed: (){},),
              SizedBox(height: 18.h,),
              CustomButton(imageBtn: ImageAssets.brain,textBtn: "التمارين الذهنية",onPressed: (){},),
              SizedBox(height: 18.h,),
              CustomButton(imageBtn: ImageAssets.sound,textBtn: "التمارين الصوتية",onPressed: (){},),
              SizedBox(height: 18.h,),
              CustomButton(imageBtn: ImageAssets.write,textBtn: "التمارين المهارية",onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SkillExercies()));},
              ),
            ],

          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'الاعدادات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'الملف الشخصي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
        ],
        selectedItemColor: AppColors.backGroundColor, // لون العنصر النشط
        unselectedItemColor: Colors.white, // لون العناصر غير النشطة
        backgroundColor: AppColors.backgroundBottom, // لون خلفية البار
        type: BottomNavigationBarType.fixed,
      ),

    );
  }

}