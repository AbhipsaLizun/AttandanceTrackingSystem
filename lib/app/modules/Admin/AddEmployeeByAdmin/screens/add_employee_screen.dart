import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../shared/constants/color_constants.dart';
import '../../../../shared/widgets/CustomInputDecoration.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/decoration_helper.dart';
import '../../Home/controllers/admin_home_screen_controller.dart';
import '../controllers/add_employee_screen_controller.dart';
import '../models/financial_year.dart';
import '../models/reporting_manager.dart';
import '../models/role.dart';

class AddEmployeeScreen extends StatelessWidget {
  final addEmployeeController = Get.put(AddEmployeeScreenController());
  final AdminHomeScreenController adminHomeScreenController =
      Get.find<AdminHomeScreenController>();

  AddEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //  double c_width = MediaQuery.of(context).size.width * 0.4;
    print(adminHomeScreenController.selectedBranchId.value);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Employee"),
        //title: Obx(() => Text(_controller.selectedLocation.value)),
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/svg/ScreenBG_White.svg',
            fit: BoxFit.cover,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: EmployeeRegistrationForm(),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'Register',
                      onPressed: addEmployeeController.submitForm,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}


class EmployeeRegistrationForm extends StatelessWidget {
  final AddEmployeeScreenController addEmployeeController = Get.find();
  final RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  EmployeeRegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      File? selectedImage = addEmployeeController.pickedImage.value;
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: addEmployeeController.formKey,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 70,

