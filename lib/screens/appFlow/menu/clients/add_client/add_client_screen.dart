import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/api_service/connectivity/no_internet_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/add_client/add_client_provider.dart';
import 'package:hrm_app/screens/custom_widgets/add_client_textfield.dart';
import 'package:hrm_app/screens/custom_widgets/label_text.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class AddClientScreen extends StatelessWidget {
   AddClientScreen({super.key});
   final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
      child: ChangeNotifierProvider(
        create: (context) => AddClientProvider(),
        child: Consumer<AddClientProvider>(builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: const Color(0xffF5F6FA),
            appBar: AppBar(
              elevation: 0,
              title: Text(
                "Add Client",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 16.w),
                child: Form(
                    key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => provider.pickImage(context),
                        child: Center(
                          child: Stack(
                            children: [
                              Container(
                                  height: 110,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: const Color(0xFFE4E4E4),
                                          width: 8)),
                                    child: provider.imagePath == null
                                      ? const Icon(
                                          CupertinoIcons.person_solid,
                                          color: Colors.grey,
                                          size: 60,
                                        )
                                      : ClipOval(
                                          child: Image.file(
                                          provider.imagePath!,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                             provider.imagePath == null? Positioned(
                                bottom: 6,
                                right: 6,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.colorPrimary),
                                  child: const Icon(
                                    size: 18.0,
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ) : Positioned(
                                bottom: 6,
                                right: 6,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.colorPrimary),
                                  child: const Icon(
                                    size: 18.0,
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                       const LavelText(
                        text: "Client's Name * ",
                       
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                       AddClientTextField(
                        hintText: "Enter Client's Name",
                         textController : provider.clientNameController
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      const LavelText(
                        text: "Phne Number * ",
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                       AddClientTextField(
                        hintText: "Enter Client's Phone Number",
                          textController : provider.clientPhoneNumberController
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      const LavelText(
                        text: "Email * ",
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                       AddClientTextField(
                        hintText: "Enter Client's Email",
                         textController : provider.clientEmailController
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      const LavelText(
                        text: "Address * ",
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                       AddClientTextField(
                        hintText: "Enter Client's Address",
                         textController : provider.clientAddressController
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      const LavelText(
                        text: "Description * ",
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                       AddClientTextField(
                        hintText: "Write Client's description here...",
                        textController : provider.clientDescriptionController,
                        maxLine: 4,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      ElevatedButton(
                            onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await provider.addClient(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5B58FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            minimumSize: Size(double.infinity, 60.h),
                          ),
                          child: Text(
                            "Add Clients",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              ),
            ),
         
          );
        }),
      ),
    );
  }
}
