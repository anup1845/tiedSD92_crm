import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../custom_widgets/custom_title_appbar.dart';
import '../../../../home/crm_home_screen.dart';

class NoticeListScreen extends StatelessWidget {
  const NoticeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color(0xffF5F6FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: const CustomTitleAppBar(
          title: "All Notice",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical : 20.0, horizontal: 16.w),
          child: Column(
            children: [
               Container(
                    padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text( 
                          "notice",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp),
                        ),
                       
                      ],
                    ),
                  ),


            ///notice list
                SizedBox(
                  height: 02.h,
                ),
                const NoticeCard(
                  image: "assets/crm_home/new_project_update.png",
                  title: "New project updated",
                  notice: "Logo Design Project",
                  name: "Md. Rashed",
                  time: "9:00 AM",
                ),
                SizedBox(
                  height: 02.h,
                ),
                const NoticeCard(
                  image: "assets/crm_home/new_comments.png",
                  title: "New Comments",
                  notice: "Logo Design Project",
                  name: "Md. Rashed",
                  time: "9:00 AM",
                ),
                SizedBox(
                  height: 02.h,
                ),
                const NoticeCard(
                  image: "assets/crm_home/clients_update.png",
                  title: "Client's Update",
                  notice: "Logo Design Project",
                  name: "Md. Rashed",
                  time: "9:00 AM",
                ),
                SizedBox(
                  height: 02.h,
                ),
                const NoticeCard(
                  image: "assets/crm_home/clients_update.png",
                  title: "Client's Update",
                  notice: "Logo Design Project",
                  name: "Md. Rashed",
                  time: "9:00 AM",
                ),
                   SizedBox(
                  height: 02.h,
                ),
                const NoticeCard(
                  image: "assets/crm_home/new_project_update.png",
                  title: "New project updated",
                  notice: "Logo Design Project",
                  name: "Md. Rashed",
                  time: "9:00 AM",
                ),
                SizedBox(
                  height: 02.h,
                ),
                const NoticeCard(
                  image: "assets/crm_home/new_comments.png",
                  title: "New Comments",
                  notice: "Logo Design Project",
                  name: "Md. Rashed",
                  time: "9:00 AM",
                ),
                SizedBox(
                  height: 02.h,
                ),
                const NoticeCard(
                  image: "assets/crm_home/clients_update.png",
                  title: "Client's Update",
                  notice: "Logo Design Project",
                  name: "Md. Rashed",
                  time: "9:00 AM",
                ),
                SizedBox(
                  height: 02.h,
                ),
                const NoticeCard(
                  image: "assets/crm_home/clients_update.png",
                  title: "Client's Update",
                  notice: "Logo Design Project",
                  name: "Md. Rashed",
                  time: "9:00 AM",
                ),
                   SizedBox(
                  height: 02.h,
                ),
                const NoticeCard(
                  image: "assets/crm_home/new_project_update.png",
                  title: "New project updated",
                  notice: "Logo Design Project",
                  name: "Md. Rashed",
                  time: "9:00 AM",
                ),
                SizedBox(
                  height: 02.h,
                ),
                const NoticeCard(
                  image: "assets/crm_home/new_comments.png",
                  title: "New Comments",
                  notice: "Logo Design Project",
                  name: "Md. Rashed",
                  time: "9:00 AM",
                ),
                SizedBox(
                  height: 02.h,
                ),
                const NoticeCard(
                  image: "assets/crm_home/clients_update.png",
                  title: "Client's Update",
                  notice: "Logo Design Project",
                  name: "Md. Rashed",
                  time: "9:00 AM",
                ),
                SizedBox(
                  height: 02.h,
                ),
                const NoticeCard(
                  image: "assets/crm_home/clients_update.png",
                  title: "Client's Update",
                  notice: "Logo Design Project",
                  name: "Md. Rashed",
                  time: "9:00 AM",
                ),
                   SizedBox(
                  height: 02.h,
                ),
                const NoticeCard(
                  image: "assets/crm_home/new_project_update.png",
                  title: "New project updated",
                  notice: "Logo Design Project",
                  name: "Md. Rashed",
                  time: "9:00 AM",
                ),
                SizedBox(
                  height: 02.h,
                ),
                const NoticeCard(
                  image: "assets/crm_home/new_comments.png",
                  title: "New Comments",
                  notice: "Logo Design Project",
                  name: "Md. Rashed",
                  time: "9:00 AM",
                ),
                SizedBox(
                  height: 02.h,
                ),
                const NoticeCard(
                  image: "assets/crm_home/clients_update.png",
                  title: "Client's Update",
                  notice: "Logo Design Project",
                  name: "Md. Rashed",
                  time: "9:00 AM",
                ),
                SizedBox(
                  height: 02.h,
                ),
                const NoticeCard(
                  image: "assets/crm_home/clients_update.png",
                  title: "Client's Update",
                  notice: "Logo Design Project",
                  name: "Md. Rashed",
                  time: "9:00 AM",
                ),

               

      
            ],
          ),
        ),
      ),
    );
  }
}