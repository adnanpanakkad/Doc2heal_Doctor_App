import 'package:doc2heal_doctor/utils/text_style.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String text;
  const CustomAppbar({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: CustomTextStyle
                        .highboldTxtStyle, // Ensure CustomTextStyle is defined
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
            // child: Row(
            //   children: [
            //     // IconButton(
            //     //   onPressed: () {},
            //     //   icon: Icon(
            //     //     Icons.videocam_outlined,
            //     //     size: 30,
            //     //   ),
            //     // ),
            //     IconButton(
            //       onPressed: () {},
            //       icon: const Icon(
            //         Icons.more_vert_outlined,
            //         size: 28,
            //       ),
            //     ),
            //   ],
            // ),
            ),
      ],
    );
  }
}
