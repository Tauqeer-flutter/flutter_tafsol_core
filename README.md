# flutter_tafsol_core

A Flutter package containing essential components and utilities to accelerate the creation of new applications. This core package provides responsive design utilities and customized UI widgets.

## Features

### 1. Responsive Design Size (`getDesignSize`)
Automatically determines the appropriate design size based on the device's screen width and orientation. It supports a wide range of devices from small foldables to large 4K desktops.

- **Dynamic Detection:** Automatically categorizes devices into `mobile`, `tablet`, `macBookAir`, `desktopLarge`, etc.
- **Orientation Support:** Automatically swaps dimensions for mobile landscape to prevent layout stretching.
- **Customizable:** Easily override default sizes for specific device types.

### 2. AppDropdown
A highly customizable dropdown widget built on top of `dropdown_button2`. It simplifies the implementation of dropdowns with a consistent look and feel.

- **Easy Integration:** Simple API for items and builders.
- **Searchable:** Built-in support for searching through items using a `TextEditingController`.
- **Form Validation:** Works seamlessly with Flutter's `Form` and `FormField` validation.
- **Responsive:** Uses `flutter_screenutil` for consistent sizing across devices.

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_tafsol_core:
    path: ../flutter_tafsol_core # or use git/pub version
```

## Usage

### Responsive Design with ScreenUtil

```dart
import 'package:flutter_tafsol_core/flutter_tafsol_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: getDesignSize(context), // Automatic design size
      builder: (context, child) => MyApp(),
    ),
  );
}
```

### Using AppDropdown

```dart
AppDropdown<String>(
  hint: 'Select a Category',
  items: ['Technology', 'Business', 'Lifestyle'],
  builder: (item) => Text(item),
  onChanged: (value) {
    print('Selected: $value');
  },
)
```
