import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:provider/provider.dart';
import 'package:pureone/helpers/constant_qty.dart';
import 'package:pureone/helpers/constantants.dart';
import 'package:pureone/helpers/string_to_rupee.dart';
import 'package:pureone/products/privacy_policy.dart';

// import 'package:pureone/products/non_tc_screen.dart';
import 'package:pureone/provider/product_page_provider.dart';
import 'package:pureone/routes/tf_routes.dart';
import 'package:url_launcher/link.dart';

import 'package:shimmer/shimmer.dart';

import 'package:flutter/src/widgets/framework.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductPageProvider provider = Provider.of<ProductPageProvider>(context);

    provider.setContext(context);
    return Scaffold(
      key: provider.scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      // backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        controller: provider.dashboardScroll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 90),
            Padding(
              padding: const EdgeInsets.only(right: 28.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          // color: Colors.red,
                          child: Image.asset(
                            "images/logo.png",
                            height: 60,
                            // height: 100,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Pure One \nMeat specialist',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Roboto',
                            color: Color(0xFF212121),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, TfRoutes.profilePage);
                    },
                    child: badges.Badge(
                      badgeStyle: badges.BadgeStyle(
                        shape: badges.BadgeShape.circle,
                        badgeColor: Colors.red,
                        padding: const EdgeInsets.all(5),
                        borderRadius: BorderRadius.circular(4),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2),
                        elevation: 2,
                      ),
                      child: const Icon(Icons.account_circle_outlined,
                          size: 30, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),

            InkWell(
              onTap: () {
                provider.openMapForPickLocationAndAddress();
              },
              child: StreamBuilder<Object>(
                  stream: provider.addressStream.stream,
                  builder: (context, snapshot) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(border: Border.all()),
                      child: ListTile(

                          // contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.location_on,
                              color: Color(0xFF000000)),
                          title: Text(
                            "${snapshot.hasData && snapshot.data == true ? provider.deliveryAddress : "Add Delivery Address"}",
                            maxLines: 2,
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: Color(0xFF000000))),
                    );
                  }),
            ),
            // InkWell(
            //   onTap: () {
            //     Navigator.pushNamed(context, TfRoutes.profilePage)
            //         .then((value) {
            //       provider.addressUpdate.add(true);
            //     });
            //   },
            //   child: StreamBuilder<Object>(
            //       stream: provider.addressStream.stream,
            //       builder: (context, snapshot) {
            //         // return Padding(
            //         //   padding: const EdgeInsets.symmetric(vertical: 8.0),
            //         //   child: Container(
            //         //       width: MediaQuery.of(context).size.width,
            //         //       margin: const EdgeInsets.all(8),
            //         //       decoration: BoxDecoration(border: Border.all()),
            //         //       child: Padding(
            //         //         padding: const EdgeInsets.all(18.0),
            //         //         child: Row(
            //         //           children: [
            //         //             const Icon(Icons.location_on,
            //         //                 color: Colors.black),
            //         //             Padding(
            //         //               padding: const EdgeInsets.only(left: 8.0),
            //         //               child: FutureBuilder<String>(
            //         //                 future: provider.getAddress(), // async work
            //         //                 builder: (BuildContext context,
            //         //                     AsyncSnapshot<String> snapshot) {
            //         //                   if (snapshot.connectionState ==
            //         //                       ConnectionState.waiting) {
            //         //                     return const Center(
            //         //                         child: Text('loading...',
            //         //                             style: TextStyle(
            //         //                                 color: Colors.black,
            //         //                                 fontWeight: FontWeight.bold,
            //         //                                 fontSize: 17)));
            //         //                   } else {
            //         //                     if (snapshot.hasError) {
            //         //                       return Center(
            //         //                           child: Text(
            //         //                               'Error: ${snapshot.error}',
            //         //                               style: const TextStyle(
            //         //                                   color: Colors.black,
            //         //                                   fontWeight:
            //         //                                       FontWeight.bold,
            //         //                                   fontSize: 15)));
            //         //                     } else {
            //         //                       return Container(
            //         //                         width: MediaQuery.of(context)
            //         //                                 .size
            //         //                                 .width -
            //         //                             110,
            //         //                         padding: const EdgeInsets.only(
            //         //                             right: 13.0),
            //         //                         child: Text(
            //         //                           softWrap: true,
            //         //                           '${snapshot.data}',
            //         //                           overflow: TextOverflow.ellipsis,
            //         //                           style: const TextStyle(
            //         //                             fontSize: 13.0,
            //         //                             fontFamily: 'Roboto',
            //         //                             color: Colors.black,
            //         //                             fontWeight: FontWeight.bold,
            //         //                           ),
            //         //                         ),
            //         //                       );
            //         //                     }
            //         //                   }
            //         //                 },
            //         //               ),
            //         //             ),
            //         //             const Icon(Icons.keyboard_arrow_down_outlined,
            //         //                 size: 19, color: Colors.black)
            //         //           ],
            //         //         ),
            //         //       )),
            //         // );
            //       }),
            // ),
            StreamBuilder<List<Widget>>(
                stream: provider.sliderLoaded.stream,
                builder: (context, snapshot) {
                  return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      // height: 100,
                      child: snapshot.data != null
                          ? CarouselSlider(
                              options: CarouselOptions(
                                height: 150,
                                autoPlay: true,
                                viewportFraction: 0.9,
                                aspectRatio: 2.0,
                                enlargeCenterPage: true,
                              ),
                              items: snapshot.data,
                            )
                          : Shimmer.fromColors(
                              baseColor: Colors.black12,
                              highlightColor: Colors.white,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 16,
                                    height: 150,
                                    color: Colors.white,
                                  )
                                ],
                              )));
                }),

            StreamBuilder<Object>(
                stream: provider.weDontDeliveryHereStream.stream,
                builder: (context, visibleSnapshot) {
                  return visibleSnapshot.hasData && visibleSnapshot.data == true
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 8, top: 30, bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Shop by categories",
                                        style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    // Text("Freshest meats and much more!",
                                    //     style: TextStyle(
                                    //       fontSize: 18,
                                    //       fontWeight: FontWeight.normal,
                                    //     )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: StreamBuilder<bool>(
                                    // key: provider.categoryKey,
                                    stream:
                                        provider.isCategoryIconsLoaded.stream,
                                    builder: (context, snapshot) {
                                      return snapshot.hasData &&
                                              snapshot.data == true
                                          ? Center(
                                              child: Wrap(
                                                alignment: WrapAlignment.center,
                                                children: provider
                                                    .categoryIconsWidget,
                                              ),
                                            )
                                          : Shimmer.fromColors(
                                              baseColor: Colors.black12,
                                              highlightColor: Colors.white,
                                              child: Row(children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color(
                                                                    0xFFe0f2f1)),
                                                      ),
                                                      Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 12),
                                                          width: 70,
                                                          height: 10,
                                                          color: const Color(
                                                              0xFFe0f2f1))
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color(
                                                                    0xFFe0f2f1)),
                                                      ),
                                                      Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 12),
                                                          width: 70,
                                                          height: 10,
                                                          color: const Color(
                                                              0xFFe0f2f1))
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color(
                                                                    0xFFe0f2f1)),
                                                      ),
                                                      Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 12),
                                                          width: 70,
                                                          height: 10,
                                                          color: const Color(
                                                              0xFFe0f2f1))
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color(
                                                                    0xFFe0f2f1)),
                                                      ),
                                                      Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 12),
                                                          width: 70,
                                                          height: 10,
                                                          color: const Color(
                                                              0xFFe0f2f1))
                                                    ],
                                                  ),
                                                ),
                                              ]));
                                    }),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 8, top: 30, bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Today's deal",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text("Offers only for you!",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey)),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.0, left: 8, right: 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(

                                          // key: provider.scrollView,
                                          height: 370,
                                          child: StreamBuilder<bool>(
                                              stream: provider
                                                  .discoverNewLoadedStream
                                                  .stream,
                                              builder:
                                                  (context, discoverSnapshot) {
                                                return discoverSnapshot
                                                            .hasData &&
                                                        discoverSnapshot.data ==
                                                            true
                                                    ? ListView.builder(
                                                        controller: provider
                                                            .discoverScrollController,
                                                        physics:
                                                            const ScrollPhysics(),
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: provider
                                                            .discoverNewList
                                                            .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int i) {
                                                          return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  Navigator.pushNamed(
                                                                      context,
                                                                      TfRoutes
                                                                          .productDetailsPage,
                                                                      arguments:
                                                                          provider
                                                                              .discoverNewList[i]);
                                                                },
                                                                child: Stack(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            200,
                                                                        height:
                                                                            180,
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius: const BorderRadius
                                                                              .all(
                                                                              Radius.circular(10.0)),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            placeholder: (context, url) =>
                                                                                AspectRatio(
                                                                              aspectRatio: 1.6,
                                                                              child: BlurHash(hash: provider.discoverNewList[i]["blurhashThumb"] ?? 'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                                                                            ),
                                                                            imageUrl:
                                                                                "${provider.discoverNewList[i]["low_qty"]}&quality=0.5",
                                                                            errorWidget: (context, url, error) =>
                                                                                const Icon(Icons.error),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                        bottom:
                                                                            4,
                                                                        right:
                                                                            4,
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            provider.addToCart(provider.discoverNewList[i],
                                                                                provider.discoverNewList[i]["specifications"]["Quantity"][0]);
                                                                          },
                                                                          child:
                                                                              const Card(
                                                                            child:
                                                                                Icon(Icons.add, size: 32),
                                                                          ),
                                                                        ))
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0,
                                                                        top: 8),
                                                                child: SizedBox(
                                                                  width: 200,
                                                                  child: Text(
                                                                    discoverSnapshot.data !=
                                                                                null &&
                                                                            discoverSnapshot.data ==
                                                                                true
                                                                        ? provider.discoverNewList[i]
                                                                            [
                                                                            "name"]
                                                                        : "Please wait..",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            19,
                                                                        fontFamily:
                                                                            "bree",
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: Colors
                                                                            .black),
                                                                    softWrap:
                                                                        true,
                                                                    maxLines: 3,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top: 10,
                                                                        left:
                                                                            8.0),
                                                                child: Text(
                                                                    discoverSnapshot
                                                                                .data ==
                                                                            true
                                                                        ? provider
                                                                                    .discoverNewList[i]["specifications"]
                                                                                ["Quantity"]
                                                                            [0]
                                                                        : "Please wait..",
                                                                    //"₹ 1202",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontFamily:
                                                                            "bree",
                                                                        color: Color(
                                                                            0xFF2E2E2E))),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top: 10,
                                                                        left:
                                                                            8.0),
                                                                child: SizedBox(
                                                                  width: 200,
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child: Text(
                                                                            discoverSnapshot.data == true
                                                                                ? "\u20B9 ${stringToMoney(provider.discoverNewList[i]["selling_price"])}"
                                                                                : "Please wait..",
                                                                            //"₹ 1202",
                                                                            style: const TextStyle(
                                                                                fontSize: 17,
                                                                                fontFamily: "bree",
                                                                                color: Color(0xFF2E2E2E))),
                                                                      ),
                                                                      Expanded(
                                                                        child: Text(
                                                                            discoverSnapshot.data == true
                                                                                ? "\u20B9 ${stringToMoney(provider.discoverNewList[i]["mrp"])}"
                                                                                : "Please wait..",
                                                                            //"₹ 1202",

                                                                            style: const TextStyle(
                                                                                fontSize: 17,
                                                                                decoration: TextDecoration.lineThrough,
                                                                                fontFamily: "bree",
                                                                                color: Color(0xFF9E9E9E))),
                                                                      ),
                                                                      Expanded(
                                                                        child: Text(
                                                                            "${getDiscountOffer(provider.discoverNewList[i]["selling_price"], provider.discoverNewList[i]["mrp"])} off",
                                                                            style: const TextStyle(
                                                                                color: Color(0xFF33B555),
                                                                                fontWeight: FontWeight.normal,
                                                                                fontSize: 17)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0,
                                                                        top:
                                                                            12),
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      decoration: const BoxDecoration(
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          color:
                                                                              Color(0xFFFFD207)),
                                                                      child:
                                                                          const Padding(
                                                                        padding:
                                                                            EdgeInsets.all(4.0),
                                                                        child: Icon(
                                                                            Icons
                                                                                .flash_on,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                    const Center(
                                                                        child: Text(
                                                                            "Fastest delivery",
                                                                            // "Today in ${getDeliveryTime(provider.discoverNewList[i]["distance"])}",
                                                                            style: TextStyle(
                                                                                fontSize: 17,
                                                                                fontWeight: FontWeight.normal,
                                                                                color: Color(0xFF545454)))),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      )
                                                    : Shimmer.fromColors(
                                                        baseColor:
                                                            Colors.black12,
                                                        highlightColor:
                                                            Colors.white,
                                                        child:
                                                            SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          200,
                                                                      height:
                                                                          180,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Container(
                                                                        width:
                                                                            80,
                                                                        height:
                                                                            12,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Container(
                                                                        width:
                                                                            150,
                                                                        height:
                                                                            12,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Container(
                                                                        width:
                                                                            150,
                                                                        height:
                                                                            12,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          200,
                                                                      height:
                                                                          180,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Container(
                                                                        width:
                                                                            200,
                                                                        height:
                                                                            12,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Container(
                                                                        width:
                                                                            150,
                                                                        height:
                                                                            12,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Container(
                                                                        width:
                                                                            150,
                                                                        height:
                                                                            12,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          200,
                                                                      height:
                                                                          180,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Container(
                                                                        width:
                                                                            200,
                                                                        height:
                                                                            12,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Container(
                                                                        width:
                                                                            150,
                                                                        height:
                                                                            12,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Container(
                                                                        width:
                                                                            150,
                                                                        height:
                                                                            12,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ));
                                              }))
                                    ],
                                  )),

// -------------

                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 8, top: 30, bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Bestsellers",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text("Most popular products near you!",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                        )),
                                  ],
                                ),
                              ),

                              //here is the chicken code

// end ----------

                              const Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text("Chicken",
                                    style: TextStyle(
                                        fontFamily: "head", fontSize: 21)),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 370,
                                  child: StreamBuilder<bool>(
                                      stream: provider.isCourseLoaded.stream,
                                      builder: (context, snapshot) {
                                        return snapshot.data != null &&
                                                snapshot.data == true
                                            ? ListView.builder(
                                                controller:
                                                    provider.trendingController,
                                                physics: const ScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: provider
                                                    .trendingProductExclusiveList
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int i) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      InkWell(
                                                        onTap: () async {
                                                          Navigator.pushNamed(
                                                              context,
                                                              TfRoutes
                                                                  .productDetailsPage,
                                                              arguments: provider
                                                                  .trendingProductExclusiveList[i]);
                                                        },
                                                        child: Stack(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: SizedBox(
                                                                width: 200,
                                                                height: 180,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              10.0)),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            AspectRatio(
                                                                      aspectRatio:
                                                                          1.6,
                                                                      child: BlurHash(
                                                                          hash: provider.trendingProductExclusiveList[i]["blurhashThumb"] ??
                                                                              'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                                                                    ),
                                                                    imageUrl:
                                                                        "${provider.trendingProductExclusiveList[i]["low_qty"]}&quality=0.5",
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        const Icon(
                                                                            Icons.error),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                                bottom: 4,
                                                                right: 4,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    provider.addToCart(
                                                                        provider.trendingProductExclusiveList[
                                                                            i],
                                                                        provider.trendingProductExclusiveList[i]["specifications"]["Quantity"]
                                                                            [
                                                                            0]);
                                                                  },
                                                                  child:
                                                                      const Card(
                                                                    child: Icon(
                                                                        Icons
                                                                            .add,
                                                                        size:
                                                                            32),
                                                                  ),
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0,
                                                                top: 8),
                                                        child: SizedBox(
                                                          width: 200,
                                                          child: Text(
                                                            snapshot.data !=
                                                                        null &&
                                                                    snapshot.data ==
                                                                        true
                                                                ? provider
                                                                        .trendingProductExclusiveList[
                                                                    i]["name"]
                                                                : "Please wait..",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                fontSize: 19,
                                                                fontFamily:
                                                                    "bree",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black),
                                                            softWrap: true,
                                                            maxLines: 3,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 10,
                                                                left: 8.0),
                                                        child: Text(
                                                            snapshot.data ==
                                                                    true
                                                                ? getFirstQty(provider
                                                                        .trendingProductExclusiveList[i]
                                                                    [
                                                                    "quantity"])
                                                                // provider
                                                                //         .trendingProductExclusiveList[
                                                                //     i]["specifications"]
                                                                // .first
                                                                // .first
                                                                : "Please wait..",
                                                            //"₹ 1202",
                                                            style: const TextStyle(
                                                                fontSize: 17,
                                                                fontFamily:
                                                                    "bree",
                                                                color: Color(
                                                                    0xFF2E2E2E))),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 10,
                                                                left: 8.0),
                                                        child: SizedBox(
                                                          width: 200,
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                    snapshot
                                                                                .data ==
                                                                            true
                                                                        ? "\u20B9 ${stringToMoney(provider.trendingProductExclusiveList[i]["selling_price"])}"
                                                                        : "Please wait..",
                                                                    //"₹ 1202",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontFamily:
                                                                            "bree",
                                                                        color: Color(
                                                                            0xFF2E2E2E))),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                    snapshot
                                                                                .data ==
                                                                            true
                                                                        ? "\u20B9 ${stringToMoney(provider.trendingProductExclusiveList[i]["mrp"])}"
                                                                        : "Please wait..",
                                                                    //"₹ 1202",

                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        decoration:
                                                                            TextDecoration
                                                                                .lineThrough,
                                                                        fontFamily:
                                                                            "bree",
                                                                        color: Color(
                                                                            0xFF9E9E9E))),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                    "${getDiscountOffer(provider.trendingProductExclusiveList[i]["selling_price"], provider.trendingProductExclusiveList[i]["mrp"])} off",
                                                                    style: const TextStyle(
                                                                        color: Color(
                                                                            0xFF33B555),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        fontSize:
                                                                            17)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0,
                                                                top: 12),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              decoration: const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Color(
                                                                      0xFFFFD207)),
                                                              child:
                                                                  const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            4.0),
                                                                child: Icon(
                                                                    Icons
                                                                        .flash_on,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                            const Center(
                                                                child: Text(
                                                                    "Fastest delivery",
                                                                    // "Today in ${getDeliveryTime(provider.trendingProductExclusiveList[i]["distance"])}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        color: Color(
                                                                            0xFF545454)))),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              )
                                            : Shimmer.fromColors(
                                                baseColor: Colors.black12,
                                                highlightColor: Colors.white,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              width: 200,
                                                              height: 180,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 80,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 150,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 150,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              width: 200,
                                                              height: 180,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 200,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 150,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 150,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              width: 200,
                                                              height: 180,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 200,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 150,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 150,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                      })),

