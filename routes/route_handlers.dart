import 'package:pureone/auth/payment_login.dart';
import 'package:pureone/payment/payment_page.dart';
import 'package:pureone/products/all_categories_list.dart';
import 'package:pureone/products/enquiry_page.dart';
import 'package:pureone/products/orders_return_page.dart';
import 'package:pureone/products/ratings_page.dart';
import 'package:pureone/products/return_order.dart';
import 'package:pureone/products/specific_products_from_icons_selection.dart';
import 'package:pureone/products/suggession_page.dart';
import 'package:pureone/products/cart.dart';
import 'package:pureone/products/home_page.dart';
import 'package:pureone/products/image_zoom.dart';
// import 'package:pureone/products/onBaording.dart';
import 'package:pureone/products/order_page.dart';
import 'package:pureone/products/payment_recipt.dart';
import 'package:pureone/products/pdf_view_bill.dart';
import 'package:pureone/products/place.dart';
import 'package:pureone/products/poster_selected_page.dart';
import 'package:pureone/products/product_dashboard.dart';
import 'package:pureone/products/product_description_page.dart';
import 'package:pureone/products/profile_page.dart';
import 'package:pureone/products/raise_complaint.dart';
import 'package:pureone/products/search_model.dart';
import 'package:pureone/products/searched_products.dart';
import 'package:pureone/products/sell_your_products.dart';
import 'package:pureone/products/track_product.dart';
import 'package:pureone/products/view_all_bills.dart';
import 'package:pureone/products/view_all_products.dart';
import 'package:pureone/products/view_all_products_by_category_icons.dart';
// import 'package:pureone/products/web_payments.dart';
import 'package:pureone/products/wish_list.dart';
import 'package:pureone/provider/all_categories_list_provider.dart';
import 'package:pureone/provider/enquiry_provider.dart';
import 'package:pureone/provider/orders_return_provider.dart';
import 'package:pureone/provider/ratings_provider.dart';
import 'package:pureone/provider/return_order_provider.dart';
import 'package:pureone/provider/specific_products_from_icons_selection_provider.dart';
import 'package:pureone/provider/suggestion_page_provider.dart';
import 'package:pureone/provider/pdf_view_bill_provider.dart';
import 'package:pureone/provider/raise_complaint_provider.dart';
import 'package:pureone/provider/cart_provider.dart';
import 'package:pureone/provider/image_zoom_provider.dart';
import 'package:pureone/provider/login_provider.dart';
import 'package:pureone/auth/login.dart';
import 'package:pureone/provider/order_provider.dart';
import 'package:pureone/provider/payment_login_provider.dart';

import 'package:pureone/provider/payment_provider/payment_provider.dart';
import 'package:pureone/provider/payment_recipt_provider.dart';
import 'package:pureone/provider/poster_selected_provider.dart';
import 'package:pureone/provider/product_details_page_provider.dart';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:pureone/provider/track_product_provider.dart';
import 'package:pureone/provider/view_all_bill_provider.dart';
// import 'package:pureone/provider/wedding_functions_need_to_send_to_home_provider.dart';
import 'package:provider/provider.dart';
import 'package:pureone/provider/product_page_provider.dart';
import 'package:pureone/provider/profile_page_provider.dart';
import 'package:pureone/provider/searched_product_provider.dart';
import 'package:pureone/provider/sell_your_products_provider.dart';
import 'package:pureone/provider/view_all_products_by_category_icons_provider.dart';
import 'package:pureone/provider/view_all_products_provider.dart';
import 'package:pureone/provider/wish_list_provider.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ChangeNotifierProvider<SearchModel>(
      create: (context) => SearchModel(), child: const Home());
});

var productDetailsPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  Map<String, dynamic>? obj =
      ModalRoute.of(context!)!.settings.arguments as Map<String, dynamic>;

  return ChangeNotifierProvider<ProductDetailsPageProvider>(
      create: (context) => ProductDetailsPageProvider(productDetails: obj),
      child: ProductDetailsPage());
});

var cartHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String? obj = ModalRoute.of(context!)!.settings.arguments as String?;

  return ChangeNotifierProvider<CartProvider>(
      create: (context) => CartProvider(jsonCartItems: obj), child: Cart());
});

var paymentHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  Map<String, dynamic> obj =
      ModalRoute.of(context!)!.settings.arguments as Map<String, dynamic>;

  return ChangeNotifierProvider<PaymentProvider>(
      create: (context) => PaymentProvider(productDetails: obj),
      child: PaymentPage());
});

var loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String obj = ModalRoute.of(context!)!.settings.arguments as String;

  return ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(productDetails: obj),
      child: const Login());
});

var orderPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ChangeNotifierProvider<OrderProvider>(
      create: (context) => OrderProvider(), child: const OrderPage());
});

var viewAllProductsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String obj = ModalRoute.of(context!)!.settings.arguments as String;

  return ChangeNotifierProvider<ViewAllProductsProvider>(
      create: (context) => ViewAllProductsProvider(category: obj),
      child: const ViewAllProducts());
});

var imageZoomHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String obj = ModalRoute.of(context!)!.settings.arguments as String;

  return ChangeNotifierProvider<ImageZoomProvider>(
      create: (context) => ImageZoomProvider(url: obj), child: ImageZoom());
});

var paymentLoginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String obj = ModalRoute.of(context!)!.settings.arguments as String;

  return ChangeNotifierProvider<PaymentLoginProvider>(
      create: (context) => PaymentLoginProvider(productDetails: obj),
      child: PaymentLogin());
});

var homeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ChangeNotifierProvider<SearchModel>(
      create: (context) => SearchModel(), child: const Home());
});

var searchedProductHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  Place obj = ModalRoute.of(context!)!.settings.arguments as Place;

  return ChangeNotifierProvider<SearchedProductProvider>(
      create: (context) => SearchedProductProvider(productSelected: obj),
      child: const SearchedProducts());
});

// var onBoardingPageHandler = new Handler(
//     handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
//   return ChangeNotifierProvider<HomeProvider>(
//       create: (context) => HomeProvider(), child: MyApp());
// });
var productHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ChangeNotifierProvider<ProductPageProvider>(
      create: (context) => ProductPageProvider(), child: const ProductPage());
});

var wishListHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ChangeNotifierProvider<WishListProvider>(
      create: (context) => WishListProvider(), child: WishList());
});

var profilePageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ChangeNotifierProvider<ProfilePageProvider>(
      create: (context) => ProfilePageProvider(), child: ProfilePage());
});

var viewAllProductsByCategoryIconsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String obj = ModalRoute.of(context!)!.settings.arguments as String;

  return ChangeNotifierProvider<ViewAllProductsCategroyIconsProvider>(
      create: (context) => ViewAllProductsCategroyIconsProvider(category: obj),
      child: const ViewAllProductsCategoryIcons());
});

var raiseComplaintsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ChangeNotifierProvider<RaiseCompaintProvider>(
      create: (context) => RaiseCompaintProvider(), child: RaiseCompaintPage());
});

var sellProductsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ChangeNotifierProvider<SellYourProductsProvider>(
      create: (context) => SellYourProductsProvider(),
      child: SellYourProducts());
});
var posterClickHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  Map<String, dynamic>? obj =
      ModalRoute.of(context!)!.settings.arguments as Map<String, dynamic>;

  return ChangeNotifierProvider<PosterSelectedProvider>(
      create: (context) => PosterSelectedProvider(comeData: obj),
      child: const PosterSelectedPage());
});

// var weddingFunctionHandler = Handler(
//     handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
//   Map<String, dynamic> obj =
//       ModalRoute.of(context!)!.settings.arguments as Map<String, dynamic>;
//   return ChangeNotifierProvider<WeddingFunctionNeedToSendToHomeProvider>(
//       create: (context) =>
//           WeddingFunctionNeedToSendToHomeProvider(comeData: obj),
//       child: WeddingFunctionNeedToSendToHome());
// });

// var notificationHandler = Handler(
//     handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
//   return ChangeNotifierProvider<NotificationProvider>(
//       create: (context) => NotificationProvider(),
//       child: const NotificationPage());
// });

var paymentReciptHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ChangeNotifierProvider<PaymentReciptProvider>(
      create: (context) => PaymentReciptProvider(),
      child: const PaymentRecipt());
});

var viewBillsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ChangeNotifierProvider<ViewAllBillProvider>(
      create: (context) => ViewAllBillProvider(), child: const ViewAllBills());
});

var trackProductHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ChangeNotifierProvider<TrackProductProvider>(
      create: (context) => TrackProductProvider(), child: const TrackProduct());
});

var pdfBillViewHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String obj = ModalRoute.of(context!)!.settings.arguments as String;
  return ChangeNotifierProvider<PdfViewBillProvider>(
      create: (context) => PdfViewBillProvider(url: obj),
      child: const PdfViewBill());
});

var enquiryHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String obj = ModalRoute.of(context!)!.settings.arguments as String;
  return ChangeNotifierProvider<EnqueryProvider>(
      create: (context) => EnqueryProvider(details: obj),
      child: const EnquiryPage());
});

var suggestionHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ChangeNotifierProvider<SuggestionPageProvider>(
      create: (context) => SuggestionPageProvider(),
      child: const SuggestionPage());
});

var ordersAndReturnsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ChangeNotifierProvider<OrdersReturnsProvider>(
      create: (context) => OrdersReturnsProvider(),
      child: const OrdersReturnPage());
});

var ratingsPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  Map<String, dynamic>? obj =
      ModalRoute.of(context!)!.settings.arguments as Map<String, dynamic>;

  // String obj = ModalRoute.of(context!)!.settings.arguments as String;
  return ChangeNotifierProvider<RatingsProvider>(
      create: (context) => RatingsProvider(productId: obj),
      child: const RatingsPage());
});

var returnPolicyHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  Map<String, dynamic>? obj =
      ModalRoute.of(context!)!.settings.arguments as Map<String, dynamic>;

  // String obj = ModalRoute.of(context!)!.settings.arguments as String;
  return ChangeNotifierProvider<ReturnOrderProvider>(
      create: (context) => ReturnOrderProvider(orderString: obj),
      child: const ReturnOrderPage());
});

var allIconsDetailsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  Map<String, dynamic>? obj =
      ModalRoute.of(context!)!.settings.arguments as Map<String, dynamic>?;

  // String obj = ModalRoute.of(context!)!.settings.arguments as String;
  return ChangeNotifierProvider<AllCategoriesListProvider>(
      create: (context) => AllCategoriesListProvider(details: obj),
      child: AllCategoriesList());
});

var specificProductHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  Map<String, dynamic>? obj =
      ModalRoute.of(context!)!.settings.arguments as Map<String, dynamic>?;

  // String obj = ModalRoute.of(context!)!.settings.arguments as String;
  return ChangeNotifierProvider<SpecificProvider>(
      create: (context) => SpecificProvider(details: obj),
      child: const SpecificProductsFromIconsSelection());
});

// var webPaymnetsHandler = Handler(
//     handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
//   Map<String, dynamic>? obj =
//       ModalRoute.of(context!)!.settings.arguments as Map<String, dynamic>;
//   return ChangeNotifierProvider<WebPaymentsProvider>(
//       create: (context) => WebPaymentsProvider(argument: obj),
//       child: const WebPayments());
// });
