import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:upoint_purchase_app/services/itemService.dart';
import 'package:upoint_purchase_app/services/purchaseService.dart';

import '../services/meService.dart';

class HomeScreen extends StatefulWidget {
  final String token;
  const HomeScreen({super.key, required this.token});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dio = Dio();
  late Map<String, dynamic> meInfo = {};
  late Map<String, dynamic> itemInfo = {};
  late Map<String, dynamic> purchase = {};
  late String itemId;

  Future<void> fetchMe() async {
    try {
      final tempMeService = meService(dio, widget.token);
      final pMeService = await tempMeService.getMeService();

      meInfo = pMeService;
      print("success me $meInfo");
    } catch (error) {
      print("error: $error");
    }
  }

  Future<void> fetchItem() async {
    try {
      final tempItemService = itemService(dio, widget.token);
      final pitemService = await tempItemService.getItemService();

      itemInfo = pitemService;
      print("Success item: $itemInfo");
    } catch (error) {
      print("error: $error");
    }
  }

  Future<void> makePurchase() async {
    try {
      final tempPurchaseService = purchaseService(dio, widget.token);
      final ppurchaseService = await tempPurchaseService.doPurchase(itemId);

      purchase = ppurchaseService;
      print("Success purchase: $purchase");
    } catch (error) {
      print("error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
