# ✅ Complete Database Schema - Matching Images

## Table: FACTURA_EN_ESPERA (Invoice Header)

Based on Image 2, this table needs ALL these fields:

```sql
CREATE TABLE FACTURA_EN_ESPERA (
  Id TEXT PRIMARY KEY,
  FACTURA_NO INTEGER,                    -- Sequence number (auto)
  FECHA_FACTURA TEXT,                    -- Invoice date
  CODIGO_CLIENTE INTEGER DEFAULT 1,     -- Always 1
  COBRAITBIS INTEGER DEFAULT 1,          -- Charges ITBIS (1=yes)
  ITBIS_COBRADO REAL DEFAULT 0,          -- 18% tax calculated
  SUBTOTAL_FACTURA REAL DEFAULT 0,       -- Sum of products
  ABONADO_FACTURA REAL DEFAULT 0,        -- Amount paid
  BALANCE_PENDIENTE REAL DEFAULT 0,      -- Pending balance
  NO_CAJA INTEGER DEFAULT 1,             -- Cash register number
  USUARIO TEXT,                          -- Waiter login name
  CODIGO_APERTURA_CAJA INTEGER DEFAULT 1, -- Cash opening code
  Valor_Factura REAL DEFAULT 0,          -- Total order value
  IMPUESTO_LEY REAL DEFAULT 10,          -- 10% tax rate
  IMPUESTO_LEY_COBRADO REAL DEFAULT 0,   -- 10% tax calculated
  Codigo_Mesa TEXT,                      -- Table code
  Codigo_Zona TEXT,                      -- Section code
  Estatus INTEGER DEFAULT 1,             -- 1=occupied
  Codigo_Vendedor TEXT,                  -- Waiter code
  Hora TEXT,                             -- Time "hh:mm:ss AMPM"
  Fecha_Creacion TEXT                    -- Creation timestamp
)
```

## Table: FACTURAS_EN_ESPERA_DETALLE (Order Details)

Based on Image 1, this table needs ALL these fields:

```sql
CREATE TABLE FACTURAS_EN_ESPERA_DETALLE (
  Id TEXT PRIMARY KEY,
  Factura_Id TEXT,                       -- FK to master
  FACTURA_NO INTEGER,                    -- Master invoice number
  CODIGO_PRODUCTO TEXT,                  -- Product code
  Nombre_Producto TEXT,                  -- Product name (marked)
  PRECIO_VENTA REAL,                     -- Sale price from products table
  CANTIDAD INTEGER,                      -- Quantity selected
  SUBTOTAL REAL,                         -- Price * Quantity
  TIPO_PRODUCTO TEXT DEFAULT 'P',       -- Always 'P'
  Monto_Itbis REAL DEFAULT 0,            -- 18% of price
  Monto_Ley REAL DEFAULT 0,              -- 10% of price
  Codigo_Companana TEXT,                 -- Accompaniment CODE (not name!)
  Codigo_Termino TEXT,                   -- Cooking term CODE (not name!)
  Total_Linea REAL,                      -- Sum of all the above
  SECUENCIA_PRODUCTO INTEGER,            -- Order sequence in table
  Hora TEXT,                             -- Time registered
  Codigo_Salsa TEXT,                     -- Sauce CODE (not name!)
  Codigo_Mezcla TEXT,                    -- Mix code for beverages
  Nota_Producto TEXT,                    -- Note without onion, etc.
  Silla_Ordeno INTEGER,                  -- Seat that ordered (#silla)
  Cantidad_vasos INTEGER,                -- Glasses count for beverages
  Eliminado INTEGER DEFAULT 0            -- 0=active, 1=deleted
)
```

## ⚠️ Critical Differences from Current Implementation

### 1. **Tax Calculations Required**
- **ITBIS** = 18% tax
- **LEY** = 10% tax  
- Both calculated on each line item
- Totals summed at invoice level

