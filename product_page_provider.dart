import 'dart:async';
import 'dart:convert';
import 'dart:convert' as json;
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:pureone/helpers/image_sliptter.dart';
import 'package:pureone/helpers/open_street_map_search.dart';

import 'package:pureone/routes/tf_routes.dart'; // here is the create for ios
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pureone/helpers/locationService.dart';

class ProductPageProvider extends ChangeNotifier {
  Future<SharedPreferences> sPrefs = SharedPreferences.getInstance();
  late BuildContext context;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // final GlobalKey<ScaffoldState> scrollView = new GlobalKey<ScaffoldState>();
  // final GlobalKey<ScaffoldState> categoryKey = new GlobalKey<ScaffoldState>();
  StreamController<List<Widget>> sliderLoaded = StreamController.broadcast();

  StreamController<bool> isShowFooter = StreamController.broadcast();
  StreamController<bool> addressUpdate = StreamController.broadcast();
  StreamController<bool> addressStream = StreamController.broadcast();
  final LocationService locationService = LocationService();

  late Connectivity connectivity;
  ScrollController dashboardScroll = ScrollController();

  String? deliveryAddress;

  int maxLoad = 0;

  ScrollController discoverScrollController = ScrollController();

  StreamController<bool> notifyBadge = StreamController.broadcast();

  StreamController<bool> weDontDeliveryHereStream =
      StreamController.broadcast();
  String myBuyBadgeString = "";
  String myCartBadgeString = "";
  String myTrackBadgeString = "";
  String myNotifyBadgeString = "";

  String numberOfItemsInCart = "0";
  String totalAmountForCart = "0";

  bool enableLocation = false;

  bool isScrolled = false;

  bool discoverNewCalled = false;

  List imageCompressed = [];
  var connectionStatus = 'Unknown';
  final GlobalKey<ScaffoldState> strcategoryKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> listCategoryKey = GlobalKey<ScaffoldState>();
  List<String> thumbnail = [];
  final GlobalKey tabKey = GlobalKey();

  bool isShowingDialogue = false;
  Timer? timer;

  List<Map<String, dynamic>> courseList = [];
  List<Map<String, dynamic>> offersList = [];
  List<Map<String, dynamic>> trendingProductExclusiveList = [];
  List<Map<String, dynamic>> trendingProductExclusiveList1 = [];
  List<Map<String, dynamic>> trendingProductExclusiveList2 = [];

  List<Map<String, dynamic>> offerProductExclusiveList = [];
  List<Map<String, dynamic>>? posterList = [];
  List<String> productImage = [];

  // loc.Location location = loc.Location();

  var currentLat = 0.0;
  var currentLng = 0.0;

  // final databaseReference =
  //     FirebaseDatabase.instance.ref().child("androidVersionControl");

  ScrollController trendingController = ScrollController();
  ScrollController offerController = ScrollController();
  StreamController<bool> posterStreamController =
      StreamController<bool>.broadcast();
  StreamController lowQualityImageStream = StreamController.broadcast();

  // double heightOfGrid = 0;
  // StreamController<double> heightOfGridStreamController = StreamController();

  StreamController<bool> isCourseLoaded = StreamController<bool>.broadcast();
  StreamController<bool> isCourseLoaded1 = StreamController<bool>.broadcast();
  StreamController<bool> isCourseLoaded2 = StreamController<bool>.broadcast();
  StreamController<bool> isOffersLoaded = StreamController<bool>.broadcast();
  StreamController<bool> isCategoryIconsLoaded =
      StreamController<bool>.broadcast();

  List iconSpeical = [];
  StreamController<bool> iconSpecialStream = StreamController.broadcast();

  List<String> sliderImages = <String>[];
  List<String> sliderLabel = <String>[];

  List categoryIconList = [];
  List<Widget> categoryIconsWidget = [];

  StreamController<bool> imagesLoadedForSliderStreamController =
      StreamController.broadcast();
  List<Map<String, dynamic>> discoverNewList = [];

  StreamController<bool> discoverNewLoadedStream = StreamController.broadcast();
  StreamController<bool> latlng = StreamController.broadcast();

  bool calledDiscoverNew = false;

  ProductPageProvider() {
    getAddress();
    allBadgeCount();
    getSlider();
    getCategoryIcons();
    loadAllCacheData();
    // getDiscoverNewProducts();
    // getLocationAndSaveIt();

    isShowFooter.add(true);
    //   if (!kIsWeb) {
    //
    //
    //   dashboardScroll.addListener(() {
    //     allBadgeCount();
    //
    //     if (dashboardScroll.position.pixels ==
    //         dashboardScroll.position.maxScrollExtent) {
    //       // isLoadMore.add(true);
    //
    //
    //       Future.delayed(const Duration(milliseconds: 500), () async {
    //         await getTrendingProducts("0");
    //         maxLoad++;
    //       });
    //     }
    //
    //     // if (dashobardScroll.position.pixels ==
    //     //     dashobardScroll.position.maxScrollExtent) {
    //     //   // reached to end
    //     //   // getTrendingProducts(getTrendingProducts(
    //     //   //     trendingProductExclusiveList[
    //     //   //         trendingProductExclusiveList.length - 1]["id"]));
    //     // }
    //   });
    // }else {
    //
    //     isShowFooter.add(true);
    //     // show footer here
    //
    //   }
    //     offerController.addListener(() {
    //       if (offerController.position.pixels ==
    //           offerController.position.maxScrollExtent) {
    //         // reached to end
    //         getOffers(
    //             offerProductExclusiveList[offerProductExclusiveList.length - 1]
    //                 ["id"]);
    //       }
    //     });
    //   } else {
    //     ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
    //         const SnackBar(content: Text("Please enable internet connection")));
    //   }
    // });

    if (!kIsWeb) {
      // location.onLocationChanged.listen((loc.LocationData currentLocation) {
      //   // Use current location
      //   currentLat = currentLocation.latitude!;
      //   currentLng = currentLocation.longitude!;
      //   if (!latlng.isClosed) {
      //     latlng.add(true);
      //   }
      // });
      // saveTocken();
    }
    // _showMyDialog();

    // callDiscoverNew();
  }

  Future<void> callDiscoverNew() async {
    await Future.delayed(const Duration(milliseconds: 2000), () async {
      if (!calledDiscoverNew) {
        // getLatLangFromCache().then((value) async {
        //   currentLat = value["latitude"];
        //   currentLng = value["longitude"];
        await getDiscoverProducts();
        //   if (!latlng.isClosed) {
        //     latlng.add(true);
        //   }
        // });
      }
    });
  }

  navigate(categ) {
    Navigator.pushNamed(context, TfRoutes.viewAllProducts,
        arguments: jsonEncode(<String, String>{
          'lat': "$currentLat",
          'long': "$currentLng",
          'category': "$categ"
        }));
  }

  navigateToCategoryIcons(categ) {
    Navigator.pushNamed(context, TfRoutes.viewAllProductsByCategoryIcons,
        arguments: jsonEncode(<String, String>{
          'lat': "$currentLat",
          'long': "$currentLng",
          'category': "$categ"
        }));
  }

  Future<void> saveUserLocation(lat, long) async {
    final SharedPreferences prefs = await sPrefs;

    prefs.setString("currentUserLat", "$lat");
    prefs.setString("currentUserLong", "$long");

    loadAllCacheData();
  }

  Future<void> saveSlider(data) async {
    final SharedPreferences prefs = await sPrefs;

    prefs.setString("slider", data);
  }

  Future<void> saveSpecialIcons(data) async {
    final SharedPreferences prefs = await sPrefs;

    prefs.setString("speicalIcons", data);
  }

  // Future<Position> getLatLang1() async {
  //   try {
  //     bool serviceEnabled;
  //     loc.PermissionStatus permissionGranted;
  //     loc.LocationData locationData;

  //     serviceEnabled = await location.serviceEnabled();
  //     if (!serviceEnabled) {
  //       serviceEnabled = await location.requestService();
  //       if (!serviceEnabled) {
  //         if (!isShowingDialogue) {
  //           // _showDialog(scaffoldKey.currentContext!, "app");
  //         }

  //         return Position(
  //             longitude: 0,
  //             latitude: 0,
  //             timestamp: DateTime.now(),
  //             accuracy: 0,
  //             altitude: 0,
  //             heading: 0,
  //             speed: 0,
  //             speedAccuracy: 0);
  //       }
  //     }

