import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:currency_converter/states/conversion_controller/conversion_controller_provider.dart';

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
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 8,
                            ),
                            child: Countup(
                              begin: 0,
                              end: currentConversion.valueTo,
                              curve: Curves.bounceOut,
                              precision: 2,
                              duration: const Duration(milliseconds: 350),
                              separator: ',',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                    ),
                    child: DropdownButton<String>(
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
                          valueTo: 0.0,
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
