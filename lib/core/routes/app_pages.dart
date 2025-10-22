import 'package:get/get.dart';
import 'package:restaurant_demo/features/menu/screen/premium_menu_screen.dart';

import '../../features/auth/login/binding/new_login_binding.dart';
import '../../features/auth/login/screen/premium_login_screen.dart';
import '../../features/database_connection/binding/database_connection_binding.dart';
import '../../features/database_connection/screen/database_connection_screen.dart';
import '../../features/menu/binding/menu_binding.dart';
import '../../features/notes/binding/notes_binding.dart';
import '../../features/notes/screen/premium_notes_screen.dart';
import '../../features/products/binding/products_binding.dart';
import '../../features/products/screen/premium_products_screen.dart';
import '../../features/quantity/binding/quantity_binding.dart';
import '../../features/quantity/screen/premium_quantity_screen.dart';
import '../../features/sections/binding/sections_binding.dart';
import '../../features/sections/screen/premium_sections_screen.dart';
import '../../features/settings/binding/settings_binding.dart';
import '../../features/settings/screen/settings_screen.dart';
import '../../features/tables/binding/tables_binding.dart';
import '../../features/tables/screen/premium_tables_screen.dart';
import '../../features/terms/binding/terms_binding.dart';
import '../../features/terms/screen/premium_terms_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => const PremiumLoginScreen(),
      binding: NewLoginBinding(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes.databaseConnection,
      page: () => const DatabaseConnectionScreen(),
      binding: DatabaseConnectionBinding(),
    ),
    GetPage(
      name: AppRoutes.sections,
      page: () => const PremiumSectionsScreen(),
      binding: SectionsBinding(),
    ),
    GetPage(
      name: AppRoutes.tables,
      page: () => const PremiumTablesScreen(),
      binding: TablesBinding(),
    ),
    GetPage(name: AppRoutes.menu, page: () => const PremiumMenuScreen(), binding: MenuBinding()),
    GetPage(
      name: AppRoutes.products,
      page: () => const PremiumProductsScreen(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: AppRoutes.quantity,
      page: () => const PremiumQuantityScreen(),
      binding: QuantityBinding(),
    ),
    GetPage(name: AppRoutes.terms, page: () => const PremiumTermsScreen(), binding: TermsBinding()),
    GetPage(name: AppRoutes.notes, page: () => const PremiumNotesScreen(), binding: NotesBinding()),
  ];
}
