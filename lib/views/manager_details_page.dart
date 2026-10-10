import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/custom_widgets/custom_appbar.dart';
import 'package:tejas_loan/utils/color_constants.dart';
import 'package:tejas_loan/utils/image_constants.dart';

class ManagerDetailsPage extends StatelessWidget {
  const ManagerDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(context: context, title: 'Manager Details'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 15.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.sp),

            // Profile picture
            SizedBox(
              height: 67,
              width: 67,
              child: const CircleAvatar(
                  radius: 50,
                  foregroundColor: Colors.black,
                  backgroundImage: AssetImage(
                    ImageConstants.CompanyLogo,
                  )),
            ),
            SizedBox(height: 20.sp),

            // Name and email
            Text(
              'Bhavish',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorConstants.ink,
              ),
            ),

            SizedBox(height: 44),

            // Details
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 8.sp),
              decoration: BoxDecoration(
                color: ColorConstants.surfaceLight,
                borderRadius: BorderRadius.circular(16.sp),
                boxShadow: ColorConstants.softShadow,
              ),
              child: Column(
                children: [
                  buildDetailRow(Icons.phone, 'Mobile Number', '+91 ******8655'),
                  buildDetailRow(Icons.mail, 'Email ID', '*****@gmail.com'),
                  buildDetailRow(Icons.public, 'Role', 'Credit Manager'),
                  buildDetailRow(Icons.perm_identity, 'Employee ID', 'KS-100003'),
                ],
              ),
            ),

            SizedBox(height: 30.sp),

            // Edit Button
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     foregroundColor: Colors.red,
            //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //   ),
            //   child: Text(
            //     'Edit',
            //     style: TextStyle(fontSize: 18),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: ColorConstants.primary),
          const SizedBox(width: 16),
          Text(
            '$label -',
            style: TextStyle(color: ColorConstants.muted),
          ),
          const Spacer(),
          Text(
            textAlign: TextAlign.end,
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: ColorConstants.body,
            ),
          ),
        ],
      ),
    );
  }
}