  //     permissionGranted = await location.hasPermission();
  //     if (permissionGranted == loc.PermissionStatus.denied) {
  //       permissionGranted = await location.requestPermission();
  //       if (permissionGranted != loc.PermissionStatus.granted) {
  //         return Future.error("error");
  //       }
  //     } else {
  //       permissionGranted = await location.requestPermission();

  //       if (permissionGranted != loc.PermissionStatus.granted) {
  //         if (!isShowingDialogue) {
  //           // _showDialog(scaffoldKey.currentContext!, "location");
  //         }
  //         return Position(
  //             longitude: 0,
  //             latitude: 0,
  //             timestamp: DateTime.now(),
  //             accuracy: 0,
  //             altitude: 0,
  //             heading: 0,
  //             speed: 0,
  //             speedAccuracy: 0);
  //       } else {}
  //     }

  //     locationData = await location.getLocation();

  //     // print(_locationData);
  //     currentLat = locationData.latitude!;
  //     currentLng = locationData.longitude!;
  //     // ScaffoldMessenger.of(scaffoldKey.currentContext!)
  //     //     .showSnackBar(SnackBar(content: Text("$currentLat $currentLng")));

  //     // print("lat:$currentLat lng: $currentLng");

  //     return Position(
  //         longitude: locationData.longitude!,
  //         latitude: locationData.latitude!,
  //         timestamp: DateTime.now(),
  //         accuracy: locationData.accuracy!,
  //         altitude: locationData.altitude!,
  //         heading: locationData.heading!,
  //         speed: locationData.speed!,
  //         speedAccuracy: locationData.speedAccuracy!);
  //     // print("lat : $currentLat long : $currentLng ");
  //   } catch (e) {
  //     return Position(
  //         longitude: currentLng,
  //         latitude: currentLat,
  //         timestamp: DateTime.now(),
  //         accuracy: 0,
  //         altitude: 0,
  //         heading: 0,
  //         speed: 0,
  //         speedAccuracy: 0);
  //     // print(e);
  //   }
  // }

  // Future<bool> getLatLang() async {
  //   try {
  //     bool _serviceEnabled;
  //     PermissionStatus _permissionGranted;
  //     LocationData _locationData;

  //     _serviceEnabled = await location.serviceEnabled();
  //     if (!_serviceEnabled) {
  //       _serviceEnabled = await location.requestService();
  //       if (!_serviceEnabled) {
  //         if (!isShowingDialogue) {
  //           showLocationImageDialog(scaffoldKey.currentContext!, "app");
  //         }

  //         return false;
  //       }
  //     }

  //     _permissionGranted = await location.hasPermission();
  //     if (_permissionGranted == PermissionStatus.denied) {
  //       _permissionGranted = await location.requestPermission();
  //       if (_permissionGranted != PermissionStatus.granted) {
  //         return false;
  //       }
  //     } else {
  //       _permissionGranted = await location.requestPermission();

  //       if (_permissionGranted != PermissionStatus.granted) {
  //         if (!isShowingDialogue) {
  //           showLocationImageDialog(scaffoldKey.currentContext!, "location");
  //         }
  //         return false;
  //       } else {}
  //     }

  //     _locationData = await location.getLocation();

  //     // print(_locationData);
  //     currentLat = _locationData.latitude!;
  //     currentLng = _locationData.longitude!;
  //     // ScaffoldMessenger.of(scaffoldKey.currentContext!)
  //     //     .showSnackBar(SnackBar(content: Text("$currentLat $currentLng")));

  //     // print("lat:$currentLat lng: $currentLng");

  //     getDiscoverProducts();
  //     if (!latlng.isClosed) {
  //       latlng.add(true);
  //     }
  //     return true;
  //     // print("lat : $currentLat long : $currentLng ");
  //   } catch (e) {
  //     return false;
  //     // print(e);
  //   }
  // }

  // Future<String> getAddress() async {
  //   final SharedPreferences prefs = await sPrefs;

  //   return prefs.getString("currentUserAddress") ?? "Add delivery address.";
  // }

  int maxId = 0;
  //
  // getTrendingProducts(index) async {
  //   try {
  //     final http.Response response = await http
  //         .post(
  //       Uri.parse('https://pureone.in/app/api_demo/trending_products.php'),
  //       body: jsonEncode(<String, String>{
  //         'last_row_id': "$maxId",
  //         'lat': "$currentLat",
  //         'long': "$currentLng",
  //         "category": "trending"
  //       }),
  //     )
  //         .catchError((e) {
  //       // ScaffoldMessenger.of(scaffoldKey.currentContext!)
  //       //     .showSnackBar(SnackBar(content: Text(e.toString())));
  //     });
  //
  //     if (response.statusCode == 200) {
  //       var jsonResponse = json.jsonDecode(response.body);
  //       // trendingProductExclusiveList.clear();
  //
  //       saveProduct(response.body);
  //       var videoJson = jsonResponse['products'];
  //
  //       // courseList.clear();
  //       videoJson.forEach((video) {
  //         // heightOfGrid++;
  //
  //         maxId = int.parse(video["id"]);
  //
  //         courseList.add(video);
  //
  //         // if (!isCourseLoaded.isClosed) {
  //         //   isCourseLoaded.add(true);
  //         // }
  //       });
  //       videoJson.forEach((video) {
  //         if (maxId > int.parse(video["id"])) {
  //           maxId = int.parse(video["id"]);
  //         }
  //       });
  //       List colorArray = [];
  //
  //       videoJson.forEach((video) {
  //         if (video["specifications"]["color"] != null &&
  //             video["specifications"]["color"].length > 0) {
  //           colorArray.add(video["specifications"]["color"]);
  //         } else {
  //           colorArray.add(["images"]);
  //         }
  //       });
  //
  //       for (int i = 0; i < colorArray.length; i++) {
  //         if (videoJson[i]["product_images"][colorArray[i].first] != null &&
  //             videoJson[i]["product_images"][colorArray[i].first].length > 0) {
  //           videoJson[i]["thumbnail"] =
  //               videoJson[i]["product_images"][colorArray[i].first].first;
  //
  //           // getLowQualityImgae(videoJson[i]["thumbnail"], i);
  //           videoJson[i]["blurhashThumb"] =
  //               videoJson[i]["blurhash"][colorArray[i].first].first;
  //
  //           videoJson[i]["low_qty"] = splitImage(videoJson[i]["thumbnail"]);
  //
  //           trendingProductExclusiveList.add(videoJson[i]);
  //         }
  //       }
  //
  //       if (!isCourseLoaded.isClosed) {
  //         // trendingProductExclusiveList.shuffle();
  //         isCourseLoaded.add(true);
  //       }
  //       // getPosters();
  //       // getSavedPosters();
  //     } else {
  //       // print('Request failed with status: ${response.statusCode}.');
  //     }
  //   } on SocketException {
  //     // print('No net');
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: const Text("Slow internet connection"),
  //         action: SnackBarAction(
  //             label: "Retry",
  //             onPressed: () {
  //               getLatLang().then((value) async {
  //                 currentLat = value.latitude;
  //                 currentLng = value.longitude;
  //
  //                 await getTrendingProducts(index);
  //               });
  //             })));
  //   } catch (e) {
  //     // print(e);
  //   }
  // }
// df

