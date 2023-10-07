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
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formatDateTime(conversion.dateTime),
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          DefaultTextStyle(
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        conversion.fromCurrency,
                      ),
                      Text(
                        double.parse(conversion.valueFrom).toStringAsFixed(2),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Icon(CupertinoIcons.arrow_right),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        conversion.toCurrency,
                      ),
                      Text(
                        conversion.valueTo.toStringAsFixed(2),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Divider(
            // Add a Divider here
            thickness: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
