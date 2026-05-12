import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' hide DeviceType;
import 'package:flutter_tafsol_core/flutter_tafsol_core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // We use ScreenUtilInit to initialize responsive sizing.
    // getDesignSize automatically picks the best design size based on the device.
    return ScreenUtilInit(
      designSize: getDesignSize(
        context,
        customSizes: {DeviceType.mobile: Size(390, 844)},
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Tafsol Core Example',
          theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
          home: const HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _selectedCountry;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _countries = [
    'United States',
    'United Kingdom',
    'Canada',
    'Germany',
    'France',
    'Japan',
    'Australia',
    'India',
    'Brazil',
    'Pakistan',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tafsol Core Example')),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Dropdown:',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10.h),
            AppDropdown<String>(
              hint: 'Select a Country',
              items: _countries,
              builder: (item) => Text(item),
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value;
                });
              },
            ),
            SizedBox(height: 30.h),

            Text(
              'Dropdown with Search:',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10.h),
            AppDropdown<String>(
              hint: 'Search Country',
              items: _countries,
              searchController: _searchController,
              builder: (item) => Text(item),
              onChanged: (value) {
                log('Selected via search: $value');
              },
              searchMatchFn: (item, searchValue) {
                return item.value.toString().toLowerCase().contains(
                  searchValue.toLowerCase(),
                );
              },
            ),
            const Spacer(),
            Center(
              child: Text(
                'Selected: ${_selectedCountry ?? "None"}',
                style: TextStyle(fontSize: 16.sp, color: Colors.blue),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