// end ----------

                              const Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text("Sea food",
                                    style: TextStyle(
                                        fontFamily: "head", fontSize: 21)),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 370,
                                  child: StreamBuilder<bool>(
                                      stream: provider.isCourseLoaded2.stream,
                                      builder: (context, snapshot) {
                                        return snapshot.data != null &&
                                                snapshot.data == true
                                            ? ListView.builder(
                                                // controller: provider.trendingController,
                                                physics: const ScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: provider
                                                    .trendingProductExclusiveList2
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int i) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      InkWell(
                                                        onTap: () async {
                                                          Navigator.pushNamed(
                                                              context,
                                                              TfRoutes
                                                                  .productDetailsPage,
                                                              arguments: provider
                                                                  .trendingProductExclusiveList2[i]);
                                                        },
                                                        child: Stack(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: SizedBox(
                                                                width: 200,
                                                                height: 180,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              10.0)),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            AspectRatio(
                                                                      aspectRatio:
                                                                          1.6,
                                                                      child: BlurHash(
                                                                          hash: provider.trendingProductExclusiveList2[i]["blurhashThumb"] ??
                                                                              'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                                                                    ),
                                                                    imageUrl:
                                                                        "${provider.trendingProductExclusiveList2[i]["low_qty"]}&quality=0.5",
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        const Icon(
                                                                            Icons.error),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                                bottom: 4,
                                                                right: 4,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    provider.addToCart(
                                                                        provider.trendingProductExclusiveList2[
                                                                            i],
                                                                        provider.trendingProductExclusiveList2[i]["specifications"]["Quantity"]
                                                                            [
                                                                            0]);
                                                                  },
                                                                  child:
                                                                      const Card(
                                                                    child: Icon(
                                                                        Icons
                                                                            .add,
                                                                        size:
                                                                            32),
                                                                  ),
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0,
                                                                top: 8),
                                                        child: SizedBox(
                                                          width: 200,
                                                          child: Text(
                                                            snapshot.data !=
                                                                        null &&
                                                                    snapshot.data ==
                                                                        true
                                                                ? provider
                                                                        .trendingProductExclusiveList2[
                                                                    i]["name"]
                                                                : "Please wait..",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                fontSize: 19,
                                                                fontFamily:
                                                                    "bree",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black),
                                                            softWrap: true,
                                                            maxLines: 3,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 10,
                                                                left: 8.0),
                                                        child: Text(
                                                            snapshot.data ==
                                                                    true
                                                                ? getFirstQty(provider
                                                                        .trendingProductExclusiveList2[i]
                                                                    [
                                                                    "quantity"])
                                                                // provider
                                                                //         .trendingProductExclusiveList[
                                                                //     i]["specifications"]
                                                                // .first
                                                                // .first
                                                                : "Please wait..",
                                                            //"₹ 1202",
                                                            style: const TextStyle(
                                                                fontSize: 17,
                                                                fontFamily:
                                                                    "bree",
                                                                color: Color(
                                                                    0xFF2E2E2E))),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 10,
                                                                left: 8.0),
                                                        child: SizedBox(
                                                          width: 200,
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                    snapshot
                                                                                .data ==
                                                                            true
                                                                        ? "\u20B9 ${stringToMoney(provider.trendingProductExclusiveList2[i]["selling_price"])}"
                                                                        : "Please wait..",
                                                                    //"₹ 1202",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontFamily:
                                                                            "bree",
                                                                        color: Color(
                                                                            0xFF2E2E2E))),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                    snapshot
                                                                                .data ==
                                                                            true
                                                                        ? "\u20B9 ${stringToMoney(provider.trendingProductExclusiveList2[i]["mrp"])}"
                                                                        : "Please wait..",
                                                                    //"₹ 1202",

                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        decoration:
                                                                            TextDecoration
                                                                                .lineThrough,
                                                                        fontFamily:
                                                                            "bree",
                                                                        color: Color(
                                                                            0xFF9E9E9E))),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                    "${getDiscountOffer(provider.trendingProductExclusiveList2[i]["selling_price"], provider.trendingProductExclusiveList2[i]["mrp"])} off",
                                                                    style: const TextStyle(
                                                                        color: Color(
                                                                            0xFF33B555),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        fontSize:
                                                                            18)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0,
                                                                top: 12),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              decoration: const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Color(
                                                                      0xFFFFD207)),
                                                              child:
                                                                  const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            4.0),
                                                                child: Icon(
                                                                    Icons
                                                                        .flash_on,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                            const Center(
                                                                child: Text(
                                                                    "Fastest delivery",
                                                                    // "Today in ${getDeliveryTime(provider.trendingProductExclusiveList2[i]["distance"])}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        color: Color(
                                                                            0xFF545454)))),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              )
                                            : Shimmer.fromColors(
                                                baseColor: Colors.black12,
                                                highlightColor: Colors.white,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              width: 200,
                                                              height: 180,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 80,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 150,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 150,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              width: 200,
                                                              height: 180,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 200,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 150,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 150,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              width: 200,
                                                              height: 180,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 200,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 150,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 150,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                      })),

                              //here is the mutton code

