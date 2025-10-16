# TANGO Restaurant POS - Demo Guide

## Quick Start

Login with code **1234** and you're in.

## What's Working

**Login** - PIN code access for waiters

**Sections** - 5 areas with 44 tables total:
- SALON (12 tables)
- TERRAZA (10 tables)
- BAR (8 tables)
- BALCON (6 tables)
- PISCINA (8 tables)

**Tables** - Color coded status (green=free, red=busy)

**Menus** - 6 categories with different colors:
ENTRADAS • CARNES • PARRILLADA • BEBIDAS • POSTRES • PASTAS

**Products** - Browse and select items with prices

**Quantity** - Numeric keypad to enter amount

**Options** - Customize your order:
- Cooking level (Well done, Medium, Rare, etc.)
- Side dishes (Fries, Mashed potato, Salad, etc.)
- Sauces (BBQ, Mushroom, Spicy, Garlic)

**Notes** - Add seat number and special requests

**Taxes** - Automatic calculation (18% ITBIS + 10% LEY)

---

## Try It Out

**Quick test:**
Login (1234) → SALON → M1 → CARNES → Filete de Res ($18.50) → Qty: 2 → Medium/Fries/Mushroom Sauce → Seat 3, "No onions" → Save

**Result:** $37.00 + taxes ($6.66 ITBIS + $3.70 LEY) = **$47.36 total**

---

## What's Missing

Not in this demo: Cart review, modify/delete items, kitchen integration, payments, receipts, reports.

What works: Everything from login to saving orders with full tax calculations.

---

## Demo Data

Login: 1234  
5 sections, 44 tables, 6 menus, 9 products  
Prices range from $2.50 to $25.00

---

## Tech Notes

SQLite database, works offline, Spanish/English, runs on Android/iOS/Desktop.
Taxes: 18% ITBIS + 10% LEY.

---

## Common Questions

**Reset data?** Reinstall the app.  
**Add products?** Contact dev team.  
**Works offline?** Yes, 100%.  
**Multiple waiters?** Yes, each has own PIN.

---

**That's it. Simple, fast, works.**
