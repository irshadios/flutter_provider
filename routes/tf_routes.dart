import 'package:pureone/routes/route_handlers.dart';

import 'package:fluro/fluro.dart';

class TfRoutes {
  static FluroRouter? router;

  static const String root = "/";
  static const String login = '/login';
  static const String paymentLogin = '/payment_login';
  static const String dashboard = "/dashboard";
  static const String studentDashboard = "/student_dashboard";

  static const String uploadProduct = "/upload_product";
  static const String sellerDashboard = "/seller_dashboard";
  static const String searchedItemsList = "/searched_items_list";
  // static const String viewAllProducting = "/view_all_products";

  static const String paymentRecipt = "/payment_recipt";

  static const String paymentPage = "/paymentPage";

  static const String productDetailsPage = "/productDetailsPage";
  static const String orderPage = "/orderPage";

  static const String cart = "/cart";
  static const String viewAllProducts = "/viewAllProducts";

  static const String imageZoom = "/imageZoom";
  static const String home = "/home";
  static const String searchedItemsCategory = "/searchedItemsCategory";

  // static const String onBoardingPage = "/onBoardingPage";
  static const String wishList = "/wishList";

  static const String profilePage = "/profilePage";
  static const String orderOnBoarding = "/orderOnBoarding";
  static const String raiseComplaints = "/raiseComplaints";

  static const String productsPage = "/productsPage";
  static const String sellProducts = "/sellProducts";

  static const String posterClicked = "/posterClicked";
  static const String weddingFunction = "/weddingFunction";
  static const String notification = "/notification";

  static const String viewBills = "/viewBills";
  static const String trackProduct = "/track_product";
  static const String pdfBillView = "/pdf_bill_view";
  static const String suggestion = "/suggestion";

  static const String webPaymnets = "/web_payments";
  static const String enquiry = "/enquiry";

  static const String ordersAndReturns = "/orders_and_returns";
  static const String ratingsPage = "/ratings_page";

  static const String returnPolicy = "/return_policy";

  static const String allIconsDetails = "/all_icons_details";
  static const String specificProduct = "/specific_product";

  static const String viewAllProductsByCategoryIcons =
      "/viewAllProductsByCategoryIcons";

  static void configureRoutes(FluroRouter router) {
    router.define(root,
        handler: rootHandler, transitionType: TransitionType.inFromRight);

    router.define(productDetailsPage,
        handler: productDetailsPageHandler,
        transitionType: TransitionType.inFromRight);

    router.define(cart,
        handler: cartHandler, transitionType: TransitionType.inFromRight);

    router.define(paymentPage,
        handler: paymentHandler, transitionType: TransitionType.inFromRight);

    router.define(login,
        handler: loginHandler, transitionType: TransitionType.inFromRight);

    router.define(orderPage,
        handler: orderPageHandler, transitionType: TransitionType.inFromRight);

    router.define(viewAllProducts,
        handler: viewAllProductsHandler,
        transitionType: TransitionType.inFromRight);

    router.define(imageZoom,
        handler: imageZoomHandler, transitionType: TransitionType.fadeIn);

    router.define(paymentLogin,
        handler: paymentLoginHandler, transitionType: TransitionType.material);

    router.define(home,
        handler: homeHandler, transitionType: TransitionType.material);

    router.define(searchedItemsCategory,
        handler: searchedProductHandler,
        transitionType: TransitionType.material);

    // router.define(onBoardingPage,
    //     handler: onBoardingPageHandler,
    //     transitionType: TransitionType.material);

    router.define(wishList,
        handler: wishListHandler, transitionType: TransitionType.material);

    router.define(profilePage,
        handler: profilePageHandler, transitionType: TransitionType.material);

    router.define(viewAllProductsByCategoryIcons,
        handler: viewAllProductsByCategoryIconsHandler,
        transitionType: TransitionType.material);

    router.define(raiseComplaints,
        handler: raiseComplaintsHandler,
        transitionType: TransitionType.material);

    router.define(productsPage,
        handler: productHandler, transitionType: TransitionType.material);

    router.define(sellProducts,
        handler: sellProductsHandler, transitionType: TransitionType.material);

    router.define(posterClicked,
        handler: posterClickHandler, transitionType: TransitionType.material);

    // router.define(weddingFunction,
    //     handler: weddingFunctionHandler,
    //     transitionType: TransitionType.material);

    // router.define(notification,
    //     handler: notificationHandler, transitionType: TransitionType.material);

    router.define(paymentRecipt,
        handler: paymentReciptHandler, transitionType: TransitionType.material);

    router.define(viewBills,
        handler: viewBillsHandler, transitionType: TransitionType.material);

    router.define(trackProduct,
        handler: trackProductHandler, transitionType: TransitionType.material);

    router.define(pdfBillView,
        handler: pdfBillViewHandler, transitionType: TransitionType.material);

    router.define(enquiry,
        handler: enquiryHandler, transitionType: TransitionType.material);
    router.define(suggestion,
        handler: suggestionHandler, transitionType: TransitionType.material);

    router.define(ordersAndReturns,
        handler: ordersAndReturnsHandler,
        transitionType: TransitionType.material);

    router.define(ratingsPage,
        handler: ratingsPageHandler, transitionType: TransitionType.material);

    router.define(returnPolicy,
        handler: returnPolicyHandler, transitionType: TransitionType.material);

    router.define(allIconsDetails,
        handler: allIconsDetailsHandler,
        transitionType: TransitionType.material);

    router.define(specificProduct,
        handler: specificProductHandler,
        transitionType: TransitionType.material);

    // router.define(webPaymnets,
    //     handler: webPaymnetsHandler, transitionType: TransitionType.material);
  }
}
