# Restaurant POS Application - TANGO

## Overview
This is a comprehensive Android restaurant Point-of-Sale (POS) application built with Flutter, designed for waiters to take orders and manage tables. The app connects to a local SQL Server database and supports the complete order flow from login to order placement.

## Features Implemented

### 1. Login Screen
- **Numeric keypad** for password entry
- **Settings button** (gear icon) to configure database connection
- Password displayed as asterisks for security
- Validates user credentials from `dbo.USUARIOS` table
- Only allows login for users with `Es_camarero = 1`
- Checks for valid password/key (CLAVE field must not be empty)
- Shows "CLAVE NO REGISTRADA" error if authentication fails
- Stores waiter code (`CODIGO_CAMARERO`) for order tracking

### 2. Settings Screen
- **Database Configuration:**
  - Instance (server IP/hostname)
  - Database Name
  - Username
  - Password
  - Port (default: 1433)
- **TEST Connection** button to verify database connectivity
- **Save** button to persist configuration locally
- Configuration stored using SharedPreferences
- Shows success/error messages for connection test

### 3. Sections Screen (SECCIONES)
- Displays all active sections from `dbo.SECCIONES` table
- Only shows sections with `Activa = 1`
- Grid layout with color-coded section buttons
- Each section displays its name
- TANGO logo at top of screen
- Allows waiter to select a section to view its tables

### 4. Tables Screen (MESAS)
- Shows tables for selected section
- Grid layout with 4 columns
- **Color-coded table status:**
  - **Green**: Available (no order)
  - **Red**: Occupied (`ESTATUS = 1` in FACTURA_EN_ESPERA)
  - **Yellow**: About to be released (`ESTATUS = 2`)
- Displays table code and description
- Loads status from `FACTURA_EN_ESPERA` table
- Shows waiter information in bottom bar

### 5. Menu Categories Screen
- Displays menu categories from `dbo.MENU` table
- Grid layout showing all available menus
- Each menu button uses its configured color (`Color_Menu` field)
- TANGO logo and shopping cart icon at top
- Shows table and waiter information at bottom
- **RETORNAR** button to go back to tables

### 6. Products Screen
- Lists all products for selected menu category
- Loads from `dbo.PRODUCTOS` where `Codigo_Menu` matches
- Displays product name and price
- Color-coded based on menu category
- Click product to proceed to quantity selection

### 7. Quantity Input Screen
- **Large numeric keypad** for quantity entry
- Default quantity: 1
- Maximum 3 digits
- **AGREGAR** button to proceed
- **CANCELAR** button to go back
- Checks if product requires:
  - Terminación (cooking term)
  - Acompañamiento (side dish)
  - Salsa (sauce)
- Routes to appropriate screen based on product configuration

### 8. Terms/Accompaniments/Sauces Screen
- **Three sections:**
  - **TERMINO**: Cooking terms (Bien Cocido, Medio, ¾, Vuelta y Vuelta)
  - **GUARNICION**: Side dishes (Puré, Papas Fritas, Tostones, Ensalada Verde)
  - **SALSA**: Available sauces
- Only displays sections if product requires them:
  - `Tiene_Terminacion = 1`
  - `Tiene_Acompanamiento = 1`
  - `TIENE_SALSA = 1`
- Single selection for each category
- Selected items highlighted in orange
- **CONTINUAR** button to proceed to notes

### 9. Notes Screen
- **Silla Comensal (Seat Number):**
  - Number input with keypad (1-9)
  - Identifies which seat at table ordered item
- **Cantidad Vasos (Glass Count):**
  - Number input with keypad
  - Only for beverages
  - Shows "** SOLO SI ES BEBIDA" label
- **NOTA (Notes) text area:**
  - Free-form text input
  - Special instructions for kitchen
- **CONTINUAR** button to save order

### 10. Order Management
- **Creates or updates FACTURA_EN_ESPERA:**
  - One per table/section combination
  - Stores waiter code, table, section, status
  - Status 1 = occupied (red), Status 2 = about to release (yellow)
- **Adds items to FACTURAS_EN_ESPERA_DETALLE:**
  - Product code and name
  - Quantity and price
  - Subtotal calculation
  - Selected terminación, acompañamiento, salsa
  - Notes
  - Seat number (Silla_Comensal)
  - Glass count (Cantidad_Vasos)
- Returns to menu screen after successful save

## Database Structure Required

### dbo.USUARIOS
```sql
- Codigo_Acceso (String) - Login code
- Clave (String) - Password/key
- Nombre_Usuario (String) - Waiter name
- Codigo_Camarero (String) - Waiter code for orders
- Es_camarero (Int) - 1 = waiter, 0 = other
- Tarjeta_Admin (Int) - Admin access flag
```

### dbo.SECCIONES
```sql
- Codigo (String) - Section code
- Nombre (String) - Section name (e.g., SALON, TERRAZA, BAR, BALCON, PISCINA, BILLAR, 2DO NIVEL)
- Activa (Int) - 1 = active, 0 = inactive
```

### dbo.MESAS
```sql
- Codigo (String) - Table number/code
- Codigo_Zona (String) - Section code (FK to SECCIONES)
- Descripcion_MESA (String) - Table description
- Activa (Int) - 1 = active, 0 = inactive
```

### dbo.MENU
```sql
- Codigo (String) - Menu code
- Nombre_menu (String) - Menu name (e.g., ENTRADAS, CARNES, PARRILLADA, COMBOS, VINOS, BEBIDAS, TACOS, BURGER, JUGOS, PAELLA, RAVIOLI, SUSHI, PASTAS, CAVAS, PASTEL, AREPAS, PEQUES, POSTRES)
- Color_Menu (String) - Hex color code (e.g., #FF6B00)
```

