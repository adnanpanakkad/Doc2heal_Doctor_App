import 'package:doc2heal_doctor/controller/document_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeSlotPiker extends StatelessWidget {
  final DocumentController documentController = Get.put(DocumentController());
  final TextEditingController? controller;
  final String hintText;
  final FormFieldValidator? validation;
  final Function onTap;

  TimeSlotPiker({
    super.key,
    this.controller,
    required this.hintText,
    this.validation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        readOnly: true,
        controller: controller,
        validator: validation,
        onTap: () => onTap(),
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}