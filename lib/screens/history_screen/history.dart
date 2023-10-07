import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:currency_converter/screens/history_screen/conversion_history_tile.dart';
import 'package:currency_converter/services/conversion_history_service.dart';
import 'package:currency_converter/shared/page_title.dart';
import 'package:currency_converter/states/fetch_conversion_history.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends ConsumerState<HistoryScreen> {
  final ConversionHistoryService conversionHistoryService = ConversionHistoryService();

  @override
  Widget build(BuildContext context) {
    var history = ref.watch(fetchConversionHistoryProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            right: 24,
            left: 24,
          ),
          child: history.when(
            data: (data) {
              // var historyData = ref.read(data.state);
              return ListView(
                children: [
                  const PageTitle(text: 'History'),
                  for (final conversion in data.reversed)
                    ConversionHistoryTile(
                      conversion: conversion,
                    )
                ],
              );
            },
            loading: () => Container(),
            error: (error, stackTrace) => Container(),
          ),
        ),
      ),
    );
  }
}
