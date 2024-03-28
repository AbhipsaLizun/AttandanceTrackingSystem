import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../shared/widgets/no_recor_widget.dart';
import '../../ColorsGallary/color_section.dart';
import '../controller/applied_reg_list_controller.dart';

class AppliedRegularizationListScreen extends StatelessWidget {
  AppliedRegularizationListScreen({super.key});

  AppliedRegularizationListController controller = Get.put(
      AppliedRegularizationListController());

  final List<String> items = List.generate(10, (index) => 'Item $index');
  String date = "08.11.2023";

  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
          Scaffold(
            appBar: AppBar(
              title: const Text("Applied Regularization List"),
              backgroundColor: ColorSection.primaryColor,
              iconTheme: IconThemeData(color: ColorSection.textColorWhite),
            ),
            // ignore: unrelated_type_equality_checks
            body: controller.isLoading.value ?
            const Center(
              child: CircularProgressIndicator(),
            )
                : SafeArea(
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
                  // Container(
                  //     height: MediaQuery
                  //         .of(context)
                  //         .size
                  //         .height,
                  //     width: MediaQuery
                  //         .of(context)
                  //         .size
                  //         .width,
                  //     padding: const EdgeInsets.all(10),
                  //     //color: Colors.red,
                  //     child: 
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: RefreshIndicator(
                          triggerMode: RefreshIndicatorTriggerMode.onEdge,
                          onRefresh: () async {
                            await Future.delayed(const Duration(seconds: 3),(){
                              controller.fetchRegularizationAppliedList();
                            }
                            );
                          },
                          child: controller.appliedRegResultList.value.isEmpty ?
                          Center(
                              child: NoRecordWidget(
                                errorMessage: 'No Record Found',
                              )
                            //Text("No records found ")
                          ) :
                          ListView.builder(
                              reverse: false  ,
                              //shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: controller.appliedRegResultList
                                  .value.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 5,
                                  margin: const EdgeInsets.only(
                                      bottom: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Customize the border radius as needed
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorSection
                                              .primaryColor),
                                      borderRadius: BorderRadius.circular(
                                          10.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Card(
                                                elevation: 4,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .all(5),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(10),
                                                    //border: Border.all(color: Colors.grey)
                                                  ),
                                                  child: Text(
                                                    '${(DateFormat(
                                                        'dd.MM.yyyy').format(controller.appliedRegResultList[index].fromDate))} - ${(DateFormat(
                                                        'dd.MM.yyyy').format(controller.appliedRegResultList[index].toDate))}',
                                                    //"10.11.2023 - 15.11.2023",
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        //color: ColorSection.repTextColor,
                                                        fontSize: 14
                                                    ),),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),

