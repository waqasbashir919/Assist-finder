import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelecType extends StatefulWidget {
  final String text;

  SelecType({Key? key, required this.text}) : super(key: key);

  @override
  _SelecTypeState createState() => _SelecTypeState();
}

class _SelecTypeState extends State<SelecType> {
  // define a list of options for the dropdown
  final List<String> _values = ["Seeker", "Provider", "User Type"];

  // the selected value
  String? _selectedfield;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 12.h,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          height: 80.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey),
            boxShadow: [
              // BoxShadow(
              //   color: Colors.grey.withOpacity(0.8),
              //   spreadRadius: 1,
              //   blurRadius: 8,
              //   offset: Offset(0, 5), // changes position of shadow
              // ),
            ],
            color: Colors.white,
          ),
          child: DropdownButton<String>(
            hint: Text('Select',style: TextStyle(color: Colors.grey,fontSize: 80.sp),),
            value: _selectedfield,
            onChanged: (value) {
              setState(() {
                _selectedfield = value;
              });
            },
            // Hide the default underline
            underline: Container(),
            // set the color of the dropdown menu
            // dropdownColor: Colors.amber,
            icon: Icon(
              CupertinoIcons.chevron_down,
              color: Colors.grey,
            ),
            isExpanded: true,

            // The list of options
            items: _values
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          e
                           ,
                          style: TextStyle(
                              fontSize: 80.sp,
                              color:  Color.fromARGB(255, 143, 143, 143)),
                        ),
                      ),
                    ))
                .toList(),

            // Customize the selected item
            selectedItemBuilder: (BuildContext context) => _values
                .map((e) => Center(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          e,
                          style: TextStyle(fontSize: 80.sp, color: Colors.grey),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
