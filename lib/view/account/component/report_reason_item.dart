import 'package:flutter/material.dart';
import '../../../model/report_model.dart';

class ReportReasonItem extends StatelessWidget {
  final ReportModel reportModel;
  const ReportReasonItem({
    Key? key,
    required this.reportModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(1),
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black87),
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Icon(
            Icons.circle,
            size: 20,
            color: reportModel.isSelected ? Colors.black87 : Colors.transparent,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          reportModel.reportText,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
