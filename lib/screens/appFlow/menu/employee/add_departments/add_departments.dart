import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/server/respository/employee_repository/employee_repository.dart';
import 'package:hrm_app/screens/custom_widgets/add_client_textfield.dart';
import 'package:hrm_app/utils/res.dart';

class AddDepartments extends StatefulWidget {
  const AddDepartments({super.key});

  @override
  State<AddDepartments> createState() => _AddDepartmentsState();
}

class _AddDepartmentsState extends State<AddDepartments> {
  final formKey = GlobalKey<FormState>();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Add Department",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0.sp),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 70.h,
          ),
          Text(
            "Department name*",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.black,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Form(
            key: formKey,
            child: AddClientTextField(
              textController: textController,
              hintText: "Department name",
            ),
          ),
          SizedBox(
            height: 117.h,
          ),
          SizedBox(
            height: 50.h,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await sendDepartmentData();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff5B58FF),
                //side: BorderSide(color: borderColor, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                //maximumSize: const Size(0, 0)
                // primary: const Color(0xFFFEB716),
              ),
              child: Text(
                "Save",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  sendDepartmentData() async {
    final data = {'title': textController.text};
    final response = await EmployeeRepository.addDepartment(data);
    if (response['result'] == true) {
      if (mounted) {
        Fluttertoast.showToast(msg: response['message'].toString());
        Navigator.pop(context);
      }
    }
  }
}
