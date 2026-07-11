import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../main.dart';
import '../utils/color_constants.dart';
import '../utils/shared_constants.dart';

class CustomDropdown extends StatelessWidget {
  var currentValue;
  List<dynamic> list;
  void Function(dynamic) onChanged;
  bool isModelList;
  CustomDropdown({super.key,required this.currentValue,required this.list,required this.onChanged,this.isModelList=true});

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.symmetric(horizontal: 10.sp),
        padding: EdgeInsets.only(left: 0.sp, right: 15.sp),
        height: Get.height * 0.075,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: ColorConstants.surfaceLight,
          border: Border.all(
            color: ColorConstants.border,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(13.sp),
        ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          iconStyleData: IconStyleData(
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: ColorConstants.primary,
                size: 22.sp,
              )),
          isExpanded: true,
          dropdownStyleData: DropdownStyleData(
            maxHeight: 60.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13.sp),
              color: ColorConstants.surfaceLight,
              boxShadow: ColorConstants.softShadow,
            ),
          ),

          value:currentValue,
          // Change here
          onChanged: onChanged,
          items:isModelList?list!.map((item) {
            return DropdownMenuItem(
              value: item.id,
              child: Text(
               item.name.toString(),
                style: TextStyle(
                  letterSpacing: 0.2.sp,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.ink,
                ),
              ),
            );
          }).toList():
          list.map((value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      letterSpacing: 1.sp,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).textTheme.titleMedium!.color,
                                    ),
                                  ));
                            }).toList(),
        ),
      ),
    );
  }
}