// end ----------

                              const Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text("Mutton",
                                    style: TextStyle(
                                        fontFamily: "head", fontSize: 21)),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 370,
                                  child: StreamBuilder<bool>(
                                      stream: provider.isCourseLoaded1.stream,
                                      builder: (context, snapshot) {
                                        return snapshot.data != null &&
                                                snapshot.data == true
                                            ? ListView.builder(
                                                // controller: provider.trendingController,
                                                physics: const ScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: provider
                                                    .trendingProductExclusiveList1
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int i) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      InkWell(
                                                        onTap: () async {
                                                          Navigator.pushNamed(
                                                              context,
                                                              TfRoutes
                                                                  .productDetailsPage,
                                                              arguments: provider
                                                                  .trendingProductExclusiveList1[i]);
                                                        },
                                                        child: Stack(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: SizedBox(
                                                                width: 200,
                                                                height: 180,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              10.0)),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            AspectRatio(
                                                                      aspectRatio:
                                                                          1.6,
                                                                      child: BlurHash(
                                                                          hash: provider.trendingProductExclusiveList1[i]["blurhashThumb"] ??
                                                                              'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                                                                    ),
                                                                    imageUrl:
                                                                        "${provider.trendingProductExclusiveList1[i]["low_qty"]}&quality=0.5",
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        const Icon(
                                                                            Icons.error),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                                bottom: 4,
                                                                right: 4,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    provider.addToCart(
                                                                        provider.trendingProductExclusiveList1[
                                                                            i],
                                                                        provider.trendingProductExclusiveList1[i]["specifications"]["Quantity"]
                                                                            [
                                                                            0]);
                                                                  },
                                                                  child:
                                                                      const Card(
                                                                    child: Icon(
                                                                        Icons
                                                                            .add,
                                                                        size:
                                                                            32),
                                                                  ),
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0,
                                                                top: 8),
                                                        child: SizedBox(
                                                          width: 200,
                                                          child: Text(
                                                            snapshot.data !=
                                                                        null &&
                                                                    snapshot.data ==
                                                                        true
                                                                ? provider
                                                                        .trendingProductExclusiveList1[
                                                                    i]["name"]
                                                                : "Please wait..",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                fontSize: 19,
                                                                fontFamily:
                                                                    "bree",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black),
                                                            softWrap: true,
                                                            maxLines: 3,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 10,
                                                                left: 8.0),
                                                        child: Text(
                                                            snapshot.data ==
                                                                    true
                                                                ? getFirstQty(provider
                                                                        .trendingProductExclusiveList1[i]
                                                                    [
                                                                    "quantity"])
                                                                // provider
                                                                //         .trendingProductExclusiveList[
                                                                //     i]["specifications"]
                                                                // .first
                                                                // .first
                                                                : "Please wait..",
                                                            //"₹ 1202",
                                                            style: const TextStyle(
                                                                fontSize: 17,
                                                                fontFamily:
                                                                    "bree",
                                                                color: Color(
                                                                    0xFF2E2E2E))),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 10,
                                                                left: 8.0),
                                                        child: SizedBox(
                                                          width: 200,
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                    snapshot
                                                                                .data ==
                                                                            true
                                                                        ? "\u20B9 ${stringToMoney(provider.trendingProductExclusiveList1[i]["selling_price"])}"
                                                                        : "Please wait..",
                                                                    //"₹ 1202",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontFamily:
                                                                            "bree",
                                                                        color: Color(
                                                                            0xFF2E2E2E))),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                    snapshot
                                                                                .data ==
                                                                            true
                                                                        ? "\u20B9 ${stringToMoney(provider.trendingProductExclusiveList1[i]["mrp"])}"
                                                                        : "Please wait..",
                                                                    //"₹ 1202",

                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        decoration:
                                                                            TextDecoration
                                                                                .lineThrough,
                                                                        fontFamily:
                                                                            "bree",
                                                                        color: Color(
                                                                            0xFF9E9E9E))),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                    "${getDiscountOffer(provider.trendingProductExclusiveList1[i]["selling_price"], provider.trendingProductExclusiveList1[i]["mrp"])} off",
                                                                    style: const TextStyle(
                                                                        color: Color(
                                                                            0xFF33B555),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        fontSize:
                                                                            17)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0,
                                                                top: 12),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              decoration: const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Color(
                                                                      0xFFFFD207)),
                                                              child:
                                                                  const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            4.0),
                                                                child: Icon(
                                                                    Icons
                                                                        .flash_on,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                            const Center(
                                                                child: Text(
                                                                    "Fastest delivery",
                                                                    // "Today in ${getDeliveryTime(provider.trendingProductExclusiveList1[i]["distance"])}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        color: Color(
                                                                            0xFF545454)))),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              )
                                            : Shimmer.fromColors(
                                                baseColor: Colors.black12,
                                                highlightColor: Colors.white,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              width: 200,
                                                              height: 180,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 80,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 150,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 150,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              width: 200,
                                                              height: 180,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 200,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 150,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 150,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              width: 200,
                                                              height: 180,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 200,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 150,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                width: 150,
                                                                height: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                      })),

                              //here is the mutton code

                              Container(
                                  padding: const EdgeInsets.all(30),
                                  color: const Color(0xFF282828),
                                  width: MediaQuery.of(context).size.width,
                                  height: 500,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("QUICK LINKS",
                                            style: TextStyle(
                                                fontSize: 21,
                                                color: Colors.white)),
                                        Link(
                                          uri: Uri.parse(
                                              'https://pureone.in/about_us/'),
                                          target: LinkTarget.blank,
                                          builder: (BuildContext ctx,
                                              FollowLink? openLink) {
                                            return TextButton.icon(
                                              onPressed: openLink,
                                              label: const Text('About us'),
                                              icon: const Icon(Icons.read_more),
                                            );
                                          },
                                        ),
                                        Link(
                                          uri: Uri.parse(
                                              'https://pureone.in/privacy/'),
                                          target: LinkTarget.blank,
                                          builder: (BuildContext ctx,
                                              FollowLink? openLink) {
                                            return TextButton.icon(
                                              onPressed: openLink,
                                              label:
                                                  const Text('Privacy policy'),
                                              icon: const Icon(Icons.read_more),
                                            );
                                          },
                                        ),
                                        Link(
                                          uri: Uri.parse(
                                              'https://pureone.in/cancellation/'),
                                          target: LinkTarget.blank,
                                          builder: (BuildContext ctx,
                                              FollowLink? openLink) {
                                            return TextButton.icon(
                                              onPressed: openLink,
                                              label: const Text(
                                                  'Cancellation policy'),
                                              icon: const Icon(Icons.read_more),
                                            );
                                          },
                                        ),
                                        Link(
                                          uri: Uri.parse(
                                              'https://pureone.in/shipping/'),
                                          target: LinkTarget.blank,
                                          builder: (BuildContext ctx,
                                              FollowLink? openLink) {
                                            return TextButton.icon(
                                              onPressed: openLink,
                                              label: const Text('Shipping'),
                                              icon: const Icon(Icons.read_more),
                                            );
                                          },
                                        ),
                                        Link(
                                          uri: Uri.parse(
                                              'https://pureone.in/terms/'),
                                          target: LinkTarget.blank,
                                          builder: (BuildContext ctx,
                                              FollowLink? openLink) {
                                            return TextButton.icon(
                                              onPressed: openLink,
                                              label: const Text(
                                                  'Terms and Conditions'),
                                              icon: const Icon(Icons.read_more),
                                            );
                                          },
                                        ),
                                        Link(
                                          uri: Uri.parse(
                                              'https://pureone.in/contact/'),
                                          target: LinkTarget.blank,
                                          builder: (BuildContext ctx,
                                              FollowLink? openLink) {
                                            return TextButton.icon(
                                              onPressed: openLink,
                                              label: const Text(
                                                  'Returns and Refunds'),
                                              icon: const Icon(Icons.read_more),
                                            );
                                          },
                                        ),
                                        Link(
                                          uri: Uri.parse(
                                              'https://pureone.in/contact/'),
                                          target: LinkTarget.blank,
                                          builder: (BuildContext ctx,
                                              FollowLink? openLink) {
                                            return TextButton.icon(
                                              onPressed: openLink,
                                              label: const Text('Contact'),
                                              icon: const Icon(Icons.read_more),
                                            );
                                          },
                                        ),
                                        Link(
                                          uri: Uri.parse(
                                              'https://pureone.in/app/app_images/fssai.pdf'),
                                          target: LinkTarget.blank,
                                          builder: (BuildContext ctx,
                                              FollowLink? openLink) {
                                            return TextButton.icon(
                                              onPressed: openLink,
                                              label: const Text(
                                                  'FSSAI Certificate'),
                                              icon: const Icon(Icons.read_more),
                                            );
                                          },
                                        ),
                                      ])),
                            ])
                      : Column(
                          children: [
                            Image.asset("images/delivery_boy.jpg"),
                            Text("We Don't delivery in your location",
                                style: TextStyle(
                                  fontSize: 21,
                                ))
                          ],
                        );
                  // Container(
                  //     width: MediaQuery.of(context).size.width - 30,
                  //     decoration: const BoxDecoration(
                  //         image: DecorationImage(
                  //             image:
                  //                 AssetImage("images/delivery_boy.jpg"))));
                }),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: StreamBuilder<bool>(
          stream: provider.notifyBadge.stream,
          builder: (context, snapshot) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, TfRoutes.cart).then((value) {
                  provider.allBadgeCount();
                });
              },
              child: Container(
                color: Colors.white,
                height: snapshot.hasData && snapshot.data == true ? 115 : 68,
                child: Column(
                  children: [
                    Visibility(
                      visible: snapshot.hasData && snapshot.data == true
                          ? true
                          : false,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          child: Container(
                              width: MediaQuery.of(context).size.width - 28,
                              height: 46,
                              color: Colors.black,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListTile(
                                      visualDensity: const VisualDensity(
                                          horizontal: 0, vertical: -4),
                                      leading: Text(
                                          "${provider.numberOfItemsInCart} Item | \u20B9  ${provider.totalAmountForCart}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)),
                                      trailing: const SizedBox(
                                        width: 105,
                                        child: Row(
                                          children: [
                                            Text("View Cart",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16)),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
                                              child: Icon(Icons.arrow_forward,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      )),
                                ],
                              ))),
                    ),
                    const SizedBox(height: 1),
                    BottomNavigationBar(
                        backgroundColor: Colors.white,
                        onTap: (value) {
                          // print(value);

                          if (value == 0) {
                            // Navigator.pushNamed(context, TfRoutes.policy);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PrivacyPolicy()));

                            // Navigator.push
                          } else if (value == 1) {
                            Navigator.pushNamed(context, TfRoutes.trackProduct);
                          } else if (value == 2) {
                            Navigator.pushNamed(context, TfRoutes.cart);
                          } else if (value == 3) {
                            Navigator.pushNamed(context, TfRoutes.trackProduct);
                          }
                        },
                        items: const [
                          BottomNavigationBarItem(
                              icon: Icon(Icons.perm_identity,
                                  size: 30, color: Color(0xFF000000)),
                              label: ""),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.location_on_outlined,
                                  size: 30, color: Color(0xFF000000)),
                              label: ""),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.shopping_cart_outlined,
                                  size: 30, color: Color(0xFF000000)),
                              label: ""),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.local_mall_outlined,
                                  size: 30, color: Color(0xFF000000)),
                              label: ""),
                        ]),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
