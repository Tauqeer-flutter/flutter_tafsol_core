import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A custom dropdown widget that wraps [DropdownButtonFormField2] with
/// standard styling and optional search functionality.
///
/// This widget provides a consistent look and feel for dropdowns across the app,
/// with built-in support for validation, custom item builders, and search.
///
/// Example usage:
/// ```dart
/// AppDropdown<String>(
///   hint: 'Select an option',
///   items: ['Option 1', 'Option 2', 'Option 3'],
///   builder: (item) => item.toString(),
///   onChanged: (value) => print('Selected: $value'),
/// )
/// ```
class AppDropdown<T> extends StatelessWidget {
  /// The currently selected value.
  final T? value;

  /// The text to display when no item is selected.
  final String hint;

  /// Vertical padding for the dropdown content.
  final double? vPadding;

  /// The list of items to display in the dropdown.
  final List<T> items;

  /// A function that builds the widget for each item in the [items] list.
  final Widget Function(T) builder;

  /// Callback function called when the user selects an item.
  final ValueSetter<T?>? onChanged;

  /// Optional validator function for use within a [Form].
  final String? Function(T?)? validator;

  /// The background color of the dropdown.
  final Color? fillColor;

  /// The width of the dropdown widget.
  final double? width;

  /// Optional controller for the search field. If provided, search functionality is enabled.
  final TextEditingController? searchController;

  /// Optional function to filter items based on search text.
  final bool Function(DropdownItem<T>, String)? searchMatchFn;

  const AppDropdown({
    super.key,
    this.value,
    required this.hint,
    required this.items,
    required this.builder,
    this.onChanged,
    this.validator,
    this.fillColor,
    this.vPadding,
    this.width,
    this.searchController,
    this.searchMatchFn,
  });

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecorationTheme.of(context);
    return SizedBox(
      // height: 43.sp,
      width: width,
      child: DropdownButtonFormField2<T>(
        key: ValueKey(items.length),
        // style: AppFonts.black14w400,
        decoration: InputDecoration(
          constraints: BoxConstraints(maxWidth: 200.w, minWidth: 100.w),
          hintText: hint,
          // hintStyle: AppFonts.black14w400,
          filled: true,
          fillColor: fillColor ?? Colors.white,
          // border: OutlineInputBorder(
          //   borderSide: const BorderSide(color: AppColors.lightGrey2),
          //   borderRadius: BorderRadius.circular(12.r),
          // ),
          border: inputDecoration.border,
          // enabledBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(color: AppColors.lightGrey2),
          //   borderRadius: BorderRadius.circular(12.r),
          // ),
          enabledBorder: inputDecoration.enabledBorder,
          // focusedBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(color: AppColors.lightGrey2),
          //   borderRadius: BorderRadius.circular(12.r),
          // ),
          focusedBorder: inputDecoration.focusedBorder,
          // errorBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(color: Colors.red),
          //   borderRadius: BorderRadius.circular(12.r),
          // ),
          errorBorder: inputDecoration.errorBorder,
          // focusedErrorBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(color: Colors.red),
          //   borderRadius: BorderRadius.circular(12.r),
          // ),
          focusedErrorBorder: inputDecoration.focusedErrorBorder,
          contentPadding: EdgeInsets.symmetric(vertical: 11.sp),
        ),
        isExpanded: true,
        hint: Text(hint),
        items: items
            .map((item) => DropdownItem<T>(value: item, child: builder(item)))
            .toList(),
        onChanged: onChanged,
        validator: validator,
        buttonStyleData: FormFieldButtonStyleData(
          padding: EdgeInsets.only(right: 10.w),
        ),
        iconStyleData: IconStyleData(
          icon: const Icon(CupertinoIcons.chevron_down),
          iconSize: 16.sp,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 300.h,
          offset: const Offset(0, -10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
        ),
        dropdownSearchData: searchController != null
            ? DropdownSearchData(
                searchController: searchController,
                searchBarWidgetHeight: 50.h,
                searchBarWidget: Container(
                  height: 50.h,
                  padding: EdgeInsets.only(
                    top: 8.h,
                    bottom: 4.h,
                    right: 8.w,
                    left: 8.w,
                  ),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: searchController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 8.h,
                      ),
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: searchMatchFn,
              )
            : null,
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            searchController?.clear();
          }
        },
      ),
    );
  }
}
