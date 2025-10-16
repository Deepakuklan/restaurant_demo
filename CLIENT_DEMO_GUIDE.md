# 🍽️ TANGO Restaurant POS - Demo Guide

## 📱 Quick Start Guide

### How to Login
1. Open the app
2. Enter access code: **1234**
3. Press the green **"login"** button

---

## ✅ Current Features (Available in Demo)

### 1️⃣ **Waiter Login**
- Secure PIN-based login
- Numeric keypad for easy access
- Clear and backspace buttons

### 2️⃣ **Section Selection**
Choose from 5 restaurant sections:
- **SALON** - 12 tables (M1-M12)
- **TERRAZA** - 10 tables (T1-T10)
- **BAR** - 8 tables (B1-B8)
- **BALCON** - 6 tables (BL1-BL6)
- **PISCINA** - 8 tables (P1-P8)

**Total: 44 tables across all sections**

### 3️⃣ **Table Management**
- View all tables in selected section
- Color-coded table status:
  - 🟢 **Green** - Available
  - 🔴 **Red** - Occupied
  - 🟡 **Yellow** - Reserved
- Table information displayed
- Waiter name shown

### 4️⃣ **Menu Categories**
6 colorful menu categories:
- **ENTRADAS** (Appetizers) - Orange
- **CARNES** (Meats) - Brown
- **PARRILLADA** (Grill) - Red
- **BEBIDAS** (Drinks) - Blue
- **POSTRES** (Desserts) - Gold
- **PASTAS** (Pastas) - Green

### 5️⃣ **Product Selection**
Browse products by menu:
- View product names
- See prices
- Select items to order

### 6️⃣ **Quantity Entry**
- Easy numeric keypad
- Enter quantity (1-99)
- Clear or backspace functions
- Visual quantity display

### 7️⃣ **Product Customization**
For applicable items, select:

**Cooking Terms** (TERMINO):
- BIEN COCIDO (Well done)
- TERMINO MEDIO (Medium)
- ¾ (Medium-rare)
- VUELTA Y VUELTA (Rare)

**Side Dishes** (GUARNICION):
- PURE (Mashed potatoes)
- PAPAS FRITAS (French fries)
- TOSTONES (Fried plantains)
- ENSALADA VERDE (Green salad)

**Sauces** (SALSA):
- SALSA BBQ
- SALSA DE CHAMPIÑONES (Mushroom sauce)
- SALSA PICANTE (Hot sauce)
- SALSA DE AJO (Garlic sauce)

### 8️⃣ **Order Notes**
Add detailed information:
- **Seat Number** - Which seat ordered (Silla Comensal)
- **Glass Count** - For beverages only (Cantidad Vasos)
- **Special Notes** - Custom instructions (e.g., "Sin cebolla" - No onions)

### 9️⃣ **Automatic Calculations**
The system automatically calculates:
- **Subtotal** - Product price × Quantity
- **ITBIS Tax** - 18% on each item
- **LEY Tax** - 10% on each item
- **Total Line** - Complete price with taxes
- **Invoice Total** - Sum of all items with taxes

---

## 🎯 Sample Order Flow

### Step-by-Step Example:

1. **Login**: Enter `1234`

2. **Select Section**: Choose "SALON"

3. **Select Table**: Choose "M1"

4. **Select Menu**: Choose "CARNES" (Meats)

5. **Select Product**: "Filete de Res" - $18.50

6. **Enter Quantity**: Type `2` on keypad

7. **Customize Product**:
   - Cooking: "TERMINO MEDIO" (Medium)
   - Side: "PAPAS FRITAS" (Fries)
   - Sauce: "SALSA DE CHAMPIÑONES" (Mushroom)

8. **Add Notes**:
   - Seat: `3`
   - Note: "Sin cebolla" (No onions)

9. **Save Order**: Press "CONTINUAR"

10. **Order Saved!** ✅

---

## 💰 Pricing Example

**Order**: 2 × Filete de Res @ $18.50

```
Price per item:     $18.50
Quantity:           × 2
Subtotal:           $37.00

ITBIS (18%):        $6.66
LEY (10%):          $3.70
──────────────────────────
TOTAL:              $47.36
```

---

## 📊 Current Limitations (Demo Version)