### dbo.PRODUCTOS
```sql
- Codigo (String) - Product code
- Nombre (String) - Product name
- Codigo_Menu (String) - Menu code (FK)
- Precio (Decimal) - Product price
- Tiene_Acompanamiento (Int) - 1 = requires side dish
- Tiene_Terminacion (Int) - 1 = requires cooking term
- Tiene_Mezcla (Int) - 1 = requires mix
- TIENE_SALSA (Int) - 1 = requires sauce
```

### dbo.TERMINACION_PRODUCTOS
```sql
- Codigo (String) - Term code
- Nombre (String) - Term name (e.g., BIEN COCIDO, TERMINO MEDIO, ¾, VUELTA Y VUELTA)
```

### dbo.Acompanamientos
```sql
- Codigo (String) - Side dish code
- Nombre (String) - Side dish name (e.g., PURE, PAPAS FRITAS, TOSTONES, ENSALADA VERDE)
```

### dbo.Salsas
```sql
- Codigo (String) - Sauce code
- Nombre (String) - Sauce name
```

### dbo.FACTURA_EN_ESPERA
```sql
- Id (String/Int) - Primary key (auto-generated)
- Codigo_Vendedor (String) - Waiter code
- Codigo_Mesa (String) - Table code
- Codigo_Zona (String) - Section code
- ESTATUS (Int) - 1 = occupied (red), 2 = about to release (yellow)
- Fecha_Creacion (DateTime) - Order creation timestamp
```

### dbo.FACTURAS_EN_ESPERA_DETALLE (implied name)
```sql
- Id (String/Int) - Primary key
- Factura_Id (String) - FK to FACTURA_EN_ESPERA
- Codigo_Producto (String) - Product code
- Nombre_Producto (String) - Product name
- Cantidad (Int) - Quantity ordered
- Precio (Decimal) - Unit price
- Subtotal (Decimal) - Calculated total
- Terminacion (String) - Cooking term selected
- Acompanamiento (String) - Side dish selected
- Salsa (String) - Sauce selected
- Nota (String) - Special notes
- Silla_Comensal (Int) - Seat number
- Cantidad_Vasos (Int) - Number of glasses
```

## Technical Stack

### Frontend
- **Flutter** (Dart) - Cross-platform UI framework
- **GetX** - State management, routing, and dependency injection
- **flutter_screenutil** - Responsive UI sizing

### Backend/Database
- **mssql_connection** - SQL Server connectivity
- **SQL Server** (Local) - Database system

### Storage
- **shared_preferences** - Local configuration storage

### UI/UX
- **Material Design** - UI components
- Custom numeric keypads
- Color-coded status indicators
- Responsive grid layouts

## Application Flow

```
Login (Keypad) 
    ↓
Settings (if needed)
    ↓
Sections (Select Restaurant Area)
    ↓
Tables (Select Table - Color Status)
    ↓
Menu Categories (Select Category)
    ↓
Products (Select Product)
    ↓
Quantity Input (Numeric Keypad)
    ↓
Terms/Sides/Sauces (If Required)
    ↓
Notes + Seat + Glasses
    ↓
Save to FACTURA_EN_ESPERA
    ↓
Back to Menu (Continue Ordering)
```

## Key Business Rules

1. **Only waiters can login**: `Es_camarero = 1` required
2. **One order per table**: Single FACTURA_EN_ESPERA per table/section
3. **Table status colors**:
   - Green = Available (no pending order)
   - Red = Occupied (order exists, status = 1)
   - Yellow = About to release (order exists, status = 2)
4. **Admin restriction**: Only users with `Tarjeta_Admin = 1` can open tables not assigned to them
5. **Active filtering**: Only active sections and tables are displayed
6. **Menu matching**: Products filtered by menu code, displayed in menu color
7. **Optional fields**: Terms, sides, sauces only required if product flags are set
8. **Seat tracking**: Identifies which person at table ordered each item
9. **Order accumulation**: Multiple items added to same FACTURA_EN_ESPERA
10. **Waiter tracking**: All orders tagged with waiter code for accountability

## Installation & Setup

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Configure SQL Server:**
   - Ensure SQL Server is running
   - Create database with required tables
   - Note server IP, database name, credentials

3. **Run application:**
   ```bash
   flutter run
   ```

4. **First-time setup:**
   - Click settings icon on login screen
   - Enter database configuration
   - Test connection
   - Save configuration
   - Return to login

5. **Login:**
   - Enter waiter access code using numeric keypad
   - Press login button

## Notes for Deployment

- SQL Server must be accessible from the device network
- Default SQL Server port is 1433
- Ensure firewall allows connections
- Database user needs read/write permissions
- Consider implementing SSL for production
- Images folder exists at `assets/images/` for future logo assets
- Application supports both Spanish interface matching requirements

## Color Codes & Branding

- **TANGO Brand**: Orange circle logo (🟠)
- **Menu colors**: Stored in database per menu category
- **Status colors**:
  - Green: Available tables
  - Red: Occupied tables
  - Yellow: Tables about to be released
  - Orange: Section headers and selected items

## Future Enhancements (Not Implemented)

- View existing order details before modification
- Delete/modify items in pending order
- Print order to kitchen
- Close/finalize order (move to completed orders)
- Multiple orders per table (different seats)
- Order history and reporting
- User permission management
- Offline mode with sync
- Multi-language support beyond Spanish
- Table reservation system
- Payment processing integration
