// import 'package:flutter/cupertino.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter/utils/conversion.dart';

class ConversionHistoryTile extends StatelessWidget {
  final Conversion conversion;
  const ConversionHistoryTile({super.key, required this.conversion});

  String _formatDateTime(DateTime dateTime) {
    String day = dateTime.day.toString();
    String month = dateTime.month.toString();
    String year = dateTime.year.toString();
    String hour = dateTime.hour.toString();
    String minute = dateTime.minute.toString();
    return "$day.$month.$year $hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formatDateTime(conversion.dateTime),
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${conversion.fromCurrency}: ${double.parse(conversion.valueFrom).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Icon(CupertinoIcons.arrow_right),
              Text(
                "${conversion.toCurrency}: ${conversion.valueTo.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Divider(
            // Add a Divider here
            thickness: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
