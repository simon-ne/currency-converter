import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/states/conversion_controller/conversion_controller_provider.dart';
import 'package:my_app/states/value_from_controller/value_from_controller.dart';

class ConversionInputFrom extends ConsumerStatefulWidget {
  final List<String> currencies;

  const ConversionInputFrom({
    super.key,
    required this.currencies,
  });

  @override
  ConsumerState<ConversionInputFrom> createState() => _ConversionInputFromState();
}

class _ConversionInputFromState extends ConsumerState<ConversionInputFrom> {
  late ValueFromEditingController _valueFromController;

  @override
  void initState() {
    var valueFrom = ref.read(conversionControllerProvider).valueFrom;
    _valueFromController = ValueFromEditingController(initialValue: valueFrom);
    super.initState();
  }

  @override
  void dispose() {
    _valueFromController.dispose();
    super.dispose();
  }

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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'from'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: _valueFromController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '0',
                        isDense: true,
                        contentPadding: EdgeInsets.only(
                          top: 0,
                          bottom: 4,
                          left: 0,
                          right: 0,
                        ),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      onChanged: (valueFrom) {
                        conversionController.updateConversionState(
                          valueFrom: valueFrom,
                        );
                      },
                    ),
                  ),
                  const Text(
                    'CZK',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
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
