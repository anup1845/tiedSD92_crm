import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hrm_app/screens/appFlow/menu/componets/menu_drawer.dart';
import 'package:hrm_app/screens/appFlow/menu/menu_provider.dart';
import 'package:hrm_app/screens/appFlow/natification/notification_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/res.dart';
import 'my_account/my_account.dart';
import 'dart:math' as math;

class MenuScreen extends StatelessWidget {
   MenuScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<MenuProvider>();
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        key: scaffoldKey,
        drawer: MenuDrawer(provider: provider),
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            leading: const Padding(
              padding:  EdgeInsets.only(top: 16.0),
              // child: InkWell(
              //   onTap: () {
              //     if (scaffoldKey.currentState!.isDrawerOpen) {
              //       scaffoldKey.currentState?.openDrawer();
              //     } else {
              //       scaffoldKey.currentState?.openDrawer();
              //     }
              //   },
              //   child: Image.asset(
              //     "assets/task/menu_bar.png",
              //     height: 40,
              //     width: 40,
              //   ),
              // ),
            ),
            title:  Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                "Dashboard",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16.sp),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, right: 16),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const NotificationScreen()));
                      },

                        child: Image.asset(
                          "assets/task/notification_vector.png",
                          height: 50.h,
                          width: 45.w,
                        ),

                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const MyAccount()));
                      },
                      child:  ClipOval(
                        child: CachedNetworkImage(
                          height: 50.h,
                          width: 40.w,
                          fit: BoxFit.cover,
                          imageUrl: "${provider.profileImage}",
                          placeholder: (context, url) => Center(
                            child:
                            Image.asset("assets/images/placeholder_image.png"),
                          ),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (_) => const MyAccount()));
                    //   },
                    //   child: Image.asset(
                    //     "assets/task/profile_image.png",
                    //     height: 40.h,
                    //     width: 40.w,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Container(
            decoration: const BoxDecoration(

                color: AppColors.backgroundColor),
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 10),
            child: Column(
              children: [
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (_) => const MyAccount()));
                //   },
                //   child: Card(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),
                //     elevation: 0,
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 16.0, vertical: 20),
                //       child: Row(
                //         children: [
                //           ClipOval(
                //             child: CachedNetworkImage(
                //               height: 50,
                //               width: 50,
                //               fit: BoxFit.cover,
                //               imageUrl: "${provider.profileImage}",
                //               placeholder: (context, url) => Center(
                //                 child: Image.asset(
                //                     "assets/images/placeholder_image.png"),
                //               ),
                //               errorWidget: (context, url, error) =>
                //                   const Icon(Icons.error),
                //             ),
                //           ),
                //           const SizedBox(
                //             width: 16,
                //           ),
                //           Expanded(
                //             child: Column(
                //               crossAxisAlignment:
                //                   CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   provider.userName ?? "",
                //                   maxLines: 1,
                //                   overflow: TextOverflow.ellipsis,
                //                   style: const TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       fontSize: 16),
                //                 ),
                //                 const SizedBox(
                //                   height: 5,
                //                 ),
                //                 Text(
                //                   tr("view_profile"),
                //                   style: const TextStyle(
                //                       fontSize: 14,
                //                       color: AppColors.primaryColor),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           IconButton(
                //               onPressed: () {
                //                 if (_scaffoldKey
                //                     .currentState!.isEndDrawerOpen) {
                //                   _scaffoldKey.currentState
                //                       ?.openEndDrawer();
                //                 } else {
                //                   _scaffoldKey.currentState
                //                       ?.openEndDrawer();
                //                 }
                //               },
                //               icon: const Icon(
                //                 Icons.menu,
                //                 color: AppColors.primaryColor,
                //               ))
                //         ],
                //       ),
                //     ),
                //   ),
                // ),

                provider.menuList?.isNotEmpty == true
                    ? Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 16 / 6,
                    mainAxisSpacing: 16,
                    children: List.generate(
                        provider.menuList?.length ?? 0, (index) {
                      final data = provider.menuList![index];
                      return index % 2 == 0
                          ? menuCard(
                          index: index,
                          context: context,
                          name: data.name,
                          image: data.icon,
                          label: data.lavel,
                          //imageType: data.imageType,
                          onPressed: () =>
                              provider.getRoutSlag(
                                  context, data.slug, false))
                          : menuCard(
                          index: index,
                          context: context,
                          name: data.name,
                          image: data.icon,
                          label: data.lavel,
                          //imageType: data.imageType,
                          onPressed: () =>
                              provider.getRoutSlag(
                                  context, data.slug, false));
                    }),
                  ),
                )
                    : Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 16 / 6,
                      mainAxisSpacing: 2,
                      children: List.generate(20, (index) {
                        return Shimmer.fromColors(
                          baseColor: const Color(0xFFE8E8E8),
                          highlightColor: Colors.white,
                          child: Container(
                            margin: const EdgeInsets.all(16.0),
                            // height: 155.h,
                            // width: 200.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8E8E8),
                              borderRadius: BorderRadius.circular(
                                  10), // radius of 10// green as background color
                            ),
                          ),
                        );
                      }),
                    ))
              ],
            )));
  }

  InkWell menuCard(
      {BuildContext? context,
      required int index,
      String? image,
      String? name,
      String? imageType,
      String? label,
      Function()? onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: imageType?.contains('svg') == true
              ? SvgPicture.network(
                  image ?? "",
                  height: 25,
                  width: 25,
                  color: AppColors.primaryColor,
                )
              : Stack(
                  children: [
                    Positioned(
                        right: 0,
                        left: 0,
                        top: 0,
                        child: index % 2 == 0 ? Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: image ?? "https://www.w3schools.com/howto/img_avatar.png",
                            placeholder: (context, url) => Center(
                              child: Image.asset("assets/images/placeholder_image.png"),
                            ),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ),
                        ) : CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: image ?? "https://www.w3schools.com/howto/img_avatar.png",
                          placeholder: (context, url) => Center(
                            child: Image.asset("assets/images/placeholder_image.png"),
                          ),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),),
                    index % 2 == 0
                        ? label?.contains('PRO') == true
                            ? Positioned(
                                right: 10,
                                top: 10,
                                child: Image.asset(
                                  "assets/crm_home/pro.png",
                                  height: 22,
                                  width: 22,
                                ))
                            : const SizedBox()
                        : label?.contains('PRO') == true
                            ? Positioned(
                                left: 12,
                                top: 0,
                                bottom: 0,
                                child: Image.asset(
                                  "assets/crm_home/pro.png",
                                  height: 22,
                                  width: 22,
                                ))
                            : const SizedBox(),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: index % 2 == 0 ? 30.w : 0.w,
                            right: index % 2 == 0 ? 0.w : 30.w),
                        child: Text(
                          tr("$name"),
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
          ),
    );
  }
}
//   ),
