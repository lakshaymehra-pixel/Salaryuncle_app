import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../main.dart';
import '../routes/routes_names.dart';
import '../utils/color_constants.dart';
import '../utils/shared_constants.dart';

class CustomProfilePicView extends StatelessWidget {
  const CustomProfilePicView({super.key});

  @override
  Widget build(BuildContext context) {
    return  prefs.getString(SharedConstants.PROFILE_PIC).toString() == ""
        ? Container(
      decoration: BoxDecoration(
          color: ColorConstants.surfaceLight,
          border: Border.all(color: ColorConstants.border, width: 1.5),
          shape: BoxShape.circle),
      height: 44,
      width: 44,
      child: Icon(
        Icons.person,
        color: ColorConstants.primary,
        size: 34,
      ),
    )
        : prefs.getString(SharedConstants.PROFILE_PIC) == null
        ? Container(
      decoration: BoxDecoration(
          color: ColorConstants.surfaceLight,
          border: Border.all(color: ColorConstants.border, width: 1.5),
          shape: BoxShape.circle),
      height: 44,
      width: 44,
      child: Icon(
        Icons.person,
        color: ColorConstants.primary,
        size: 34,
      ),
    )
        : (prefs.getBool(SharedConstants.IS_EDITABLE) ?? false)
        ? GestureDetector(
      onTap: () {
        Get.toNamed(RoutesName.DocScreen, arguments: [true]);
      },
      child: Badge(
        backgroundColor: ColorConstants.primary,
        padding: EdgeInsets.all(8.sp),
        label: Icon(Icons.edit, color: Colors.white, size: 17),
        alignment: AlignmentDirectional.bottomEnd,
        offset: const Offset(-4, -18),
        child: CircleAvatar(
          radius: 40,
          backgroundColor: ColorConstants.cardTintLight,
          child: ClipOval(
            clipBehavior: Clip.hardEdge,
            child: Image.network(
              errorBuilder: (c,o,s){
                return Container(
                  decoration: BoxDecoration(
                      color: ColorConstants.surfaceLight,
                      border: Border.all(color: ColorConstants.border, width: 1.5),
                      shape: BoxShape.circle),
                  height: 44,
                  width: 44,
                  child: Icon(
                    Icons.person,
                    color: ColorConstants.primary,
                    size: 34,
                  ),
                );
              },
              width: 100,
              height: 100,
              prefs.getString(SharedConstants.PROFILE_PIC) ?? "",
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    )
        : CircleAvatar(
      radius: 40,
      backgroundColor: ColorConstants.cardTintLight,
      child: ClipOval(
        clipBehavior: Clip.hardEdge,
        child: Image.network(
          errorBuilder: (c,o,s){
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).shadowColor),
                  shape: BoxShape.circle),
              height: 44,
              width: 44,
              child: Icon(
                Icons.person,
                color: Theme.of(context).shadowColor,
                size: 34,
              ),
            );
          },
          width: 100,
          height: 100,
          prefs.getString(SharedConstants.PROFILE_PIC) ?? "",
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
