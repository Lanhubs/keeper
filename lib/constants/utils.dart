import 'package:get/get.dart';
import 'package:keeper/pages/auth/login.dart';
import 'package:keeper/pages/home/main_home.dart';
import 'package:keeper/pages/home/screens/addClient/add_client.dart';
import 'package:keeper/pages/home/screens/clients/clients.dart';
import 'package:keeper/pages/home/screens/invoice_details.dart';
import 'package:keeper/pages/home/screens/invoices/widgets/create_invoice_modal.dart';
import 'package:keeper/pages/splash.dart';

class AppRoutes {
  static const String home = '/home';
  static const String addClient = '/addClient';
  static const String login = '/login';
  static const String invoicePreview = '/invoicePreview';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String terms = '/terms';
  static const String privacy = '/privacy';
  static const String help = '/help';
  static const String feedback = '/feedback';
  static const String notifications = '/notifications';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String splash = '/splash';
  static const String clients = '/clients';
  static const String createInvoice = '/createInvoice';

  static List<GetPage> pages = [
    GetPage(name: splash, page: () => Splash()),
    GetPage(name: home, page: () => MainHome()),
    GetPage(name: addClient, page: () => AddClient()),
    GetPage(
      name: invoicePreview,
      page: () => const InvoiceDetails(),
    ), // Placeholder for invoice preview
    GetPage(name: login, page: () => const Login()),
    GetPage(name: clients, page: () =>  Clients()),
    GetPage(name: createInvoice, page: () =>  CreateInvoiceModal()),
    // GetPage(name: settings, page: () => const Settings()),
    // GetPage(name: terms, page: () => const Terms()),
    // GetPage(name: privacy, page: () => const Privacy()),
    // GetPage(name: help, page: () => const Help()),
    // GetPage(name: feedback, page: () => const Feedback()),
    // GetPage(name: notifications, page: () => const Notifications()),
    // GetPage(name: search, page: () => const Search()),
    // GetPage(name: favorites, page: () => const Favorites()),
  ];
}
