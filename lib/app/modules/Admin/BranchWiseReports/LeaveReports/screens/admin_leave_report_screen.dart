import 'package:flutter/material.dart';

import '../../../../../shared/widgets/no_recor_widget.dart';

class AdminLeaveReportScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Report'),
      ),
      body:  Center(
        child: NoRecordWidget(
          errorMessage: 'No record found',
        ),
      )
    );
  }

}