                                            // Expanded(child:
                                            Container(
                                              width: 100,
                                              padding: const EdgeInsets
                                                  .all(3.0),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(10),
                                                  color:
                                                  getColorForRegStatus(
                                                      controller.appliedRegResultList[index].regFullStatus)
                                                // controller.appliedRegResultList[index].regFullStatus == "Approved" ? Colors.lightGreen.withOpacity(0.3)
                                                //     : controller.appliedRegResultList[index].regFullStatus == "Hold" ? Colors.yellow.withOpacity(0.5)
                                                //     : controller.appliedRegResultList[index].regFullStatus == "Reject" ? Colors.red.withOpacity(0.3)
                                                // :  controller.appliedRegResultList[index].regFullStatus == "Cancel" ? Colors.red.withOpacity(0.5) :
                                                // Colors.orangeAccent.withOpacity(0.3)
                                                //color: Colors.orangeAccent
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .all(4.0),
                                                child: Center(
                                                    child: Text(
                                                      controller.appliedRegResultList[index].regFullStatus.toString(),
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: controller.appliedRegResultList[index].regFullStatus == "Approved"
                                                              ? Colors.green
                                                              : controller.appliedRegResultList[index].regFullStatus == "Hold"
                                                              ? Colors.yellowAccent[450]
                                                              : controller.appliedRegResultList[index].regFullStatus == "Reject"
                                                              ? Colors.red
                                                              : controller.appliedRegResultList[index].regFullStatus == "Cancel"
                                                              ? Colors.red.withOpacity(0.5)
                                                              : Colors.deepOrange
                                                      ),
                                                    )),
                                                //child: Center(child: Text("Pending")),
                                              ),
                                            ),
                                            //  ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: MediaQuery.of(context).size.width,
                                            margin: const EdgeInsets.only(
                                                top: 5,
                                                bottom: 5,
                                                right: 5),
                                            padding: const EdgeInsets.all(
                                                5),
                                            decoration: BoxDecoration(
                                                //color: Colors.grey[200],
                                                borderRadius: BorderRadius
                                                    .circular(5)
                                            ),
                                            child: RichText(
                                            maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(
                                                  text: "Reason: ",
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors
                                                          .black),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: " ${controller.appliedRegResultList[index].remarks}",
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          color: Colors.black,
                                                          fontSize: 13),
                                                    )


                                                  ]
                                              ),


                                              // " ${items[index]}"
                                            )),

                                        Visibility(
                                          visible: controller
                                              .appliedRegResultList[index]
                                              .regFullStatus == "Approved"
                                              ? true
                                              : false,
                                          child: SizedBox(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                const Divider(
                                                  thickness: 1,
                                                ),

                                                RichText(
                                                  text: TextSpan(
                                                      text: "Approved By: ",
                                                      style: const TextStyle(
                                                          color: Colors
                                                              .black),
                                                      children: <
                                                          TextSpan>[
                                                        TextSpan(
                                                          text: " ${controller.appliedRegResultList[index].reportingManager}",
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              color: Colors.black,
                                                              fontSize: 14),
                                                        )
                                                      ]
                                                  ),
                                                ),

                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(" Remark",
                                                  style: TextStyle(
                                                      color: ColorSection
                                                          .primaryColor,
                                                      fontWeight: FontWeight
                                                          .w500
                                                  ),),

                                                Container(
                                                    margin: const EdgeInsets
                                                        .all(5),
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width,
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text: controller.appliedRegResultList[index].reportingManagerRemarks,
                                                        style: DefaultTextStyle.of(context).style,
                                                        children: <InlineSpan>[
                                                          const WidgetSpan(
                                                              alignment: PlaceholderAlignment
                                                                  .baseline,
                                                              baseline: TextBaseline
                                                                  .alphabetic,
                                                              child: SizedBox(
                                                                  width: 10)),
                                                          TextSpan(
                                                            text: DateFormat(
                                                                'dd.MM.yyyy')
                                                                .format(
                                                                controller
                                                                    .appliedRegResultList[index]
                                                                    .approveRejectDate),
                                                            style: const TextStyle(
                                                                fontWeight: FontWeight
                                                                    .w400,
                                                                color: Colors
                                                                    .blue,
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  //Text("If having problem with this solution, verifiy if the column is inside a Positioned. If so, you need to specify top.  $date"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),

                                        Align(
                                            alignment: Alignment
                                                .bottomRight,
                                            child: Text(
                                              //"08.11.2023",
                                              DateFormat('dd.MM.yyyy')
                                                  .format(controller
                                                  .appliedRegResultList[index]
                                                  .appliedDate),
                                              style: TextStyle(
                                                  color: ColorSection
                                                      .repTextColor,
                                                  fontSize: 12
                                              ),
                                            )),
                                        // ListTile(
                                        //   title: Text(items[index]),
                                        // ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          ),
                        ),
                      )
                  //)
                ],
              ),

            ),
          ),
    );
  }

  Color getColorForRegStatus(String regFullStatus) {
    switch (regFullStatus) {
      case 'Pending':
        return Colors.orangeAccent.withOpacity(0.3);
      case 'Approved':
        return Colors.lightGreen.withOpacity(0.3);
      case 'Cancel':
        return Colors.red.withOpacity(0.5);
      case 'Reject':
        return Colors.red.withOpacity(0.3);
      case 'Hold':
        return Colors.yellow.withOpacity(0.5);
      default:
        return Colors.grey;
    }
  }
}
