import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectStatusCard extends StatelessWidget {
  ProjectStatusCard(
      {Key? key,
      this.tapBarButton1,
      this.tapBarButton2,
      this.rightIconArrowColor,
      this.projectName,
      this.startData,
      this.endDate,
      this.progressBar,
      this.ontap,
      this.usersImage,
      this.userCount,
      this.actualCount})
      : super(key: key);

  final Widget? tapBarButton1, tapBarButton2, progressBar;
  final Color? rightIconArrowColor;
  final String? projectName, startData, endDate;
  final Function()? ontap;
  final List<Widget>? usersImage;
  final int? userCount;
  final int? actualCount;

  @override
  Widget build(BuildContext context) {
    print(".............$actualCount");
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 2.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 19.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      tapBarButton1 ?? const SizedBox(),
                      SizedBox(
                        width: 10.w,
                      ),
                      tapBarButton2 ?? const SizedBox(),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: rightIconArrowColor,
                    size: 13.sp,
                  )
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    projectName ?? "",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20.0 * usersImage!.length,
                        height: 40.0.h,
                        child: Stack(children: usersImage!),
                      ),
                      //SizedBox( width: 4.w,),

                      (actualCount ?? 0) > 3
                          ? Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 9.h, horizontal: 7.w),
                        decoration: BoxDecoration(
                            color: rightIconArrowColor,
                            shape: BoxShape.circle),
                        child: Text(
                          "${userCount.toString()}+",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      )

                          :  const SizedBox()
                    ],
                  ),
                  // SizedBox(
                  //   width: 90,
                  //   height: 39,
                  //   child: Stack(children: [
                  //     Image.asset(
                  //       image1!,
                  //       height: 36.h,
                  //       width: 36.w,
                  //     ),
                  //     Positioned(
                  //         left: 22.w,
                  //         child: Image.asset(
                  //           image2!,
                  //           //"assets/projects/roundImage02.png",
                  //           height: 36.h,
                  //           width: 36.w,
                  //         )),
                  //     Positioned(
                  //         left: 45.w,
                  //         child: Image.asset(
                  //           image3!,
                  //           //"assets/task/task_in_review_add_updsate.png",
                  //           height: 36.h,
                  //           width: 36.w,
                  //         )),
                  //   ]),
                  // ),
                ],
              ),
              SizedBox(
                height: 26.h,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/projects/calender_black.png",
                    height: 14.h,
                    width: 14.w,
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  Text(
                    startData ?? "",
                    //"Mon, 12 July 2022",
                    style: TextStyle(
                        color: const Color(0xff7B7B7B),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  // Image.asset(
                  //   "assets/projects/arrow_right.png",
                  //   height: 16.h,
                  //   width: 16.w,
                  // ),
                  SizedBox(
                    width: 14.w,
                  ),
                  Text(
                    endDate ?? "",
                    //"Mon, 12 July 2022",
                    style: TextStyle(
                        color: const Color(0xff7B7B7B),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 21.h,
              ),
              progressBar ?? const SizedBox()
              // ProgressIndeccatorWithPersentage(
              //   persentageActiveColor: const Color(0xff00606F),
              //   persentageDisebleColor: const Color(0xffEAEAEA),
              //   activeContainerWidth: 200.w,
              //   deActivetContainerWidth: 47.w,
              //   persentage: "70%",
              // )
            ],
          ),
        ),
      ),
    );
  }
}