### 2. **Store CODES not NAMES**
- ❌ Wrong: `Terminacion = "BIEN COCIDO"`
- ✅ Correct: `Codigo_Termino = "T001"`
  
- ❌ Wrong: `Salsa = "SALSA BBQ"`
- ✅ Correct: `Codigo_Salsa = "SA001"`

- ❌ Wrong: `Acompanamiento = "PAPAS FRITAS"`
- ✅ Correct: `Codigo_Companana = "A002"`

### 3. **Time Format**
- Format: `"hh:mm:ss AMPM"`
- Example: `"03:45:30 PM"`

### 4. **Sequence Numbers**
- `FACTURA_NO` = Sequential invoice number (auto-increment)
- `SECUENCIA_PRODUCTO` = Order of items in the order (1, 2, 3...)

### 5. **Invoice Totals Calculation**
```
For each line item:
  PRECIO_VENTA = product price
  SUBTOTAL = PRECIO_VENTA * CANTIDAD
  Monto_Itbis = PRECIO_VENTA * 0.18
  Monto_Ley = PRECIO_VENTA * 0.10
  Total_Linea = SUBTOTAL + (Monto_Itbis * CANTIDAD) + (Monto_Ley * CANTIDAD)

For invoice header:
  SUBTOTAL_FACTURA = SUM(all line SUBTOTAL)
  ITBIS_COBRADO = SUM(all line Monto_Itbis * CANTIDAD)
  IMPUESTO_LEY_COBRADO = SUM(all line Monto_Ley * CANTIDAD)
  Valor_Factura = SUBTOTAL_FACTURA + ITBIS_COBRADO + IMPUESTO_LEY_COBRADO
  BALANCE_PENDIENTE = Valor_Factura - ABONADO_FACTURA
```

### 6. **Field Name Consistency**
Note the inconsistencies in the schema:
- Master uses `Codigo_Mesa`, `Codigo_Zona`, `Estatus` (capital E)
- Detail uses `Codigo_Companana` (with 'a'), `Silla_Ordeno`, `Cantidad_vasos` (lowercase v)

## ✅ Action Items

1. ✅ Update `sqlite_database_service.dart` - Add all missing fields
2. ⚠️ Update `factura_en_espera_model.dart` - Add all new fields
3. ⚠️ Update `factura_detalle_model.dart` - Add all new fields  
4. ⚠️ Update `factura_repository.dart` - Calculate taxes, use codes not names
5. ⚠️ Update `notes_controller.dart` - Pass codes instead of names
6. ⚠️ Update `terms_controller.dart` - Store selected codes

## 📋 Sample Data Flow

**User selects:**
- Product: Filete de Res ($18.50)
- Quantity: 2
- Term: "TERMINO MEDIO" (code T002)
- Side: "PAPAS FRITAS" (code A002)
- Sauce: "SALSA BBQ" (code SA001)
- Note: "Sin cebolla"
- Seat: 3
- Time: Current time

**System calculates:**
```
PRECIO_VENTA = 18.50
CANTIDAD = 2
SUBTOTAL = 18.50 * 2 = 37.00
Monto_Itbis = 18.50 * 0.18 = 3.33
Monto_Ley = 18.50 * 0.10 = 1.85
Total_Linea = 37.00 + (3.33 * 2) + (1.85 * 2) = 47.36

Codigo_Termino = "T002" (not "TERMINO MEDIO")
Codigo_Companana = "A002" (not "PAPAS FRITAS")
Codigo_Salsa = "SA001" (not "SALSA BBQ")
Silla_Ordeno = 3
Hora = "03:45:30 PM"
SECUENCIA_PRODUCTO = 1 (first item in order)
```

**Invoice totals:**
```
SUBTOTAL_FACTURA = 37.00
ITBIS_COBRADO = 6.66
IMPUESTO_LEY_COBRADO = 3.70
Valor_Factura = 47.36
BALANCE_PENDIENTE = 47.36 (not paid yet)
```

---

**This is the COMPLETE and ACCURATE schema matching the images provided!**