### ⚠️ Not Yet Implemented:
- ❌ Order Review/Cart Screen
- ❌ Modify order items
- ❌ Delete items from order
- ❌ View pending orders
- ❌ Send order to kitchen
- ❌ Payment processing
- ❌ Print receipts
- ❌ Sales reports

### ✅ What IS Working:
- ✅ Login system
- ✅ Section & table selection
- ✅ Menu browsing
- ✅ Product selection
- ✅ Quantity entry
- ✅ Product customization
- ✅ Order notes
- ✅ Tax calculations
- ✅ Data storage in database

---

## 🗄️ Database Information

### Pre-loaded Demo Data:

**1 Test User:**
- Access Code: 1234
- Name: Demo Waiter

**5 Sections:**
- SALON, TERRAZA, BAR, BALCON, PISCINA

**44 Tables:**
- Distributed across all sections

**6 Menu Categories:**
- ENTRADAS, CARNES, PARRILLADA, BEBIDAS, POSTRES, PASTAS

**9 Sample Products:**
- Ensalada César ($8.50)
- Sopa de Cebolla ($6.00)
- Filete de Res ($18.50)
- Pollo Asado ($14.00)
- Parrillada Mixta ($25.00)
- Coca Cola ($2.50)
- Jugo Natural ($3.50)
- Tiramisú ($5.50)
- Pasta Carbonara ($12.00)

---

## 🔧 Technical Details (For Reference)

### Database:
- **Type**: SQLite (Local database)
- **Location**: Stored on device
- **Configuration**: No setup required
- **Data**: Pre-loaded sample data

### Features:
- **Language**: Spanish (Default)
- **Currency**: USD ($)
- **Tax Rates**: 
  - ITBIS: 18%
  - LEY: 10%

### Supported Platforms:
- ✅ Android
- ✅ iOS
- ✅ Desktop (macOS, Windows, Linux)

---

## 🎨 User Interface

### Color Scheme:
- **Primary**: Light Blue
- **Sections**: Gray tones
- **Success**: Green
- **Error**: Red
- **Warning**: Orange
- **Menu Categories**: Custom colors per category

### Navigation:
- **Back Button**: Return to previous screen
- **RETORNAR**: Return to tables
- **Clear Buttons**: Reset input
- **Save/Continue**: Proceed to next step

---

## 📝 Next Steps (Roadmap)

### Phase 1: Order Management ⏳
- View all items in current order
- Modify quantities
- Delete items
- See running total with taxes

### Phase 2: Kitchen Integration ⏳
- Send orders to kitchen
- Print kitchen tickets
- Order status tracking

### Phase 3: Payment Processing ⏳
- Calculate final bill
- Process payments
- Print customer receipts

### Phase 4: Reporting ⏳
- Daily sales reports
- Waiter performance
- Popular items analysis

---

## ❓ FAQs

**Q: How do I reset the database?**
A: Uninstall and reinstall the app.

**Q: Can I add more products?**
A: Currently pre-loaded. Contact developer to add more.

**Q: What happens if I close the app mid-order?**
A: Orders are saved immediately to the database.

**Q: Can multiple waiters use the same device?**
A: Yes, each waiter has their own login code.

**Q: Where are orders stored?**
A: Locally on the device in SQLite database.

**Q: Does it work offline?**
A: Yes! 100% offline - no internet required.

---

## 🎉 Demo Highlights

### ✨ Key Features Demonstrated:
1. ✅ **Quick Login** - PIN-based security
2. ✅ **Multi-section Support** - 5 areas, 44 tables
3. ✅ **Rich Menu System** - 6 categories, colorful
4. ✅ **Product Customization** - Terms, sides, sauces
5. ✅ **Smart Calculations** - Automatic taxes
6. ✅ **Order Details** - Seat numbers, notes
7. ✅ **Multilingual Ready** - Spanish/English support
8. ✅ **Professional UI** - Modern, easy to use

---

## 📞 Support

**Demo Version**: 1.0
**Last Updated**: October 2025

For questions or feedback, contact your development team.

---

## 🚀 Ready to Test!

**Login**: `1234`

**Try ordering:**
1. SALON → M1
2. CARNES → Filete de Res
3. Quantity: 2
4. Add customization
5. Save and see it work!

---

**Enjoy the TANGO Restaurant POS Demo!** 🎉
