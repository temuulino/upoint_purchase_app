import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:upoint_purchase_app/const/spacing.dart';
import 'package:upoint_purchase_app/const/text_field.dart';
import 'package:upoint_purchase_app/services/itemService.dart';
import 'package:upoint_purchase_app/services/purchaseService.dart';

import '../const/colors.dart';
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
  late List<Map<String, dynamic>> itemInfo = [];
  late Map<String, dynamic> purchase = {};
  late String itemId;

  @override
  void initState() {
    super.initState();
    fetchMe();
    fetchItem();
  }

  Future<void> fetchMe() async {
    try {
      final tempMeService = meService(dio, widget.token);
      final pMeService = await tempMeService.getMeService();

      setState(() {
        meInfo = pMeService;
      });
      print("success me $meInfo");
    } catch (error) {
      print("error: $error");
    }
  }

  Future<void> fetchItem() async {
    try {
      final tempItemService = itemService(dio, widget.token);
      final pitemService = await tempItemService.getItemService();

      setState(() {
        itemInfo = pitemService;
      });
      print("Success item: $itemInfo");
    } catch (error) {
      print("error: $error");
    }
  }

  Future<void> makePurchase() async {
    try {
      final tempPurchaseService = purchaseService(dio, widget.token);
      final ppurchaseService = await tempPurchaseService.doPurchase(itemId);

      setState(() {
        purchase = ppurchaseService;
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: 'Амжилттай',
        desc: 'Худалдан авалтын буцан олголт: ${purchase['cashbackReceived'].toStringAsFixed(2)}',
        btnOkOnPress: () {
          fetchMe();
        },
        btnOkText: 'Ok',
        btnOkColor: successColor5,
      ).show();
      print("Success purchase: $purchase");
    } catch (error) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: 'Амжилтгүй',
        desc: 'Таны онооны үлдэгдэл хүрэлцэхгүй байна',
        btnOkOnPress: () {},
        btnOkText: 'Ok',
        btnOkColor: dangerColor5,
      ).show();
      print("error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (meInfo.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: screenWidth(context),
                  height: screenHeight(context) * 0.25,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                    ),
                    gradient: LinearGradient(
                      colors: [primaryColor5, primaryColor8],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Сайн байна уу?',
                          style: ktsBodyMassiveBold.copyWith(color: whiteColor),
                        ),
                        h12(),
                        Row(
                          children: [
                            Image.asset(
                              'assets/profile_pic.png',
                              width: 120,
                              height: 120,
                            ),
                            w24(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 60,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: primaryColor9,
                                    boxShadow: [
                                      BoxShadow(
                                        color: greyColor8.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        meInfo['card']['balance'].toStringAsFixed(2),
                                        style: ktsBodyLargeBold.copyWith(color: whiteColor),
                                      ),
                                      w4(),
                                      Icon(
                                        Icons.price_change_rounded,
                                        color: whiteColor,
                                      ),
                                    ],
                                  ),
                                ),
                                h8(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      meInfo['card']['cardNumber'],
                                      style: ktsBodyRegular.copyWith(color: whiteColor),
                                    ),
                                    w4(),
                                    Icon(
                                      Icons.wallet,
                                      color: whiteColor,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                h24(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemInfo.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = itemInfo[index];
                    return Card(
                      color: whiteColor,
                      elevation: 2.0,
                      shadowColor: whiteColor,
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.info,
                                  animType: AnimType.scale,
                                  title: '${item['name']}',
                                  desc: '${item['price']} оноогоор худалдан авах уу?',
                                  btnOkOnPress: () {
                                    setState(() {
                                      itemId = item['_id'];
                                    });
                                    makePurchase();
                                  },
                                  btnOkText: 'Тийм',
                                  btnOkColor: informationColor5,
                                  btnCancelColor: dangerColor5,
                                  btnCancelOnPress: () {},
                                  btnCancelText: 'Үгүй')
                              .show();
                          // print("Item ID: ${item['_id']}");
                        },
                        borderRadius: BorderRadius.circular(12.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: greyColor5.withOpacity(0.5),
                                      blurRadius: 3.0,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Icon(Icons.shopping_cart, size: 40.0, color: Colors.blue),
                              ),
                              const SizedBox(width: 20.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item['name'],
                                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Container(
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: primaryColor8,
                                            borderRadius: BorderRadius.circular(6.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '3%',
                                              style: ktsBodyRegularBold.copyWith(color: whiteColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    h8(),
                                    Text(
                                      'Үнэ: ${item['price']}₮ | Тоо: ${item['quantity']}',
                                      style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
