# TANGO Restaurant POS - Demo

## What It Does

Point-of-sale system for restaurants. Take orders, customize items, calculate taxes automatically.

---

## Current Features

| Feature | What You Get |
|---------|--------------|
| Login | PIN-based waiter access |
| Sections | 5 areas (Salon, Terraza, Bar, Balcon, Piscina) |
| Tables | 44 total, color-coded status |
| Menus | 6 categories with custom colors |
| Products | 9 sample items ($2.50-$25.00) |
| Ordering | Full customization (cooking, sides, sauces) |
| Notes | Seat numbers, special requests |
| Taxes | Auto-calculated (18% ITBIS + 10% LEY) |
| Database | SQLite, works offline |

---

## Demo Flow

```
Login (1234) → Pick Section → Choose Table → Select Menu → 
Pick Product → Set Quantity → Customize → Add Notes → Save
```

**Time:** About 30 seconds per item

---

## Sample Order

**2× Filete de Res** @ $18.50

```
Subtotal:    $37.00
ITBIS (18%): $6.66
LEY (10%):   $3.70
Total:       $47.36
```

All calculated automatically.

---

## What's Not Here Yet

Cart/review screen, modify items, delete items, kitchen integration, payments, reports.

---

## Tech Stack

- Flutter (runs everywhere)
- SQLite (local database)
- Spanish/English ready
- Works 100% offline

---

## Talking Points

**For small restaurants:** "No setup needed, works right away"  
**For chains:** "Can scale to SQL Server for multi-location"  
**For investors:** "Modern tech stack, production-ready"

---

## Show

1. Login screen (10 sec)
2. Pick section & table (10 sec)
3. Browse menus (15 sec)
4. Place an order (30 sec)
5. Show tax calculation (10 sec)

**Total demo: 75 seconds**

---

## The Pitch

Works now. Scales later. No internet needed. Fast and simple.

**Questions?** Just ask.
