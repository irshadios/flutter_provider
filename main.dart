//  apiKey: "AIzaSyAFNnftBRPq0_RO9z5wZOu-9NfnmqR5I9A",
//     authDomain: "pureone-74bad.firebaseapp.com",
//     databaseURL:
//         "https://pureone-74bad-default-rtdb.asia-southeast1.firebasedatabase.app",
//     projectId: "pureone-74bad",
//     storageBucket: "pureone-74bad.appspot.com",
//     messagingSenderId: "846345627546",
//     appId: "1:846345627546:web:66cbb1b54eeecf9616bc23",

import 'dart:async';
import 'dart:io';
import 'package:fluro/fluro.dart' as rou;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pureone/products/home_page.dart';
import 'package:pureone/products/search_model.dart';
import 'package:pureone/routes/tf_routes.dart';
import 'package:provider/provider.dart';
import 'package:pureone/products/product_dashboard.dart';
import 'package:pureone/provider/product_page_provider.dart';
// import 'login.dart';

Future<void> main() => getSharedPreferenceObject();
// Location location = Location();
getSharedPreferenceObject() async {
  WidgetsFlutterBinding.ensureInitialized();

  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(const Amitor(TfRoutes.root));
}

class Amitor extends StatefulWidget {
  final String route;

  const Amitor(this.route, {Key? key}) : super(key: key);

  @override
  State<Amitor> createState() => _AmitorState();
}

class _AmitorState extends State<Amitor> {
  late Widget opsWidget;
  // AppTranslationsDelegate _newLocaleDelegate;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductPageProvider>(
            create: (context) => ProductPageProvider(),
            child: const ProductPage())
      ],
      child: MaterialApp(
        initialRoute: widget.route,
        debugShowCheckedModeBanner: false,
        title: 'Pureone',
        onGenerateRoute: TfRoutes.router!.generator,
        theme: ThemeData(
            primaryColor: const Color(0xFF16004D),
            brightness: Brightness.light,
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.black)),
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: ChangeNotifierProvider(
            create: (_) => SearchModel(),
            child: const Home(),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    final router = rou.FluroRouter();
    TfRoutes.router = router;
    TfRoutes.configureRoutes(router);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    color: Colors.blue,
                    playSound: true,
                    icon: '@mipmap/ic_launcher')));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print('A new onmessage opened app event was published');

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });

    super.initState();
  }
}

class ThemeSwitch {}