  getTrendingChickenProducts() async {
    try {
      final http.Response response = await http.post(
        Uri.parse(
            'https://pureone.in/app/api_demo/specific_products_from_icons_selection.php'),
        body: jsonEncode(<String, String>{
          'last_row_id': "$maxId",
          'lat': "$currentLat",
          'long': "$currentLng",
          "items_list": jsonEncode(["chicken"])
        }),
      );
      //     .catchError((e) {
      //   // ScaffoldMessenger.of(scaffoldKey.currentContext!)
      //   //     .showSnackBar(SnackBar(content: Text(e.toString())));
      // });

      if (response.statusCode == 200) {
        var jsonResponse = json.jsonDecode(response.body);
        // trendingProductExclusiveList.clear();

        saveProductChicken(response.body);
        var videoJson = jsonResponse['products'];

        // courseList.clear();
        videoJson.forEach((video) {
          // heightOfGrid++;

          maxId = int.parse(video["id"]);

          courseList.add(video);

          // if (!isCourseLoaded.isClosed) {
          //   isCourseLoaded.add(true);
          // }
        });
        videoJson.forEach((video) {
          if (maxId > int.parse(video["id"])) {
            maxId = int.parse(video["id"]);
          }
        });
        List colorArray = [];

        videoJson.forEach((video) {
          if (video["specifications"]["color"] != null &&
              video["specifications"]["color"].length > 0) {
            colorArray.add(video["specifications"]["color"]);
          } else {
            colorArray.add(["images"]);
          }
        });

        for (int i = 0; i < colorArray.length; i++) {
          if (videoJson[i]["product_images"][colorArray[i].first] != null &&
              videoJson[i]["product_images"][colorArray[i].first].length > 0) {
            videoJson[i]["thumbnail"] =
                videoJson[i]["product_images"][colorArray[i].first].first;

            // getLowQualityImgae(videoJson[i]["thumbnail"], i);
            videoJson[i]["blurhashThumb"] =
                videoJson[i]["blurhash"][colorArray[i].first].first;

            videoJson[i]["low_qty"] = splitImage(videoJson[i]["thumbnail"]);

            trendingProductExclusiveList.add(videoJson[i]);
          }
        }

        if (!isCourseLoaded.isClosed) {
          // trendingProductExclusiveList.shuffle();
          isCourseLoaded.add(true);
        }

        getTrendingMuttonProducts();
        // getPosters();
        // getSavedPosters();
      } else {
        // print('Request failed with status: ${response.statusCode}.');
      }

      //here is the mutton code
    } on SocketException {
      // print('No net');
      Future.delayed(const Duration(milliseconds: 300), () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Slow internet connection"),
            action: SnackBarAction(
                label: "Retry",
                onPressed: () async {
                  // getLatLangFromCache().then((value) async {
                  //   currentLat = value["latitude"];
                  //   currentLng = value["longitude"];

                  await getTrendingChickenProducts();
                  // });
                })));
      });
    } catch (e) {
      // print(e);
    }
  }

  getTrendingMuttonProducts() async {
    try {
      final http.Response response = await http.post(
        Uri.parse(
            'https://pureone.in/app/api_demo/specific_products_from_icons_selection.php'),
        body: jsonEncode(<String, String>{
          'last_row_id': "0",
          'lat': "$currentLat",
          'long': "$currentLng",
          "items_list": jsonEncode(["mutton"])
        }),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.jsonDecode(response.body);
        // trendingProductExclusiveList.clear();

        saveProduct(response.body);
        var videoJson = jsonResponse['products'];

        // courseList.clear();
        videoJson.forEach((video) {
          // heightOfGrid++;

          maxId = int.parse(video["id"]);

          courseList.add(video);

          // if (!isCourseLoaded.isClosed) {
          //   isCourseLoaded.add(true);
          // }
        });
        videoJson.forEach((video) {
          if (maxId > int.parse(video["id"])) {
            maxId = int.parse(video["id"]);
          }
        });
        List colorArray = [];

        videoJson.forEach((video) {
          if (video["specifications"]["color"] != null &&
              video["specifications"]["color"].length > 0) {
            colorArray.add(video["specifications"]["color"]);
          } else {
            colorArray.add(["images"]);
          }
        });

        for (int i = 0; i < colorArray.length; i++) {
          if (videoJson[i]["product_images"][colorArray[i].first] != null &&
              videoJson[i]["product_images"][colorArray[i].first].length > 0) {
            videoJson[i]["thumbnail"] =
                videoJson[i]["product_images"][colorArray[i].first].first;

            // getLowQualityImgae(videoJson[i]["thumbnail"], i);
            videoJson[i]["blurhashThumb"] =
                videoJson[i]["blurhash"][colorArray[i].first].first;

            videoJson[i]["low_qty"] = splitImage(videoJson[i]["thumbnail"]);

            trendingProductExclusiveList1.add(videoJson[i]);
          }
        }

        if (!isCourseLoaded1.isClosed) {
          // trendingProductExclusiveList.shuffle();
          isCourseLoaded1.add(true);
        }
        getTrendingSeaFoodProducts();
        // getPosters();
        // getSavedPosters();
      } else {
        // print('Request failed with status: ${response.statusCode}.');
      }

      //here is the mutton code
    } on SocketException {
      // print('No net');
      Future.delayed(const Duration(milliseconds: 300), () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Slow internet connection"),
            action: SnackBarAction(
                label: "Retry",
                onPressed: () async {
                  // getLatLangFromCache().then((value) async {
                  //   currentLat = value["latitude"];
                  //   currentLng = value["longitude"];

                  await getTrendingMuttonProducts();
                  // });
                })));
      });
    } catch (e) {
      // print(e);
    }
  }

  //here is the seafood

  getTrendingSeaFoodProducts() async {
    try {
      final http.Response response = await http.post(
        Uri.parse(
            'https://pureone.in/app/api_demo/specific_products_from_icons_selection.php'),
        body: jsonEncode(<String, String>{
          'last_row_id': "0",
          'lat': "$currentLat",
          'long': "$currentLng",
          "items_list": jsonEncode(["sea_food"])
        }),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.jsonDecode(response.body);
        // trendingProductExclusiveList.clear();

        saveProduct(response.body);
        var videoJson = jsonResponse['products'];

        // courseList.clear();
        videoJson.forEach((video) {
          // heightOfGrid++;

          maxId = int.parse(video["id"]);

          courseList.add(video);

          // if (!isCourseLoaded.isClosed) {
          //   isCourseLoaded.add(true);
          // }
        });
        videoJson.forEach((video) {
          if (maxId > int.parse(video["id"])) {
            maxId = int.parse(video["id"]);
          }
        });
        List colorArray = [];

        videoJson.forEach((video) {
          if (video["specifications"]["color"] != null &&
              video["specifications"]["color"].length > 0) {
            colorArray.add(video["specifications"]["color"]);
          } else {
            colorArray.add(["images"]);
          }
        });

        for (int i = 0; i < colorArray.length; i++) {
          if (videoJson[i]["product_images"][colorArray[i].first] != null &&
              videoJson[i]["product_images"][colorArray[i].first].length > 0) {
            videoJson[i]["thumbnail"] =
                videoJson[i]["product_images"][colorArray[i].first].first;

            // getLowQualityImgae(videoJson[i]["thumbnail"], i);
            videoJson[i]["blurhashThumb"] =
                videoJson[i]["blurhash"][colorArray[i].first].first;

            videoJson[i]["low_qty"] = splitImage(videoJson[i]["thumbnail"]);

            trendingProductExclusiveList2.add(videoJson[i]);
          }
        }

        if (!isCourseLoaded2.isClosed) {
          // trendingProductExclusiveList.shuffle();
          isCourseLoaded2.add(true);
        }
        // getPosters();
        // getSavedPosters();
      } else {
        // print('Request failed with status: ${response.statusCode}.');
      }

      //here is the mutton code
    } on SocketException {
      // print('No net');
      Future.delayed(const Duration(milliseconds: 300), () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Slow internet connection"),
            action: SnackBarAction(
                label: "Retry",
                onPressed: () async {
                  // getLatLangFromCache().then((value) async {
                  //   currentLat = value["latitude"];
                  //   currentLng = value["longitude"];

                  await getTrendingSeaFoodProducts();
                  // });
                })));
      });
    } catch (e) {
      // print(e);
    }
  }
  // ---------------------------------

  // get offers

  getOffers(index) async {
    offerProductExclusiveList.clear();
    try {
      final http.Response response = await http.post(
        Uri.parse('https://pureone.in/app/api_demo/offers_page.php'),
        // headers: <String, String>{
        //   'Content-Type': 'application/json; charset=UTF-8',
        // },

        body: jsonEncode(<String, String>{
          'last_row_id': "$index",
          'lat': "$currentLat",
          'long': "$currentLng"
        }),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.jsonDecode(response.body);
        // print(response.body);
        saveProduct(response.body);
        var videoJson = jsonResponse['products'];
        // courseList.clear();

        offersList.clear();
        videoJson.forEach((video) {
          // productImage.add(video["thumbnail"][0]);
          offersList.add(video);

          if (!isOffersLoaded.isClosed) {
            isOffersLoaded.add(true);
          }
        });

        List colorArray = [];

        videoJson.forEach((video) {
          if (video["specifications"]["color"] != null &&
              video["specifications"]["color"].length > 0) {
            colorArray.add(video["specifications"]["color"]);
          } else {
            colorArray.add(["images"]);
          }
        });

        for (int i = 0; i < colorArray.length; i++) {
          if (videoJson[i]["product_images"][colorArray[i].first] != null &&
              videoJson[i]["product_images"][colorArray[i].first].length > 0) {
            videoJson[i]["thumbnail"] =
                videoJson[i]["product_images"][colorArray[i].first].first;

            videoJson[i]["blurhashThumb"] =
                videoJson[i]["blurhash"][colorArray[i].first].first;

            offerProductExclusiveList.add(videoJson[i]);
            if (!isOffersLoaded.isClosed) {
              isOffersLoaded.add(true);
            }
          }
        }
      } else {
        // print('Request failed with status: ${response.statusCode}.');
      }
    } on SocketException {
      // print('No net');
      Future.delayed(const Duration(milliseconds: 300), () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Slow internet connection"),
            action: SnackBarAction(
                label: "Retry",
                onPressed: () {
                  getOffers(index);
                })));
      });
    } catch (e) {
      // print(e);
    }
  }

  getDiscoverNewProducts() async {
    try {
      final http.Response response = await http.post(
        Uri.parse('https://pureone.in/app/api_demo/discover_new_dashboard.php'),
        // headers: <String, String>{
        //   'Content-Type': 'application/json; charset=UTF-8',
        // },

        body: jsonEncode(<String, String>{
          'lat': "$currentLat",
          'long': "$currentLng",
          'last_row_id': "0"
        }),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.jsonDecode(response.body);
        // print(response.body);
        saveDiscoverProduct(response.body);
        var videoJson = jsonResponse['products'];
        // courseList.clear();

        discoverNewList.clear();

        videoJson.forEach((video) {
          // heightOfGrid++;

          // productImage.add(video["thumbnail"][0]);
          courseList.add(video);

          // isCourseLoaded.add(true);
        });

        List colorArray = [];

        videoJson.forEach((video) {
          if (video["specifications"]["color"] != null &&
              video["specifications"]["color"].length > 0) {
            colorArray.add(video["specifications"]["color"]);
          } else {
            colorArray.add(["images"]);
          }
        });
        // print("----------------${colorArray.length}");
        for (int i = 0; i < colorArray.length; i++) {
          if (videoJson[i]["product_images"][colorArray[i].first] != null &&
              videoJson[i]["product_images"][colorArray[i].first].length > 0) {
            videoJson[i]["thumbnail"] =
                videoJson[i]["product_images"][colorArray[i].first].first;

            videoJson[i]["blurhashThumb"] =
                videoJson[i]["blurhash"][colorArray[i].first].first;

            videoJson[i]["low_qty"] = splitImage(videoJson[i]["thumbnail"]);

            discoverNewList.add(videoJson[i]);
          }
        }
// quantity check

// end of quantity check

        if (!discoverNewLoadedStream.isClosed) {
          discoverNewList.shuffle();
          discoverNewLoadedStream.add(true);
        }
        // heightOfGridStreamController.add(heightOfGrid);
        // getCategoryIcons();
        // getCategoryIconsServer();
        if (!isScrolled) {
          await Future.delayed(const Duration(seconds: 5), () {
            if (discoverScrollController.hasClients) {
              discoverScrollController.animateTo(600,
                  duration: const Duration(seconds: 5),
                  curve: Curves.fastOutSlowIn);
              isScrolled = true;
            }
          });
          await Future.delayed(const Duration(seconds: 2), () {
            if (discoverScrollController.hasClients) {
              discoverScrollController.animateTo(0,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn);
              isScrolled = true;
            }
          });
        }
        // getLatLang().then((value) async {
        //   currentLat = value.latitude;
        //   currentLng = value.longitude;
        //   // getCategoryIcons();
        //   getSavedProducts();
        //   // await getTrendingProducts(0);

        //   if (!latlng.isClosed) {
        //     latlng.add(true);
        //   }
        // });
      } else {
        await getCategoryIconsServer();

        // print('Request failed with status: ${response.statusCode}.');
      }
    } on SocketException {
      // print('No net');
      Future.delayed(const Duration(milliseconds: 300), () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Slow internet connection"),
            action: SnackBarAction(
                label: "Retry",
                onPressed: () {
                  getDiscoverNewProducts();
                })));
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> saveProduct(String jsonData) async {
    final SharedPreferences prefs = await sPrefs;

    prefs.setString("product", jsonData);
  }

  Future<void> saveProductChicken(String jsonData) async {
    final SharedPreferences prefs = await sPrefs;

    prefs.setString("chicken_products", jsonData);
  }

  Future<void> saveProductMutton(String jsonData) async {
    final SharedPreferences prefs = await sPrefs;

    prefs.setString("mutton_product", jsonData);
  }

  Future<void> saveProductSeafood(String jsonData) async {
    final SharedPreferences prefs = await sPrefs;

    prefs.setString("seafood_product", jsonData);
  }

  Future<void> savePosters(String jsonData) async {
    final SharedPreferences prefs = await sPrefs;

    prefs.setString("posters", jsonData);
  }

  Future<void> saveCategoryIcons(String jsonData) async {
    final SharedPreferences prefs = await sPrefs;

    prefs.setString("categroyIcons", jsonData);
  }

  Future<void> saveDiscoverProduct(String jsonData) async {
    final SharedPreferences prefs = await sPrefs;

    prefs.setString("discover", jsonData);
  }

  Future<bool> getSavedPosters() async {
    final SharedPreferences prefs = await sPrefs;
    var cacheData = prefs.getString("posters");
    if (cacheData != null) {
      var jsonResponse = json.jsonDecode(cacheData);

      var videoJson = jsonResponse['poster'];
      posterList!.clear();

      // print(jsonEncode(videoJson));

      videoJson.forEach((video) {
        // productImage.add(video["thumbnail"][0]);

        posterList!.add(video);
      });
      if (!posterStreamController.isClosed) {
        posterStreamController.add(true);
      }
    }
    return true;
  }

  getSavedProductsChicken() async {
    try {
      trendingProductExclusiveList.clear();

      final SharedPreferences prefs = await sPrefs;

      var cacheData = prefs.getString("chicken_product");

      if (cacheData != null) {
        var jsonResponse = json.jsonDecode(cacheData);
        var videoJson = jsonResponse['products'];
        // courseList.clear();

        courseList.clear();
        videoJson.forEach((video) {
          // heightOfGrid++;

          // productImage.add(video["thumbnail"][0]);
          courseList.add(video);
        });

        List colorArray = [];

        videoJson.forEach((video) {
          if (video["specifications"]["color"] != null &&
              video["specifications"]["color"].length > 0) {
            colorArray.add(video["specifications"]["color"]);
          } else {
            colorArray.add(["images"]);
          }
        });

        for (int i = 0; i < colorArray.length; i++) {
          if (videoJson[i]["product_images"][colorArray[i].first] != null &&
              videoJson[i]["product_images"][colorArray[i].first].length > 0) {
            videoJson[i]["thumbnail"] =
                videoJson[i]["product_images"][colorArray[i].first].first;

            videoJson[i]["blurhashThumb"] =
                videoJson[i]["blurhash"][colorArray[i].first].first;

            // getLowQualityImgae(videoJson[i]["thumbnail"], i);

            videoJson[i]["low_qty"] = splitImage(videoJson[i]["thumbnail"]);

            trendingProductExclusiveList.add(videoJson[i]);
          }
        }
        if (!isCourseLoaded.isClosed) {
          isCourseLoaded.add(true);
        }
        // getPosters();
      } else {
        // getLatLangFromCache().then((value) async {
        //   currentLat = value["latitude"];
        //   currentLng = value["longitude"];

        await getTrendingChickenProducts();
        await getTrendingMuttonProducts();
        await getTrendingSeaFoodProducts();
        // });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getCategoryIcons() async {
    try {
      categoryIconList.clear();

      final SharedPreferences prefs = await sPrefs;
      var cacheData = prefs.getString("categroyIcons");
      if (cacheData != null) {
        var jsonResponse = json.jsonDecode(cacheData);

        categoryIconList.clear();

        // productImage.add(video["thumbnail"][0]);
        categoryIconList = jsonResponse['products'];

        for (var i = 0; i < categoryIconList.length; i++) {
          categoryIconsWidget.add(SizedBox(
            width: 90.0,
            child: InkWell(
              onTap: () => Navigator.pushNamed(
                  context, TfRoutes.specificProduct,
                  arguments: categoryIconList[i]),
              child: Column(
                children: [
                  CachedNetworkImage(
                    fit: BoxFit.contain,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF5B5B5B),
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                1.0, 1.0), // shadow direction: bottom right
                          )
                        ],
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFC3C3C3)),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.contain),
                      ),
                    ),
                    placeholder: (context, url) => ClipRRect(
                      borderRadius: BorderRadius.circular(120.0),
                      child: AspectRatio(
                        aspectRatio: 1.6,
                        child: BlurHash(
                            hash: categoryIconList[i]["blurhash"] ??
                                'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                      ),
                    ),
                    imageUrl: categoryIconList[i]["icon"],
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Center(
                        child: Text(categoryIconList[i]["title"],
                            overflow: TextOverflow.ellipsis,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ))
                ],
              ),
            ),
          ));
        }

        if (!isCategoryIconsLoaded.isClosed) {
          isCategoryIconsLoaded.add(true);

          await Future.delayed(const Duration(seconds: 5), () {
            getCategoryIconsServer();
          });
        }
      } else {
        getCategoryIconsServer();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getSlider() async {
    try {
      final SharedPreferences prefs = await sPrefs;
      var cacheData = prefs.getString("slider");

      if (cacheData != null) {
        var jsonResponse = json.jsonDecode(cacheData);

        var videoJson = jsonResponse['slider'];
        // courseList.clear();

        imgList.clear();
        videoJson.forEach((video) {
          // productImage.add(video["thumbnail"][0]);
          imgList.add(video["image_url"]);
          Map<String, dynamic> cat = {};
          cat["category"] = jsonEncode(video["categories"]);
          cat["title"] = video["title"];

          category[video["image_url"]] = cat;
          // isCourseLoaded.add(true);
        });

        List<Widget> imageSliders = imgList
            .map((item) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, TfRoutes.specificProduct,
                        arguments: getCategories(item));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        child: Stack(
                          children: <Widget>[
                            CachedNetworkImage(
                              fit: BoxFit.fitWidth,
                              width: MediaQuery.of(context).size.width,
                              height: 250,
                              placeholder: (context, url) => ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  child: AspectRatio(
                                    aspectRatio: 1.6,
                                    child: BlurHash(
                                        hash: getBlurhash(item) ??
                                            "LEHV6nWB2yk8pyo0adR*.7kCMdnj"),
                                  )),
                              imageUrl: "${splitImage(item)}&quality=0.9",
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),

                            // CachedNetworkImage(
                            //     imageUrl: "${splitImage(item)}&quality=0.2",
                            //     placeholder: (context, url) => FadeInImage(
                            //         width:
                            //             MediaQuery.of(scaffoldKey.currentContext!)
                            //                 .size
                            //                 .width,
                            //         height:
                            //             MediaQuery.of(scaffoldKey.currentContext!)
                            //                 .size
                            //                 .width,
                            //         fit: BoxFit.fitWidth,
                            //         image: CachedNetworkImageProvider(
                            //             "${splitImage(item)}&quality=0.2"),
                            //         placeholder: CachedNetworkImageProvider(
                            //             "${splitImage(item)}&quality=0.08"))),
                          ],
                        )),
                  ),
                ))
            .toList();
        if (!sliderLoaded.isClosed) {
          sliderLoaded.add(imageSliders);
        }
      }
    } catch (e) {
      getSliderImagesFROMNet(scaffoldKey.currentContext!);

      // print(e);
    } finally {
      getSliderImagesFROMNet(scaffoldKey.currentContext!);
    }
  }

  Future<void> getDiscoverProducts() async {
    timer?.cancel();
    discoverNewCalled = true;
    try {
      final SharedPreferences prefs = await sPrefs;
      var cacheData = prefs.getString("discover");

      if (cacheData != null) {
        var jsonResponse = json.jsonDecode(cacheData);

        var videoJson = jsonResponse['products'];
        // courseList.clear();

        discoverNewList.clear();
        videoJson.forEach((video) {
          // heightOfGrid++;

          // productImage.add(video["thumbnail"][0]);
          courseList.add(video);

          // isCourseLoaded.add(true);
        });

        List colorArray = [];

        videoJson.forEach((video) {
          if (video["specifications"]["color"] != null &&
              video["specifications"]["color"].length > 0) {
            colorArray.add(video["specifications"]["color"]);
          } else {
            colorArray.add(["images"]);
          }
        });
        // print("----------------${colorArray.length}");
        for (int i = 0; i < colorArray.length; i++) {
          if (videoJson[i]["product_images"][colorArray[i].first] != null &&
              videoJson[i]["product_images"][colorArray[i].first].length > 0) {
            videoJson[i]["thumbnail"] =
                videoJson[i]["product_images"][colorArray[i].first].first;

            videoJson[i]["blurhashThumb"] =
                videoJson[i]["blurhash"][colorArray[i].first].first;

            videoJson[i]["low_qty"] = splitImage(videoJson[i]["thumbnail"]);

            discoverNewList.add(videoJson[i]);
          }
        }
        await getDiscoverNewProducts();

        if (!discoverNewLoadedStream.isClosed) {
          discoverNewLoadedStream.add(true);
        }
        // heightOfGridStreamController.add(heightOfGrid);
        if (!isScrolled) {
          await Future.delayed(const Duration(seconds: 5), () {
            if (discoverScrollController.hasClients) {
              discoverScrollController.animateTo(600,
                  duration: const Duration(seconds: 5),
                  curve: Curves.fastOutSlowIn);
              isScrolled = true;
            }
          });
          await Future.delayed(const Duration(seconds: 2), () {
            if (discoverScrollController.hasClients) {
              discoverScrollController.animateTo(0,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn);
              isScrolled = true;
            }
          });
        }
        getDiscoverNewProducts();
      } else {
        getDiscoverNewProducts();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  int getCrossAxisCount(media) {
    if (media < 600) {
      return 2;
    } else if (media > 600 && media < 900) {
      return 3;
    } else {
      return 4;
    }
  }

  // int getAxisResio(media) {
  //   if (media < 600) {
  //     return 2;
  //   } else if (media > 600 && media < 900) {
  //     return 3;
  //   } else {
  //     return 4;
  //   }

  // }

  getCategoryIconsServer() async {
    try {
      const url = "https://pureone.in/app/api_demo/category_icos.php";

      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonResponse = json.jsonDecode(response.body);

        saveCategoryIcons(response.body);
        categoryIconList.clear();
        categoryIconsWidget.clear();
        // productImage.add(video["thumbnail"][0]);
        categoryIconList = jsonResponse['products'];

        //here is i have to add widget to wrap

        for (var i = 0; i < categoryIconList.length; i++) {
          categoryIconsWidget.add(SizedBox(
            width: 90.0,
            child: InkWell(
              onTap: () => Navigator.pushNamed(
                  context, TfRoutes.specificProduct,
                  arguments: categoryIconList[i]),
              child: Column(
                children: [
                  CachedNetworkImage(
                    fit: BoxFit.contain,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF5B5B5B),
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                1.0, 1.0), // shadow direction: bottom right
                          )
                        ],
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFC3C3C3)),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.contain),
                      ),
                    ),
                    placeholder: (context, url) => AspectRatio(
                      aspectRatio: 1.6,
                      child: BlurHash(
                          hash: categoryIconList[i]["blurhash"] ??
                              'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                    ),
                    imageUrl: categoryIconList[i]["icon"],
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Center(
                        child: Text(categoryIconList[i]["title"],
                            overflow: TextOverflow.ellipsis,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ))
                ],
              ),
            ),
          ));
        }
        //end of wrap

        if (!isCategoryIconsLoaded.isClosed) {
          isCategoryIconsLoaded.add(true);
        }
        // getTrendingProducts(0);
      } else {
        // print('Request failed with status: ${response.statusCode}.');
      }
    } on SocketException {
      // print('No net');
      Future.delayed(const Duration(milliseconds: 300), () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Slow internet connection"),
            action: SnackBarAction(
                label: "Retry",
                onPressed: () {
                  getCategoryIconsServer();
                })));
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  showLocationDialog(BuildContext context) {
    // set up the buttons

    Widget launchButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Location Is Required",
          style: TextStyle(fontFamily: "kau")),
      content: const Text(
          "Pureone need to get location  to serve delivery quickly. It is safe Process",
          style: TextStyle(fontFamily: "kau")),
      actions: [
        launchButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // getPosters() async {
  //   var client = http.Client();
  //   try {
  //     final http.Response response = await client
  //         .get(Uri.parse('https://pureone.in/app/api_demo/list_of_posters.php'));

  //     if (response.statusCode == 200) {
  //       var jsonResponse = json.jsonDecode(response.body);
  //       // print(response.body);
  //       savePosters(response.body);

  //       // saveProduct(response.body);
  //       var videoJson = jsonResponse['poster'];
  //       posterList!.clear();

  //       // print(jsonEncode(videoJson));

  //       videoJson.forEach((video) {
  //         // productImage.add(video["thumbnail"][0]);
  //         posterList!.add(video);
  //       });
  //       if (!posterStreamController.isClosed) {
  //         posterStreamController.add(true);
  //       }
  //     } else {
  //       // print('Request failed with status: ${response.statusCode}.');
  //     }
  //   } on SocketException {
  //     // print('No net');
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: const Text("Slow internet connection"),
  //         action: SnackBarAction(
  //             label: "Retry",
  //             onPressed: () {
  //               getPosters();
  //             })));
  //   } catch (e) {
  //     // print(e);
  //   } finally {
  //     client.close();
  //   }
  // }

  List<dynamic> imgList = [];

  Map<String, String> sliderBlur = {};
  Map<String, dynamic> category = {};

  getSliderImagesFROMNet(BuildContext context) async {
    try {
      final http.Response response = await http.get(
        Uri.parse('https://pureone.in/app/api_demo/slider_image_api.php'),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.jsonDecode(response.body);

        // print(response.body);
        saveSlider(response.body);
        var videoJson = jsonResponse['slider'];
        // courseList.clear();

        imgList.clear();
        videoJson.forEach((video) {
          // productImage.add(video["thumbnail"][0]);
          imgList.add(video["image_url"]);
          Map<String, dynamic> cat = {};
          cat["category"] = jsonEncode(video["categories"]);
          cat["title"] = video["title"];

          category[video["image_url"]] = cat;
          // isCourseLoaded.add(true);
        });

        List<Widget> imageSliders = imgList
            .map((item) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, TfRoutes.specificProduct,
                        arguments: getCategories(item));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        child: Stack(
                          children: <Widget>[
                            CachedNetworkImage(
                              fit: BoxFit.fitWidth,
                              width: MediaQuery.of(context).size.width,
                              height: 250,
                              placeholder: (context, url) => AspectRatio(
                                aspectRatio: 1.6,
                                child: BlurHash(
                                    hash: getBlurhash(item) ??
                                        "LEHV6nWB2yk8pyo0adR*.7kCMdnj"),
                              ),
                              imageUrl: "${splitImage(item)}&quality=0.9",
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),

                            // CachedNetworkImage(
                            //     imageUrl: "${splitImage(item)}&quality=0.2",
                            //     placeholder: (context, url) => FadeInImage(
                            //         width:
                            //             MediaQuery.of(scaffoldKey.currentContext!)
                            //                 .size
                            //                 .width,
                            //         height:
                            //             MediaQuery.of(scaffoldKey.currentContext!)
                            //                 .size
                            //                 .width,
                            //         fit: BoxFit.fitWidth,
                            //         image: CachedNetworkImageProvider(
                            //             "${splitImage(item)}&quality=0.2"),
                            //         placeholder: CachedNetworkImageProvider(
                            //             "${splitImage(item)}&quality=0.08"))),
                          ],
                        )),
                  ),
                ))
            .toList();
        if (!sliderLoaded.isClosed) {
          sliderLoaded.add(imageSliders);
        }
      } else {
        // print('Request failed with status: ${response.statusCode}.');
      }
    } on SocketException {
      // print('No net');
      Future.delayed(const Duration(milliseconds: 300), () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Slow internet connection"),
            action: SnackBarAction(
                label: "Retry",
                onPressed: () {
                  getSliderImagesFROMNet(context);
                })));
      });
    } catch (e) {
      // print(e);
    }
  }

  // Future<bool> showLocationImageDialog(
  //     BuildContext context, String type) async {
  //   // set up the buttons
  //   isShowingDialogue = true;
  //   Widget launchButton = TextButton(
  //     child: const Text("OK"),
  //     onPressed: () {
  //       isShowingDialogue = false;
  //       Navigator.pop(context);
  //       if (!kIsWeb) {
  //         if (type == "location") {
  //           // Geolocator.openLocationSettings();
  //         } else {
  //           // Geolocator.openAppSettings();
  //         }
  //       }
  //       return;
  //     },
  //   );

  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     content: const Text(
  //         "For best deals and offers enable device location manually, your privacy is our first priority."),
  //     actions: [
  //       launchButton,
  //     ],
  //   );

  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  //   return false;
  // }

  void setContext(BuildContext context) {
    this.context = context;
  }

  downloadAppShowDialogue(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('New version available'),
        content: const Text('Update app for new features'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Future<void> deviceInfo() async {
  //   // new code //

  //   if (currentLat == 0 && currentLng == 0) {
  //     Timer.periodic(const Duration(seconds: 1), (timer) async {
  //       getLatLang().then((value) {
  //         if (value.latitude != 0 && value.longitude != 0) {
  //           currentLat = value.latitude;
  //           currentLng = value.longitude;
  //           timer.cancel();
  //           getDiscoverProducts();
  //           if (!latlng.isClosed) {
  //             latlng.add(true);
  //           }
  //         }
  //       });
  //     });
  //   }
  // }

  // bool _isalertShowing = false;

  // _showDialog(BuildContext context, String whatToOpen) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       _isalertShowing = true;
  //       return AlertDialog(
  //         title: const Text('Location required'),
  //         content: SizedBox(
  //           height: 160,
  //           child: Column(
  //             children: [
  //               CachedNetworkImage(
  //                 width: 100,
  //                 height: 100,
  //                 fit: BoxFit.contain,
  //                 placeholder: (context, url) => const AspectRatio(
  //                   aspectRatio: 1.6,
  //                   child:
  //                       BlurHash(hash: 'UdShNBofy?ofiIfkV@kCpwf6i_ayn4fkuOae'),
  //                 ),
  //                 imageUrl:
  //                     "https://pureone.in/app/api_demo/pureone/app/app_images/loca.jpg",
  //                 errorWidget: (context, url, error) => const Icon(Icons.error),
  //               ),
  //               const Text(
  //                   "Enable location service so you can get the best offers and correct delivery time "),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text("OK"),
  //             onPressed: () {
  //               //Put your code here which you want to execute on Yes button click.
  //               Navigator.of(context).pop();
  //               _isalertShowing = true;

  //               if (!kIsWeb) {
  //                 if (whatToOpen == "location") {
  //                   // Geolocator.openLocationSettings();
  //                 } else {
  //                   // Geolocator.openAppSettings();
  //                 }
  //               }
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void _showDialog(String whatToOpen) {
  //   // flutter defined function
  //   // Navigator.of(context, rootNavigator: true).pop('dialog');

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       _isalertShowing = true;
  //       // return object of type Dialog
  //       return AlertDialog(
  //         title: const Text("Location required"),
  //         content: Column(
  //           children: <Widget>[
  //             Image.asset(
  //               'images/del_img.png',
  //               height: 200,
  //               fit: BoxFit.cover,
  //             ),
  //             Text(
  //               'This Is Some Text',
  //               style: TextStyle(
  //                 fontSize: 24,
  //               ),
  //             ),
  //           ],
  //         ),

  //         // Text(
  //         // "Enable location service so you can get the best offers and correct delivery time "),
  //         actions: <Widget>[
  //           // usually buttons at the bottom of the dialog
  //           // TextButton(
  //           //   child: const Text("Close app"),
  //           //   onPressed: () {
  //           //     _isalertShowing = false;

  //           //     Navigator.of(context).pop();
  //           //   },
  //           // ),

  //           TextButton(
  //             child: const Text("OK"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               _isalertShowing = true;

  //               if (!kIsWeb) {
  //                 if (whatToOpen == "location") {
  //                   Geolocator.openLocationSettings();
  //                 } else {
  //                   Geolocator.openAppSettings();
  //                 }
  //               }
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  allBadgeCount() async {
    SharedPreferences prefs = await sPrefs;
    if (prefs.getString("my_cart") != null &&
        jsonDecode(prefs.getString("my_cart")!).length > 0) {
      var cartData = jsonDecode(prefs.getString("my_cart")!);

      numberOfItemsInCart = cartData.length.toString();
      // Future.delayed(const Duration(milliseconds: 500), () {
      // Here you can write your code

      totalAmountForCart = "0";

      num itemTotalSum = 0;

      cartData.forEach((video) {
        itemTotalSum += int.parse(video["selling_price"]) * video["quantity"];
        video["sellingQuanity"] =
            (num.parse(video["selling_price"]) * video["quantity"]);
        totalAmountForCart = itemTotalSum.toString();
      });
      loadAllCacheData();

      notifyBadge.add(true);
      // });
    } else {
      // Future.delayed(const Duration(milliseconds: 500), () {
      // Here you can write your code

      notifyBadge.add(false);
      // });
    }

    if (prefs.getString("my_wish_list") != null &&
        jsonDecode(prefs.getString("my_wish_list")!).length > 0 &&
        jsonDecode(prefs.getString("my_wish_list")!).length < 10) {
      myCartBadgeString =
          ((jsonDecode(prefs.getString("my_wish_list")!).length).toString());
    } else if (prefs.getString("my_wish_list") != null &&
        jsonDecode(prefs.getString("my_wish_list")!).length > 9) {
      myCartBadgeString = "9+";
    } else {
      myCartBadgeString = "";
    }
  }

  // getSpecialIcons() async {
  //   final SharedPreferences prefs = await sPrefs;
  //   var cacheData = prefs.getString("speicalIcons");
  //   if (cacheData != null) {
  //     var jsonResponse = json.jsonDecode(cacheData);
  //     // print(jsonEncode(videoJson));
  //     iconSpeical = jsonResponse['special_icons'];
  //     iconSpecialStream.add(true);
  //   }

  //   try {
  //     // final dio = Dio();
  //     // final response = await dio
  //     //     .get('https://pureone.in/app/api_demo/special_category_icons.php');
  //     // print(response.data);

  //     // // var url =
  //     // //     Uri.https('pureone.in', '/app/api_demo/special_category_icons.php');

  //     // // var response = await http.get(url);

  //     final http.Response response = await http.get(
  //       Uri.parse('https://pureone.in/app/api_demo/special_category_icons.php'),
  //     );
  //     if (response.statusCode == 200) {
  //       var jsonResponse = json.jsonDecode(response.body);
  //       saveSpecialIcons(response.body);
  //       iconSpeical.clear();
  //       iconSpeical = jsonResponse['special_icons'];
  //       iconSpecialStream.add(true);

  //       // here i added to code from constructor

  //       getLatLang().then((value) async {
  //         currentLat = value.latitude;
  //         currentLng = value.longitude;

  //         if (currentLat != 0 && currentLng != 0) {
  //           await getDiscoverProducts();
  //           // await getTrendingProducts(0);
  //           if (!latlng.isClosed) {
  //             latlng.add(true);
  //           }
  //         } else {
  //           timer = Timer.periodic(const Duration(seconds: 2), (Timer t) {
  //             getLatLang().then((value) async {
  //               currentLat = value.latitude;
  //               currentLng = value.longitude;

  //               if (currentLat != 0 && currentLng != 0 && !discoverNewCalled) {
  //                 await getDiscoverProducts();
  //                 await getTrendingChickenProducts();
  //                 await getTrendingSeaFoodProducts();

  //                 if (!latlng.isClosed) {
  //                   latlng.add(true);
  //                 }
  //               }
  //             });
  //           });
  //         }
  //       });

  //       getSlider();
  //       getCategoryIcons();
  //     }
  //   } on SocketException {
  //     // print('No net');
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text("Slow internet connection"),
  //     ));
  //   } catch (e) {
  //     // print(e);
  //   }
  // }

  getBlurhash(String imagekey) {
    return sliderBlur[imagekey];
  }

  getCategories(String imagekey) {
    Map<String, dynamic> a = category[imagekey];
    return a;
  }

  // saveTocken() async {
  //   // getLatLang();

  //   String? token = "";
  //   token = await FirebaseMessaging.instance.getToken();
  //   getTokenFromLocalStorage(token).then((value) async {
  //     print(value);
  //     if (value != token || value == "") {
  //       final http.Response response = await http.post(
  //         Uri.parse('https://pureone.in/app/api_demo/add_customers_token.php'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //         },
  //         body: jsonEncode(<String, String>{
  //           'device': kIsWeb
  //               ? "Web"
  //               : Platform.isAndroid
  //                   ? "Android"
  //                   : "IOS",
  //           'token': token ?? ""
  //         }),
  //       );
  //       if (response.statusCode == 200) {}
  //     }
  //   });
  // }

  Future<String> getTokenFromLocalStorage(token) async {
    final SharedPreferences prefs = await sPrefs;

    if (prefs.getString("token_is") != null) {
      String tok = prefs.getString("token_is")!;
      return tok;
    } else {
      prefs.setString("token_is", token);

      return "";
    }
  }

  Future<void> launchUrl(url) async {
    await launchUrl(url);
  }
  //
  // String getFirstQty(String qty) {
  //   List qtyList = jsonDecode(qty);
  //   return qtyList.first.first.toString();
  // }

  // int maxId = 0;

  // getSpecifications(category) async {
  //   isLoadMore.add(false);
  //
  //   final http.Response response = await http
  //       .post(
  //     Uri.parse(
  //         'https://pureone.in/app/api_demo/specific_products_from_icons_selection.php'),
  //     body: jsonEncode(<String, dynamic>{
  //       'last_row_id': "$maxId",
  //       'items_list': details!["category"].toString(),
  //       'lat': "$currentLat",
  //       'long': "$currentLng"
  //     }),
  //   )
  //       .catchError((e) {
  //     ScaffoldMessenger.of(scaffoldKey.currentContext!)
  //         .showSnackBar(SnackBar(content: Text(e.toString())));
  //   });
  //
  //   if (response.statusCode == 200) {
  //     var jsonResponse = jsonDecode(response.body);
  //     // saveProduct(response.body);
  //     var videoJson = jsonResponse['products'];
  //     if (videoJson.length == 0 && productList!.isEmpty) {
  //       isProductLoaded.add(Clas.notthing);
  //     }
  //     // videoJson.forEach((video) {
  //     //   if (!checkRepetition.contains(video["id"])) {
  //     //     checkRepetition.add(video["id"]);
  //     //     productList!.add(video);
  //     //     if (!isProductLoaded.isClosed) {
  //     //       isProductLoaded.add(Clas.loded);
  //     //     }
  //     //   }
  //     // });
  //
  //     List colorArray = [];
  //
  //     videoJson.forEach((video) {
  //       if (video["specifications"]["color"] != null &&
  //           video["specifications"]["color"].length > 0) {
  //         colorArray.add(video["specifications"]["color"]);
  //       } else {
  //         colorArray.add(["images"]);
  //       }
  //     });
  //
  //     for (int i = 0; i < colorArray.length; i++) {
  //       if (videoJson[i]["product_images"][colorArray[i].first] != null &&
  //           videoJson[i]["product_images"][colorArray[i].first].length > 0) {
  //         videoJson[i]["thumbnail"] =
  //             videoJson[i]["product_images"][colorArray[i].first].first;
  //         // getLowQualityImgae(videoJson[i]["thumbnail"], i);
  //         videoJson[i]["blurhashThumb"] =
  //             videoJson[i]["blurhash"][colorArray[i].first].first;
  //         if (maxId < int.parse(videoJson[i]["id"])) {
  //           maxId = int.parse(videoJson[i]["id"]);
  //         }
  //         if (!checkRepetition.contains(videoJson[i]["id"])) {
  //           checkRepetition.add(videoJson[i]["id"]);
  //           productList!.add(videoJson[i]);
  //         }
  //         if (!isProductLoaded.isClosed) {
  //           // productList!.shuffle();
  //           isProductLoaded.add(Clas.loded);
  //         }
  //         if (!isLoadMore.isClosed) {
  //           isLoadMore.add(false);
  //         }
  //       }
  //     }
  //     if (trendingController.hasClients) {
  //       trendingController.animateTo(trendingController.position.pixels + 200,
  //           duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  //     }
  //   } else {
  //     // print('Request failed with status: ${response.statusCode}.');
  //   }
  // }

  getOldChickenProducts() async {
    try {
      final SharedPreferences prefs = await sPrefs;
      var cacheData = prefs.getString("chicken_products");

      if (cacheData != null) {
        var jsonResponse = json.jsonDecode(cacheData);

        var videoJson = jsonResponse['products'];

        // courseList.clear();
        videoJson.forEach((video) {
          // heightOfGrid++;

          maxId = int.parse(video["id"]);

          courseList.add(video);

          // if (!isCourseLoaded.isClosed) {
          //   isCourseLoaded.add(true);
          // }
        });
        videoJson.forEach((video) {
          if (maxId > int.parse(video["id"])) {
            maxId = int.parse(video["id"]);
          }
        });
        List colorArray = [];

        videoJson.forEach((video) {
          if (video["specifications"]["color"] != null &&
              video["specifications"]["color"].length > 0) {
            colorArray.add(video["specifications"]["color"]);
          } else {
            colorArray.add(["images"]);
          }
        });

        for (int i = 0; i < colorArray.length; i++) {
          if (videoJson[i]["product_images"][colorArray[i].first] != null &&
              videoJson[i]["product_images"][colorArray[i].first].length > 0) {
            videoJson[i]["thumbnail"] =
                videoJson[i]["product_images"][colorArray[i].first].first;

            // getLowQualityImgae(videoJson[i]["thumbnail"], i);
            videoJson[i]["blurhashThumb"] =
                videoJson[i]["blurhash"][colorArray[i].first].first;

            videoJson[i]["low_qty"] = splitImage(videoJson[i]["thumbnail"]);

            trendingProductExclusiveList.add(videoJson[i]);
          }
        }

        if (!isCourseLoaded.isClosed) {
          // trendingProductExclusiveList.shuffle();
          isCourseLoaded.add(true);
        }
        getTrendingChickenProducts();
        // getPosters();
        // getSavedPosters();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void loadAllCacheData() async {
    // getLatLangFromCache().then((value) async {
    //   currentLat = value["latitude"];
    //   currentLng = value["longitude"];

    //   if (currentLat != 0 && currentLng != 0) {
    //     getDiscoverNewProducts();
    //     getTrendingChickenProducts();
    //     // await getTrendingProducts(0);
    //     if (!latlng.isClosed) {
    //       latlng.add(true);
    //     }
    //   } else {
    //     // timer = Timer.periodic(const Duration(seconds: 2), (Timer t) {
    //     getLatLangFromCache().then((value) async {
    //       currentLat = value["latitude"];
    //       currentLng = value["longitude"];

    //       if (currentLat != 0 && currentLng != 0 && !discoverNewCalled) {
    await getDiscoverNewProducts();
    await getTrendingChickenProducts();
    await getTrendingSeaFoodProducts();

    //         if (!latlng.isClosed) {
    //           latlng.add(true);
    //         }
    //       }
    //       // });
    //     });
    //   }
    // });
  }

  Future<String> getAddress() async {
    final SharedPreferences prefs = await sPrefs;
    deliveryAddress = "Add delivery address.";

    if (prefs.getString("currentUserAddress") != null) {
      deliveryAddress = prefs.getString("currentUserAddress");

      double distance = double.parse(prefs.getString("distance") ?? "-1");

      if (distance > -1 && distance <= 3) {
        weDontDeliveryHereStream.add(true);
      } else {
        weDontDeliveryHereStream.add(false);
      }

      addressStream.add(true);
    } else {
      openMapForPickLocationAndAddress();
    }

    return deliveryAddress!;
  }

  void openMapForPickLocationAndAddress() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: scaffoldKey.currentContext!,
        builder: (builder) {
          return SizedBox(
              height: MediaQuery.of(scaffoldKey.currentContext!).size.height,
              child: Stack(
                children: [
                  OpenStreetMapSearchAndPick(
                      locationPinIconColor: const Color(0xFFB14F2B),
                      buttonTextStyle:
                          const TextStyle(backgroundColor: Color(0xFFB14F2B)),
                      center: LatLong(
                          currentLat != 0.0 ? currentLat : 13.9332676,
                          currentLng != 0.0 ? currentLng : 75.5553415),
                      buttonColor: const Color(0xFFB14F2B),
                      buttonText: 'Confirm Address',
                      onGetCurrentLocationPressed: () {
                        return locationService.getPosition();
                      },
                      onPicked: (pickedData) async {
                        print(pickedData.latLong.latitude);
                        print(pickedData.latLong.longitude);
                        print(pickedData.address);

                        currentLat = pickedData.latLong.latitude;
                        currentLng = pickedData.latLong.longitude;
                        // addressTextField.text = "${pickedData.addressName} ";

                        final SharedPreferences prefs = await sPrefs;

                        prefs.setString(
                            "currentUserAddress", pickedData.addressName);

                        saveUserLocation(currentLat, currentLng);

                        prefs.setString(
                            "currentUserAddress", pickedData.addressName);
                        prefs.setString(
                            "currentUserAddress", pickedData.addressName);

                        deliveryAddress = pickedData.addressName;

                        // addressStream.add(true); //13.9332958,75.5555085

                        Navigator.pop(scaffoldKey.currentContext!);

                        // getDeliveryTime()

                        double distance = Geolocator.distanceBetween(13.9332958,
                                75.5555085, currentLat, currentLng) /
                            1000.0;
                        prefs.setString("distance", distance.toString());

                        if (distance <= 3) {
                          ScaffoldMessenger.of(scaffoldKey.currentContext!)
                              .showSnackBar(SnackBar(
                            content: Text("Sorry we dont delivery"),
                          ));

                          weDontDeliveryHereStream.add(false);
                        } else {
                          weDontDeliveryHereStream.add(true);
                        }

                        // debugPrint(
                        //     "${13.9332958} , ${75.5555085}, $currentLat, $currentLng");

                        addressStream.add(true);

                        // weDontDeliveryHereStream.add(true);
                      }),
                  // const Center(
                  //     child:
                  //         CircularProgressIndicator(color: Color(0xFFB14F2B)))
                ],
              ));
        });
  }

  @override
  void dispose() {
    imagesLoadedForSliderStreamController.close();
    isCourseLoaded.close();
    isCourseLoaded1.close();
    isCourseLoaded2.close();
    discoverNewLoadedStream.close();
    trendingController.dispose();
    offerController.dispose();
    isCategoryIconsLoaded.close();
    isOffersLoaded.close();
    lowQualityImageStream.close();
    sliderLoaded.close();
    timer?.cancel();
    discoverScrollController.dispose();
    dashboardScroll.dispose();
    latlng.close();
    timer?.cancel();
    iconSpecialStream.close();
    notifyBadge.close();
    isShowFooter.close();
    addressUpdate.close();
    weDontDeliveryHereStream.close();
    super.dispose();
  }

  void addToCart(Map<String, dynamic> discoverNewList, String quantity) async {
    Map<String, dynamic> addedToCart = {};

    addedToCart["selected_image"] = discoverNewList["thumbnail"];

    addedToCart["selected_blur_image"] = discoverNewList["blurhashThumb"];
    addedToCart["specifications"] = {"color": "images", "Quantity": quantity};
    addedToCart["delivery_charge"] = discoverNewList["delivery_charge"];
    addedToCart["quantity"] = 1;
    addedToCart["name"] = discoverNewList["name"];

    addedToCart["category"] = discoverNewList["category"];

    addedToCart["shop_id"] = discoverNewList["shop_id"];

    addedToCart["product_id"] = discoverNewList["product_id"];

    addedToCart["selling_price"] = discoverNewList["selling_price"];

    SharedPreferences prefs = await sPrefs;

    var oldCartData = jsonDecode(prefs.getString("my_cart") ?? "[]");

    oldCartData.add(addedToCart);

    // print(oldCartData);

    prefs.setString("my_cart", jsonEncode(oldCartData));

// here i have to add data to cart

    numberOfItemsInCart = oldCartData.length.toString();
    totalAmountForCart = "0";

    num itemTotalSum = 0;

    oldCartData.forEach((video) {
      itemTotalSum += int.parse(video["selling_price"]) * video["quantity"];
      video["sellingQuanity"] =
          (num.parse(video["selling_price"]) * video["quantity"]);
      totalAmountForCart = itemTotalSum.toString();
    });

    notifyBadge.add(true);

    // -----------
    // thumbnail
    // blurhashThumb

    // specifications

    // delivery_charge

    // name
    // category
    // shop_id
    // product_id
    // selling_price
  }

  // void getLocationAndSaveIt() {
  //   getLatLang1().then((value) {
  //     currentLat = value.latitude;
  //     currentLng = value.longitude;

  //     saveUserLocation(currentLat, currentLng);
  //   });
  // }

  // Future<Map<String, dynamic>> getLatLangFromCache() async {
  //   final SharedPreferences prefs = await sPrefs;

  //   double lat = double.parse(prefs.getString("currentUserLat") ?? "0");
  //   double long = double.parse(prefs.getString("currentUserLong") ?? "0");

  //   Map<String, dynamic> locations = {"latitude": lat, "longitude": long};
  //   return locations;
  // }
}
