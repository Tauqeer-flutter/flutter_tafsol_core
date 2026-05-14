import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return ScreenUtil(
      options: ScreenUtilOptions(
        designSize: getDesignSize(
          context,
          customSizes: {DeviceType.mobile: Size(390, 844)},
        ),
      ),
      child: MaterialApp(
        title: 'Tafsol Core Example',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: const HomePage(),
      ),
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
        padding: EdgeInsets.all(context.w(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Dropdown:',
              style: TextStyle(
                fontSize: context.sp(16),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: context.h(10)),
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
            SizedBox(height: context.h(30)),

            Text(
              'Dropdown with Search:',
              style: TextStyle(
                fontSize: context.sp(16),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: context.h(10)),
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
                style: TextStyle(fontSize: context.sp(16), color: Colors.blue),
              ),
            ),
            SizedBox(height: context.h(20)),
          ],
        ),
      ),
    );
  }
}
