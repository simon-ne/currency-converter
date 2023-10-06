import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/states/conversion_controller/conversion_controller_provider.dart';

class ConversionInputTo extends StatelessWidget {
  final List<String> currencies;
  const ConversionInputTo({
    super.key,
    required this.currencies,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Consumer(
        builder: (context, ref, child) {
          var conversionController = ref.watch(conversionControllerProvider.notifier);
          var currentConversion = ref.watch(conversionControllerProvider);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'to'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    currentConversion.valueTo.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  DropdownButton<String>(
                    isDense: true,
                    underline: Container(),
                    padding: const EdgeInsets.only(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                    ),
                    value: currentConversion.toCurrency,
                    onChanged: (String? toCurrency) {
                      conversionController.updateConversionState(
                        toCurrency: toCurrency,
                      );
                    },
                    icon: SvgPicture.asset('assets/icons/chevron-down.svg'),
                    items: currencies.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
