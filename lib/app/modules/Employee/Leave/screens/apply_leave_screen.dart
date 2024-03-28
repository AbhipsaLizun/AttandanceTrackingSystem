
import 'package:attendance_system/app/modules/Employee/Leave/controller/apply_leave_controller.dart';
import 'package:attendance_system/app/shared/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import '../../../../shared/widgets/custom_radio_btn.dart';
import '../../../../shared/widgets/date_field.dart';
import '../../ColorsGallary/color_section.dart';
import '../../Commons/screensize.dart';
import '../../Commons/text_string.dart';
import '../../Regularization/screens/buttons.dart';
import '../controller/leave_report_controller.dart';

class LeaveApplyScreen extends StatelessWidget {
  LeaveApplyScreen({super.key});

  final ApplyLeaveController controller = Get.put(ApplyLeaveController());



  @override
  Widget build(BuildContext context) {
final LeaveReportController lv= Get.put(LeaveReportController());
    return Scaffold(
            appBar: AppBar(
            title: const Text("Apply Leave"),
            backgroundColor: ColorSection.primaryColor,
            iconTheme: IconThemeData(color: ColorSection.textColorWhite),
        ),
        body: Form(
          key: controller.formKey,
          child: SafeArea(
              child: Stack(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: SvgPicture.asset(
                      'assets/images/svg/ScreenBG_White.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      decoration: const BoxDecoration(),
                      //color: Colors.red,
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(TextString.reportManager,
                                  style: AppTextStyles.headlineText(context)),
                              SizedBox(
                                height: AppDimension.height(context) * 0.02,
                              ),
                               DropdownButtonHideUnderline(
                                  child: MultiSelectDropDown(
                                    showClearIcon: true,
                                    //controller: _controller,
                                    onOptionSelected: (options) {

                                      controller.selectedManager.value = options;


                                    },
                                    searchEnabled: false,
                                    options: controller.valueItemManagers,
                                    maxItems: 3,
                                    selectionType: SelectionType.multi,
                                    chipConfig:  ChipConfig(
                                        wrapType: WrapType.scroll, backgroundColor: ColorSection.primaryColor),
                                   // dropdownHeight: 100,
                                    optionTextStyle: const TextStyle(fontSize: 15),
                                    selectedOptionIcon:  Icon(
                                      Icons.check_circle,
                                      color: ColorSection.primaryColor,
                                    ),
                                    selectedOptionTextColor: Colors.green,
                                  ),
                                ),


                              SizedBox(
                                height: AppDimension.width(context) * 0.07,
                              ),
                              Text(TextString.leaveType,
                                  style: AppTextStyles.headlineText(context)),
                               RadioButton(),
                              SizedBox(
                                height: AppDimension.width(context) * 0.05,
                              ),
                              Text(TextString.fromDate,
                                  style: AppTextStyles.headlineText(context)),
                              SizedBox(
                                height: AppDimension.width(context) * 0.01,
                              ),

                              ///..........From Date............
                              DateField(
                                controller: controller.fromDateController,
                                onTap: () {
                                  controller.selectDate("FromDate");
                                },
                              ),
                              SizedBox(
                                height: AppDimension.width(context) * 0.02,
                              ),

                              ///...........Radio Button From Date.................
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black12)),
                                  child: MyLeaveType(
                                      date: 'fromDate',
                                    ),
                                  ),

                              SizedBox(
                                height: AppDimension.width(context) * 0.05,
                              ),
                              Text(TextString.toDate,
                                  style: AppTextStyles.headlineText(context)),
                              SizedBox(
                                height: AppDimension.width(context) * 0.01,
                              ),

                              ///..........To Date............
                              DateField(
                                controller: controller.toDateController,
                                onTap: () {
                                  controller.selectDate("ToDate");
                                },
                              ),
                              SizedBox(
                                height: AppDimension.width(context) * 0.02,
                              ),
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black12)),
                                  child:  MyLeaveType(
                                      date: 'ToDate',
                                    ),
                                  ),
                              SizedBox(
                                height: AppDimension.width(context) * 0.05,
                              ),

                              Text(TextString.leaveReason,
                                  style: AppTextStyles.headlineText(context)),
                              SizedBox(
                                height: AppDimension.width(context) * 0.02,
                              ),
                              ///..............Reason Container..............
                              TextFormField(
                                controller: controller.reasonController,
                                maxLines: null,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                                decoration:  InputDecoration(
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  contentPadding: EdgeInsets.all(10),
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none
                                  ),
                                ),
                                  validator:(text) {
                                    if (text!.isEmpty || text == '') {
                                      return "Please enter the reason";
                                    }
                                    return null;
                                  }
                              ),
                              SizedBox(
                                height: AppDimension.width(context) * 0.10,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8,
                                  bottom: 15),
                                  child: SizedBox(
                                    height: 45,
                                    width: AppDimension.width(context),
                                    child: Buttons(
                                      bgColor: ColorSection.primaryColor,
                                      text: "Submit",
                                      textColor: Colors.white,
                                      onTapBtn: () {
                                       // Get.find<LeaveReportController>();
                                        controller.applyLeave();
                                     },

                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                      )),
                ],
              ),
          ),
        ),
      );


  }
}
