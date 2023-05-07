import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/task/create_task/create_task_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/task/widgets/complete_task_card.dart';
import 'package:hrm_app/screens/custom_widgets/custom_title_appbar.dart';

class CompletedTaskListScreen extends StatelessWidget {
  const CompletedTaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: const CustomTitleAppBar(
          title: "Completed Task List",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 17),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: 11.5.h, horizontal: 13.5.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Search a Support",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffCED1DA),
                        fontSize: 14.sp,
                      ),
                    ),
                    Container(  
                      padding: EdgeInsets.all(8.sp),
                      height: 29.h,
                      width: 29.w,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xff5B58FF)),
                      child: Image.asset(
                        "assets/task/search_bar.png",
                        height: 11.h,
                        width: 11.w,
                      ),
                    )
                  ],
                ),
              ),
             
             
              SizedBox(
                height: 16.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                  children: [
                    Text(
                      "Completed Task",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp),
                    ),
                    InkWell(
                  onTap: () {
                    Navigator.push( 
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateTaskScreen()));
                  },
                  child: Container(
                    //height: 42.h,
                    //width: 32.w,
                    padding:
                        EdgeInsets.symmetric(vertical: 13.h, horizontal: 15.w),
                    decoration: BoxDecoration(
                        color: const Color(0xff5B58FF),
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Icon(
                      Icons.add,
                      size: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                )
                  ],
                ),
              ),
          
            SizedBox(
                height: 2.h,
              ),
            const  CompleteTaskCard(
                  image1: "assets/projects/roundProfile.png",
                  image2: "assets/projects/roundImage02.png",
                  image3: "assets/projects/roundProfile.png",
                  image4: "assets/projects/add_rounded.png",
                  taskName: "Music App Ui design",
                  seeDetailsText: "See Task details",
                  tapbuttonColor: Colors.white,
                ),
                SizedBox(
                  height: 2.h,
                ),
              const  CompleteTaskCard(
                  image1: "assets/projects/roundProfile.png",
                  image2: "assets/projects/roundImage02.png",
                  image3: "assets/projects/roundProfile.png",
                  image4: "assets/projects/add_rounded.png",
                  taskName: "Music App Ui design",
                  seeDetailsText: "See Task details",
                  tapbuttonColor: Colors.white,
                ),
                SizedBox(
                  height: 2.h,
                ),
              const  CompleteTaskCard(
                  image1: "assets/projects/roundProfile.png",
                  image2: "assets/projects/roundImage02.png",
                  image3: "assets/projects/roundProfile.png",
                  image4: "assets/projects/add_rounded.png",
                  taskName: "Music App Ui design",
                  seeDetailsText: "See Task details",
                  tapbuttonColor: Colors.white,
                ),
                SizedBox(
                  height: 2.h,
                ),
            const   CompleteTaskCard(
                  image1: "assets/projects/roundProfile.png",
                  image2: "assets/projects/roundImage02.png",
                  image3: "assets/projects/roundProfile.png",
                  image4: "assets/projects/add_rounded.png",
                  taskName: "Music App Ui design",
                  seeDetailsText: "See Task details",
                  tapbuttonColor: Colors.white,
                ),
                SizedBox(
                  height: 2.h,
                ),
                const CompleteTaskCard(
                  image1: "assets/projects/roundProfile.png",
                  image2: "assets/projects/roundImage02.png",
                  image3: "assets/projects/roundProfile.png",
                  image4: "assets/projects/add_rounded.png",
                  taskName: "Music App Ui design",
                  seeDetailsText: "See Task details",
                  tapbuttonColor: Colors.white,
                ),
                SizedBox(
                  height: 2.h,
                ),
             const  CompleteTaskCard(
                  image1: "assets/projects/roundProfile.png",
                  image2: "assets/projects/roundImage02.png",
                  image3: "assets/projects/roundProfile.png",
                  image4: "assets/projects/add_rounded.png",
                  taskName: "Music App Ui design",
                  seeDetailsText: "See Task details",
                  tapbuttonColor: Colors.white,
                ),
                SizedBox(
                  height: 2.h,
                ),
             const   CompleteTaskCard(
                  image1: "assets/projects/roundProfile.png",
                  image2: "assets/projects/roundImage02.png",
                  image3: "assets/projects/roundProfile.png",
                  image4: "assets/projects/add_rounded.png",
                  taskName: "Music App Ui design",
                  seeDetailsText: "See Task details",
                  tapbuttonColor: Colors.white,
                ),
                SizedBox(
                  height: 2.h,
                ),
              const  CompleteTaskCard(
                  image1: "assets/projects/roundProfile.png",
                  image2: "assets/projects/roundImage02.png",
                  image3: "assets/projects/roundProfile.png",
                  image4: "assets/projects/add_rounded.png",
                  taskName: "Music App Ui design",
                  seeDetailsText: "See Task details",
                  tapbuttonColor: Colors.white,
                ),
                SizedBox(
                  height: 2.h,
                ),
               const CompleteTaskCard(
                  image1: "assets/projects/roundProfile.png",
                  image2: "assets/projects/roundImage02.png",
                  image3: "assets/projects/roundProfile.png",
                  image4: "assets/projects/add_rounded.png",
                  taskName: "Music App Ui design",
                  seeDetailsText: "See Task details",
                  tapbuttonColor: Colors.white,
                ),
                SizedBox(
                  height: 2.h,
                ), 
           
            ],
          ),
        ),
      ),
    );
  }
}
