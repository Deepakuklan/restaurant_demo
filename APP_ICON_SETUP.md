# 📱 App Icon Setup Guide

## Quick Setup (3 Steps)

### Step 1: Create Icon Images

You need to create 2 PNG images:

**1. Main Icon** (`app_icon.png`)
- Size: **1024x1024 pixels**
- Location: `assets/images/app_icon.png`
- Design: TANGO logo with orange circle

**2. Foreground Icon** (`app_icon_foreground.png`) - For Android
- Size: **1024x1024 pixels**  
- Location: `assets/images/app_icon_foreground.png`
- Design: Just the "TANGO" text and orange circle (transparent background)

---

## Simple Icon Design Idea

### Main Icon (app_icon.png):
```
┌──────────────────────┐
│                      │
│       TANGO          │  <- Black text
│         ●            │  <- Orange circle
│                      │
│  Background: White   │
└──────────────────────┘
```

### Foreground (app_icon_foreground.png):
```
┌──────────────────────┐
│  (Transparent BG)    │
│                      │
│       TANGO          │  <- Black text
│         ●            │  <- Orange circle
│                      │
└──────────────────────┘
```

---

## Create Icons Easily

### Option 1: Using Canva (Free)
1. Go to canva.com
2. Create custom size: 1024x1024
3. Add text "TANGO" (bold, large font)
4. Add orange circle below (#FF6B00)
5. Download as PNG
6. Save both versions

### Option 2: Using Figma (Free)
1. Create 1024x1024 frame
2. Add "TANGO" text
3. Add orange circle shape
4. Export as PNG

### Option 3: Online Icon Generators
- https://icon.kitchen/
- https://www.appicon.co/
- Upload any logo/design and it generates all sizes

---

## After Creating Images

### 1. Place files:
```
assets/images/
├── app_icon.png (1024x1024)
└── app_icon_foreground.png (1024x1024)
```

### 2. Install dependencies:
```bash
flutter pub get
```

### 3. Generate icons:
```bash
flutter pub run flutter_launcher_icons
```

### 4. Done! Icons created for:
- ✅ Android (all densities)
- ✅ iOS (all sizes)
- ✅ Adaptive icons (Android)

---

## Quick Test Icons

If you just want to test quickly, you can:

1. Take any 1024x1024 PNG image
2. Rename it to `app_icon.png`
3. Copy it as `app_icon_foreground.png`
4. Put both in `assets/images/`
5. Run the generator command

The system will create all platform-specific icons automatically!

---

## Colors Used

- **Orange**: #FF6B00 (TANGO brand color)
- **Background**: White or Orange
- **Text**: Black

---

## Verification

After running the generator, check:

**Android:**
- `android/app/src/main/res/mipmap-*/ic_launcher.png`
- `android/app/src/main/res/mipmap-*/ic_launcher_foreground.png`

**iOS:**
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

---

## Commands Summary

```bash
# 1. Get dependencies
flutter pub get

# 2. Generate icons (after placing images)
flutter pub run flutter_launcher_icons

# 3. Build and test
flutter run
```

---

**That's it! Your app will have professional icons on both platforms.**
