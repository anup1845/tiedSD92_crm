import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/home/components/line_titiles.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../data/model/home/crm_home_model.dart';

class EarningWidget extends StatefulWidget {
  const EarningWidget({Key? key, this.chartData}) : super(key: key);

  final StaticsticsData? chartData;

  @override
  State<EarningWidget> createState() => _EarningWidgetState();
}

class _EarningWidgetState extends State<EarningWidget> {

  String? setTotalSaleFilter;
  final List<Color> gradientColors = [
    const Color.fromARGB(255, 159, 158, 255),
    AppColors.white,
  ];
  final List<Color> gradientColorsNext = [
    const Color.fromARGB(255, 255, 219, 200),
    AppColors.white,
  ];

  //final List<>? completeTask = widget.chartData?.completeTasks ;
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    List<FlSpot>? completeTask = widget.chartData?.completeTasks
        ?.map((e) => FlSpot(e.date!.toDouble(), e.complete!.toDouble()))
        .toList();
    List<FlSpot>? inCompleteTask = widget.chartData?.incompleteTasks
        ?.map((e) => FlSpot(e.date!.toDouble(), e.incomplete!.toDouble()))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.chartData?.completeTasks != null
            ? Container(
                //height: 169.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Statistics",
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            // Container(
                            //   height: 30.h,
                            //   decoration: BoxDecoration(
                            //       color: AppColors.white,
                            //       border: Border.all(color: AppColors.primaryColor),
                            //       borderRadius: BorderRadius.circular(8.r)),
                            //   child: Padding(
                            //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            //     child: DropdownButton<String>(
                            //       dropdownColor: AppColors.white,
                            //       style: TextStyle(
                            //           fontSize: 12.sp,
                            //           color: AppColors.white,
                            //           fontWeight: FontWeight.bold),
                            //       icon: Icon(
                            //         Icons.arrow_downward_sharp,
                            //         color: AppColors.primaryColor,
                            //         size: 14.sp,
                            //       ),
                            //       underline: Container(color: AppColors.white),
                            //       elevation: 0,
                            //       hint: const Text(
                            //         "Status",
                            //         style: TextStyle(color: AppColors.primaryColor),
                            //       ),
                            //       value: _selectedText,
                            //       items: <String>[
                            //         'This Week',
                            //         'This Month',
                            //         'This Year'
                            //       ].map((String value) {
                            //         return DropdownMenuItem<String>(
                            //           value: value,
                            //           child: Padding(
                            //             padding:
                            //                 EdgeInsets.symmetric(horizontal: 8.w),
                            //             child: Text(
                            //               value,
                            //               style: const TextStyle(
                            //                   color: AppColors.primaryColor),
                            //             ),
                            //           ),
                            //         );
                            //       }).toList(),
                            //       onChanged: (String? val) {
                            //         _selectedText = val!;
                            //         setState(() {
                            //           _selectedText = val;
                            //           //print(val);

                            //           if (val == "This Week") {
                            //             setTotalSaleFilter = "week";
                            //           } else if (val == "This Month") {
                            //             setTotalSaleFilter = "month";
                            //           } else if (val == "This Year") {
                            //             setTotalSaleFilter = "year";
                            //           }
                            //          // print("check api data  ${setTotalSaleFilter}");
                            //         });
                            //       },
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: SizedBox(
                          height: 220.h,
                          width: MediaQuery.of(context).size.width,
                          child: LineChart(
                              LineChartData(
                              backgroundColor: AppColors.white,
                              // minX: 0,
                              // maxX: 31,
                              // minY: 0,
                              // maxY: 6,
                               //titlesData: LineTitles.getTitleData(),
                              //titlesData: LineTitles.getTitleData(homeController.spotLabels),
                              //gridData: FlGridData(show: true),
                              gridData: FlGridData(
                                show: false,
                                getDrawingHorizontalLine: (value) {
                                  return FlLine(
                                    color: const Color(0xffEFEFEF),
                                    strokeWidth: 1,
                                  );
                                },
                                drawVerticalLine: false,
                                getDrawingVerticalLine: (value) {
                                  return FlLine(
                                    color: const Color(0xffEFEFEF),
                                    strokeWidth: 1,
                                  );
                                },
                              ),
                              //borderData: FlBorderData(show: false),
                              borderData: FlBorderData(
                                show: false,
                                border: Border.all(
                                    color: const Color(0xffEFEFEF), width: 2),
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                    spots: completeTask,
                                    // spots: homeController.spots,
                                    // spots: [
                                    //   FlSpot(
                                    //       widget.chartData.completeTasks[index]
                                    //           .complete,
                                    //       10),
                                    //   FlSpot(2, 5),
                                    //   FlSpot(3, 3),
                                    //   FlSpot(4, 5),
                                    //   FlSpot(5, 1),
                                    //   FlSpot(6, 4),
                                    //   FlSpot(7, 3),
                                    // ],
                                    isCurved: true,
                                    preventCurveOverShooting: true,
                                    color: AppColors.primaryColor,
                                    // gradient: LinearGradient(
                                    //   colors: gradientColors.map((Color) => color.w)
                                    // ),
                                    barWidth: 3,
                                    dotData: FlDotData(show: false),
                                    belowBarData: BarAreaData(
                                      show: false,
                                      gradient: LinearGradient(
                                        colors: gradientColors,
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    )
                                ),
                                LineChartBarData(
                                    spots: inCompleteTask,
                                    // spots: const [
                                    //   FlSpot(0, 4),
                                    //   FlSpot(2.0, 1),
                                    //   FlSpot(4.5, 4),
                                    //   FlSpot(5.8, 1.5),
                                    //   FlSpot(7, 3),
                                    //   FlSpot(8.5, 2),
                                    //   FlSpot(10, 4),
                                    // ],
                                    isCurved: true,
                                    // gradient: LinearGradient(
                                    //     colors: gradientColors,
                                    //     begin: Alignment.topLeft,
                                    //     end: Alignment.bottomRight,
                                    //   ),
                                    color: const Color(0xffFFBC99),
                                    barWidth: 3,
                                    dotData: FlDotData(show: false),
                                    belowBarData: BarAreaData(
                                      show: false,
                                      gradient: LinearGradient(
                                        colors: gradientColorsNext,
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ))
                              ])),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Shimmer.fromColors(
                baseColor: const Color(0xFFE8E8E8),
                highlightColor: Colors.white,
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  height: 200.h,
                  width: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8E8E8),
                    borderRadius: BorderRadius.circular(
                        10), // radius of 10// green as background color
                  ),
                ),
              ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
