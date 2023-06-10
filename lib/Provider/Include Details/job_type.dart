import 'package:asist_finder/const/appColors..dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobType extends StatefulWidget {
  final String text;

  JobType({Key? key, required this.text}) : super(key: key);

  @override
  _JobTypeState createState() => _JobTypeState();
}

class _JobTypeState extends State<JobType> {
  bool onclick = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onclick = !onclick;
        setState(() {});
      },
      child: Container(
        width: 500.w,
        height: 50.h,
        decoration: BoxDecoration(
            color: onclick ? AppColors.orange : AppColors.white,
            borderRadius: BorderRadius.circular(100.r),
            border: Border.all(color: Colors.grey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 20,
              color: onclick ? AppColors.white : Colors.black ,
            ),
            Text(
              widget.text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 70.sp,
                color: onclick ? AppColors.white : Colors.black
              ),
            )
          ],
        ),
      ),
    );
  }
}
