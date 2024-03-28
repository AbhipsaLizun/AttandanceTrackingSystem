

import 'package:attendance_system/app/modules/Employee/ColorsGallary/color_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/Employee/Leave/controller/apply_leave_controller.dart';

class RadioButton extends StatelessWidget {
   RadioButton({super.key});

  final ApplyLeaveController controller = Get.put(ApplyLeaveController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              horizontalTitleGap: -5,
              minVerticalPadding: 0,
              dense: true,
              title: const Text('Casual Leave',
              style: TextStyle(fontSize: 14),),
              leading: Radio<int>(
                value: 1,
                groupValue: controller.selectedOption.value,
                activeColor: ColorSection.primaryColor, // Change the active radio button color here
                fillColor: MaterialStateProperty.all(ColorSection.primaryColor), // Change the fill color when selected
                splashRadius: 10, // Change the splash radius when clicked
                onChanged: (int? value) {
                  //setState(() {
                  //print("Button value1: $value");
                  controller.selectedOption.value = value!;
                  //});
                },
              ),
            ),
          ),

          Flexible(
            flex: 1,
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              horizontalTitleGap: -5,
              minVerticalPadding: 0,
              dense: true,
              title: const Text('Medical Leave',
                style: TextStyle(fontSize: 14),),
              leading: Radio<int>(
                value: 2,
                groupValue: controller.selectedOption.value,
                activeColor: Colors.blue, // Change the active radio button color here
                fillColor: MaterialStateProperty.all(ColorSection.primaryColor), // Change the fill color when selected
                splashRadius: 10, // Change the splash radius when clicked
                onChanged: (int? value) {
                  //setState(() {
                  //print("Button value2: $value");
                  controller.selectedOption.value = value!;
                  //});
                },
              ),
            ),
          ),

          Flexible(
            flex: 1,
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              horizontalTitleGap: -5,
              minVerticalPadding: 0,
              dense: true,
              title: const Text('Other Type Leave',  //
                style: TextStyle(fontSize: 14),),
              leading: Radio<int>(
                value: 3,          //
                groupValue: controller.selectedOption.value,   //
                activeColor: Colors.blue, // Change the active radio button color here
                fillColor: MaterialStateProperty.all(ColorSection.primaryColor), // Change the fill color when selected
                splashRadius: 10, // Change the splash radius when clicked
                onChanged: (int? value) {         //
                  print("Button value3: $value");
                  controller.selectedOption.value = value!;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyLeaveType extends StatelessWidget {

  // final int value;
  // final groupValue;
  // final String title;
  // final ValueChanged onChanged;
  final String date;
  MyLeaveType({Key? key, required this.date}): super(key: key);

  final ApplyLeaveController controller = Get.put(ApplyLeaveController());

  @override
  Widget build(BuildContext context) {
    return Obx(
     ()=> Row(
        children: [
          Flexible(
            flex: 1,
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              horizontalTitleGap: -5,
              minVerticalPadding: 0,
              dense: true,
              title:  const Text("Full",  //
                style: TextStyle(fontSize: 14),),
              leading: Radio<int>(
                value: 1,          //
           groupValue: date == "fromDate" ? controller.radioSelectedTypeFrom.value : controller.radioSelectedTypeTo.value,
                activeColor: Colors.blue, // Change the active radio button color here
                fillColor: MaterialStateProperty.all(Colors.red[500]), // Change the fill color when selected
                splashRadius: 5, // Change the splash radius when clicked
                onChanged: (int? value) {         //
                  print("Button value3: $value");
                  if(date == "fromDate"){
                    controller.radioSelectedTypeFrom.value = value!;
                    print("radioSelectedTypeFrom ${controller.radioSelectedTypeFrom.value}");
                  }else{
                    controller.radioSelectedTypeTo.value = value!;
                    print("radioSelectedTypeTo ${controller.radioSelectedTypeTo.value}");
                  }
                },
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              horizontalTitleGap: -5,
              minVerticalPadding: 0,
              dense: true,
              title:  const Text("First Half",  //
                style: TextStyle(fontSize: 14),),
              leading: Radio<int>(
                  value: 2,          //
                  groupValue: date == "fromDate" ? controller.radioSelectedTypeFrom.value : controller.radioSelectedTypeTo.value,
                  activeColor: Colors.blue, // Change the active radio button color here
                  fillColor: MaterialStateProperty.all(Colors.orange), // Change the fill color when selected
                  splashRadius: 5, // Change the splash radius when clicked
                  onChanged:(int? value) {
                  print("Button value3: $value");
                  if(date == "fromDate"){
                    controller.radioSelectedTypeFrom.value = value!;
                    print("radioSelectedTypeFrom ${controller.radioSelectedTypeFrom.value}");
                  }else{
                    controller.radioSelectedTypeTo.value = value!;
                    print("radioSelectedTypeTo ${controller.radioSelectedTypeTo.value}");
                  }
                },
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              horizontalTitleGap: -5,
              minVerticalPadding: 0,
              dense: true,
              title:  const Text("Second Half",  //
                style: TextStyle(fontSize: 14),),
              leading: Radio<int>(
                  value: 3,
                  groupValue: date == "fromDate" ? controller.radioSelectedTypeFrom.value : controller.radioSelectedTypeTo.value,
                  activeColor: Colors.blue, // Change the active radio button color here
                  fillColor: MaterialStateProperty.all(Colors.indigo), // Change the fill color when selected
                  splashRadius: 5, // Change the splash radius when clicked
                  onChanged:(int? value) {
                  print("Button value3: $value");
                  if(date == "fromDate"){
                        controller.radioSelectedTypeFrom.value = value!;
                  }else{
                    controller.radioSelectedTypeTo.value = value!;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}