                    backgroundColor: Colors.black54,
                    child: ClipOval(

                      child: selectedImage != null
                          ? Image.file(
                              selectedImage,
                              width: 135,
                              height: 135,
                              fit: BoxFit.cover,
                            )
                          : Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Image.asset('assets/images/png/no_photo.png',
                                fit: BoxFit.cover, ),
                          ),
                    ),
                  ),
                  InkWell(
                    onTap: () => addEmployeeController.showPhotoPicker(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 90.0, left: 110.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black45)),
                            child: const CircleAvatar(
                              backgroundColor: LightColor.whitecolor1,
                              radius: 20.0,
                              child: Icon(
                                Icons.camera_alt,
                                size: 20,
                                color: LightColor.bgPrimary,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Stack(
                children: [
                  DropdownButtonFormField<FinancialYear>(
                    decoration: DecorationHelper.roundedBoxDecoration,
                    value: addEmployeeController.selectedFinancialYear.value,
                    items: <DropdownMenuItem<FinancialYear>>[
                      const DropdownMenuItem<FinancialYear>(
                        value: null,
                        child: Text('Select Financial Year'),
                      ),
                      ...addEmployeeController.financialyears
                          .map((branch) => DropdownMenuItem<FinancialYear>(
                                value: branch,
                                child: Text(branch.fYear),
                              ))
                          .toList(),
                    ],
                    onChanged: (selectedBranch) {
                      addEmployeeController.selectedFinancialYear.value =
                          selectedBranch;
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Financial Year is required";
                      }
                      return null;
                    },
                  ),
                  if (addEmployeeController.financialyears.isEmpty)
                    const Positioned.fill(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                ],
              ),

              SizedBox(height: addEmployeeController.screenHeight * 0.03),
              TextFormField(
                controller: addEmployeeController.firstNameController,
                readOnly: false,
                decoration:
                    CustomInputDecoration.textFieldDecoration('First Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'First Name is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: addEmployeeController.screenHeight * 0.03),
              TextFormField(
                controller: addEmployeeController.middleNameController,
                readOnly: false,
                decoration:
                    CustomInputDecoration.textFieldDecoration('Middle Name'),
              ),

              SizedBox(height: addEmployeeController.screenHeight * 0.03),

              TextFormField(
                controller: addEmployeeController.lastNameController,
                readOnly: false,
                decoration:
                    CustomInputDecoration.textFieldDecoration('Last Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Last Name is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: addEmployeeController.screenHeight * 0.03),
              TextFormField(
                controller: addEmployeeController.emailController,
                readOnly: false,
                decoration: CustomInputDecoration.textFieldDecoration('Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  } else if (!emailValid.hasMatch(value)) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: addEmployeeController.screenHeight * 0.03),
              TextFormField(
                controller: addEmployeeController.confirmEmailController,
                readOnly: false,
                decoration:
                    CustomInputDecoration.textFieldDecoration('Confirm Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Confirmation email is required';
                  } else if (value !=
                      addEmployeeController.emailController.text) {
                    return 'Confirmation email does not match the email';
                  }
                  return null;
                },
              ),
              SizedBox(height: addEmployeeController.screenHeight * 0.03),
              TextFormField(
                controller: addEmployeeController.alternativeEmailController,
                readOnly: false,
                decoration: CustomInputDecoration.textFieldDecoration(
                    'Alternative Email'),
              ),
              SizedBox(height: addEmployeeController.screenHeight * 0.03),
              TextFormField(
                controller: addEmployeeController.phoneNumberController,
                readOnly: false,
                maxLength: 10,
                decoration:
                    CustomInputDecoration.textFieldDecoration('Phone Number'),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  // Add any other formatters if needed
                ],
                keyboardType: TextInputType.phone,
                // Set keyboardType to TextInputType.phone for numeric keyboard

                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Phone No is required';
                  } else if (validateMobile(value) != null) {
                    return 'Please enter a valid Phone No';
                  }
                  return null;
                },
              ),

              SizedBox(height: addEmployeeController.screenHeight * 0.03),
              TextFormField(
                  controller:
                      addEmployeeController.confirmPhoneNumberController,
                  readOnly: false,
                  maxLength: 10,
                  decoration: CustomInputDecoration.textFieldDecoration(
                      'Confirmation Phone Number'),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    // Add any other formatters if needed
                  ],
                  keyboardType: TextInputType.phone,
                  // Set keyboardType to TextInputType.phone for numeric keyboard
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Confirmation Phone No is required';
                    } else if (value !=
                        addEmployeeController.phoneNumberController.text) {
                      return 'Confirmation Phone No does not match the Phone No';
                    }
                    return null;
                  }),
              SizedBox(height: addEmployeeController.screenHeight * 0.03),
              TextFormField(
                controller:
                    addEmployeeController.alternativePhoneNumberController,
                readOnly: false,
                maxLength: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  // Add any other formatters if needed
                ],
                keyboardType: TextInputType.phone,
                decoration: CustomInputDecoration.textFieldDecoration(
                    'Alternative Phone Number'),
              ),

              SizedBox(height: addEmployeeController.screenHeight * 0.03),

              TextFormField(
                  controller: addEmployeeController.addressController,
                  readOnly: false,
                  decoration:
                      CustomInputDecoration.textFieldDecoration('Address'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Address is required';
                    }
                    return null;
                  }),

              SizedBox(height: addEmployeeController.screenHeight * 0.03),

              TextFormField(
                  controller: addEmployeeController.usernameController,
                  readOnly: false,
                  decoration:
                      CustomInputDecoration.textFieldDecoration('Username'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  }),

              SizedBox(height: addEmployeeController.screenHeight * 0.03),
              TextFormField(
                  controller: addEmployeeController.passwordController,
                  readOnly: false,
                  decoration:
                      CustomInputDecoration.textFieldDecoration('Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  }),

              SizedBox(height: addEmployeeController.screenHeight * 0.03),

              Stack(
                children: [
                  DropdownButtonFormField<Role>(
                    decoration: DecorationHelper.roundedBoxDecoration,
                    value: addEmployeeController.selectedRole.value,
                    items: <DropdownMenuItem<Role>>[
                      const DropdownMenuItem<Role>(
                        value: null,
                        child: Text('Select Role'),
                      ),
                      ...addEmployeeController.roles
                          .map((role) => DropdownMenuItem<Role>(
                                value: role,
                                child: Text(role.roleName),
                              ))
                          .toList(),
                    ],
                    onChanged: (selectedRole) {
                      addEmployeeController.selectedRole.value = selectedRole;
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Role is required";
                      }
                      return null;
                    },
                  ),
                  if (addEmployeeController.roles.isEmpty)
                    const Positioned.fill(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                ],
              ),

              SizedBox(height: addEmployeeController.screenHeight * 0.03),

/*            Obx(() {
                if (addEmployeeController.companies.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return DropdownButtonFormField<Company>(
                    decoration: DecorationHelper.roundedBoxDecoration,
                    value: addEmployeeController.selectedCompany.value,
                    items: <DropdownMenuItem<Company>>[
                      const DropdownMenuItem<Company>(
                        value: null,
                        child: Text('Select Company'),
                      ),
                      ...addEmployeeController.companies
                          .map((company) => DropdownMenuItem<Company>(
                                value: company,
                                child: Text(company.companyName),
                              ))
                          .toList(),
                    ],
                    onChanged: (selectedCompany) {
                      print(selectedCompany);
                      print(selectedCompany!.companyName);

                        //  addEmployeeController.branches.clear();
                        addEmployeeController.selectedCompany.value = selectedCompany;
                        addEmployeeController.selectedBranch.value = null;
                        addEmployeeController.selectedReportingManager.value = null; // Reset selected block
                        addEmployeeController.fetchBranches(selectedCompany!.companyId);

                    },
                    validator: (value) {
                      if (value == null) {
                        return "Company is required";
                      }
                      return null;
                    },
                  );
                }
              })*/
              // SizedBox(height: addEmployeeController.screenHeight * 0.03),
/*            Obx(() {
                return DropdownButtonFormField<Branch>(
                  decoration: DecorationHelper.roundedBoxDecoration,
                  value: addEmployeeController.selectedBranch.value,
                  items: <DropdownMenuItem<Branch>>[
                    const DropdownMenuItem<Branch>(
                      value: null,
                      child: Text('Select Branch'),
                    ),
                    ...addEmployeeController.branches
                        .map((branch) => DropdownMenuItem<Branch>(
                              value: branch,
                              child: Text(branch.branchName),
                            ))
                        .toList(),
                  ],
                  onChanged: (selectedBranch) {
                    addEmployeeController.selectedBranch.value = selectedBranch;
                    addEmployeeController.selectedReportingManager.value = null;

                    // if (selectedBranch != null) {
                      addEmployeeController.latitudeController.text =
                          selectedBranch!.latitude;
                      addEmployeeController.longitudeController.text =
                          selectedBranch.longitude;
                      addEmployeeController
                          .fetchReportingManagers();
                    */ /*} else {
                      addEmployeeController.reportingManagers.clear();
                      addEmployeeController.latitudeController.text = "";
                      addEmployeeController.longitudeController.text = "";
                    }*/ /*
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Branch is required";
                    }
                    return null;
                  },
                );
              })*/

              // SizedBox(height: addEmployeeController.screenHeight * 0.03),

              //   SizedBox(height: addEmployeeController.screenHeight * 0.03),

              Stack(
                children: [
                  DropdownButtonFormField<ReportingManager>(
                    decoration: DecorationHelper.roundedBoxDecoration,
                    value: addEmployeeController.selectedReportingManager.value,
                    items: <DropdownMenuItem<ReportingManager>>[
                      const DropdownMenuItem<ReportingManager>(
                        value: null,
                        child: Text('Select Reporting Manager'),
                      ),
                      ...addEmployeeController.reportingManagers.map((manager) {
                        return DropdownMenuItem<ReportingManager>(
                          value: manager,
                          child:
                              Text('${manager.firstName} ${manager.lastName}'),
                        );
                      }).toList(),
                    ],
                    onChanged: (selectedManager) {
                      addEmployeeController.selectedReportingManager.value =
                          selectedManager;
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Reporting Manager is required";
                      }
                      return null;
                    },
                  ),
                  if (addEmployeeController.reportingManagers.isEmpty)
                    const Positioned.fill(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                ],
              ),
              SizedBox(height: addEmployeeController.screenHeight * 0.03),

              Obx(() {
                if (addEmployeeController.selectedBranch.value != null) {
                  return Column(
                    children: [
                      TextFormField(
                        controller: addEmployeeController.latitudeController,
                        readOnly: true,
                        decoration: CustomInputDecoration.textFieldDecoration(
                            'Latitude'),
                      ),
                      SizedBox(
                          height: addEmployeeController.screenHeight * 0.03),
                      TextFormField(
                        controller: addEmployeeController.longitudeController,
                        readOnly: true,
                        decoration: CustomInputDecoration.textFieldDecoration(
                            'Longitude'),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
            ],
          ),
        ),
      );
    });
  }

  String? validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }
}
