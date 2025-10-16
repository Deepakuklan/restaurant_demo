# Localization Guide

## Overview
The application now supports multi-language functionality with all hardcoded strings moved to JSON translation files.

## Translation Files

### Location
- **English**: `assets/locales/en.json`
- **Spanish**: `assets/locales/es.json`

### Current Languages
- **English (en_US)**: Default fallback language
- **Spanish (es_ES)**: Primary language for the application

## How to Use Translations in Code

### 1. Import GetX
```dart
import 'package:get/get.dart';
```

### 2. Using Translation Keys

#### Simple Translation
```dart
Text('key'.tr)
```

**Example:**
```dart
Text('login'.tr)  // Shows "login" in Spanish or "Login" in English
```

#### With Named Parameters
For translations with placeholders like `{error}`, use:
```dart
Text('connection_error'.trParams({'error': errorMessage}))
```

**Example:**
```dart
Get.snackbar(
  'error'.tr,
  'connection_error'.trParams({'error': e.toString()}),
);
```

### 3. Using AppStrings Constants

Import the constants file:
```dart
import 'package:restaurant_demo/core/constants/app_strings.dart';
```

Then use:
```dart
Text(AppStrings.login.tr)
Text(AppStrings.configuration.tr)
Text(AppStrings.connectionError.trParams({'error': 'Network error'}))
```

**Benefits:**
- Type-safe: Autocomplete and compile-time checking
- Refactoring-friendly: Easy to find all uses of a key
- No typos: IDE will catch incorrect key names

## Translation Key Categories

### App & Common
- `app_name` - Application name (TANGO)
- `login`, `cancel`, `save`, `error`, `success`, `loading`, `continue`

### Settings Screen
- `configuration`, `instance`, `database_name_label`, `user`, `password_label`, `port`
- `test_connection`, `connection_successful`, `configuration_saved`

### Login Screen
- `enter_access_code`, `key_not_registered`

### Sections Screen
- `sections`, `no_active_sections`, `load_sections_error`

### Tables Screen
- `tables_title`, `tables_section`, `no_tables_section`
- `table`, `waiter`, `return`

### Menu Screen
- `menu`, `no_menus`, `load_menus_error`

### Products Screen
- `products`, `no_products_menu`, `load_products_error`

### Quantity Screen
- `enter_quantity`, `add`, `quantity_greater_zero`

### Terms/Garnish/Sauce Screen
- `selection`, `term`, `garnish`, `sauce`

### Notes Screen
- `seat_diner`, `seat_number`, `glass_count`, `only_if_beverage`
- `note`, `enter_note_here`, `product_added`

## Examples from Codebase

### Settings Screen
```dart
// Before
Text('Configuración')

// After
Text(AppStrings.configuration.tr)
```

### Error Messages
```dart
// Before
Get.snackbar('Error', 'Error al cargar secciones: ${e.toString()}');

// After
Get.snackbar(
  AppStrings.error.tr,
  AppStrings.loadSectionsError.trParams({'error': e.toString()}),
);
```

### Button Labels
```dart
// Before
ElevatedButton(
  onPressed: controller.saveConfig,
  child: Text('Guardar'),
)

// After
ElevatedButton(
  onPressed: controller.saveConfig,
  child: Text(AppStrings.save.tr),
)
```

## Adding New Translations

### Step 1: Add to JSON Files

**en.json:**
```json
{
  "new_key": "English text"
}
```

**es.json:**
```json
{
  "new_key": "Texto en español"
}
```

### Step 2: Add to AppStrings
```dart
class AppStrings {
  static const String newKey = 'new_key';
}
```

### Step 3: Use in Code
```dart
Text(AppStrings.newKey.tr)
```

## Translations with Placeholders

For dynamic content, use `{placeholder}` syntax:

**JSON:**
```json
{
  "welcome_user": "Welcome, {name}!",
  "items_count": "You have {count} items"
}
```

**Code:**
```dart
Text('welcome_user'.trParams({'name': userName}))
Text('items_count'.trParams({'count': '5'}))
```

## Changing Language at Runtime

```dart
// Switch to English
Get.updateLocale(const Locale('en', 'US'));

// Switch to Spanish
Get.updateLocale(const Locale('es', 'ES'));
```

## Current Default Language

The app is set to Spanish (`es_ES`) as the primary language with English (`en_US`) as fallback.

**In main.dart:**
```dart
locale: const Locale('es', 'ES'),
fallbackLocale: const Locale('en', 'US'),
```

## File Structure

```
assets/
└── locales/
    ├── en.json  (85 translation keys)
    └── es.json  (85 translation keys)

lib/
└── core/
    ├── constants/
    │   └── app_strings.dart  (All translation key constants)
    └── localization/
        └── app_translations.dart  (JSON loader)
```

## Benefits of This Approach

1. **Centralized Translations**: All strings in one place
2. **Easy Maintenance**: Update translations without touching code
3. **Type Safety**: Use constants to avoid typos
4. **Scalability**: Easy to add new languages
5. **Professional**: Industry-standard localization approach
6. **Testing Friendly**: Can mock translations easily

## Best Practices

1. ✅ **Always use `.tr`** - Never use hardcoded strings
2. ✅ **Use AppStrings constants** - Better than raw strings
3. ✅ **Keep keys lowercase with underscores** - Consistent naming
4. ✅ **Group related keys** - Organize by screen/feature
5. ✅ **Use placeholders for dynamic content** - `{placeholder}` syntax
6. ✅ **Add both languages** - Every key in en.json and es.json

## Common Patterns

### Snackbar Messages
```dart
Get.snackbar(
  AppStrings.error.tr,
  AppStrings.connectionError.trParams({'error': errorMsg}),
  backgroundColor: Colors.red,
  colorText: Colors.white,
);
```

### AppBar Title
```dart
AppBar(
  title: Text(AppStrings.configuration.tr),
)
```

### Button Text
```dart
ElevatedButton(
  onPressed: onPressed,
  child: Text(AppStrings.save.tr),
)
```

### Loading State
```dart
if (controller.isLoading.value) {
  return Center(
    child: Text(AppStrings.loading.tr),
  );
}
```

### Empty State
```dart
if (controller.items.isEmpty) {
  return Center(
    child: Text(AppStrings.noActiveSections.tr),
  );
}
```

## Migration Checklist

- [x] Created en.json and es.json files
- [x] Added all 85+ translation keys
- [x] Created AppStrings constants class
- [x] Created AppTranslations loader
- [x] Updated main.dart to load translations
- [x] Set Spanish as default language
- [ ] Replace hardcoded strings in all screens (Next step)
- [ ] Test language switching
- [ ] Add more languages if needed

## Next Steps

To complete the migration, replace all hardcoded strings in the following files:
- `lib/features/auth/login/screen/new_login_screen.dart`
- `lib/features/settings/screen/settings_screen.dart`
- `lib/features/sections/screen/sections_screen.dart`
- `lib/features/tables/screen/tables_screen.dart`
- `lib/features/menu/screen/menu_screen.dart`
- `lib/features/products/screen/products_screen.dart`
- `lib/features/quantity/screen/quantity_screen.dart`
- `lib/features/terms/screen/terms_screen.dart`
- `lib/features/notes/screen/notes_screen.dart`

And their corresponding controllers for error messages and snackbars.
