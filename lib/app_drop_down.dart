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
class AppDropdown<T> extends StatefulWidget {
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
  State<AppDropdown<T>> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T> extends State<AppDropdown<T>> {
  final _selectedItemNotifier = ValueNotifier<T?>(null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedItemNotifier.value = widget.value;
    });
  }

  @override
  void dispose() {
    _selectedItemNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecorationTheme.of(context);
    return SizedBox(
      width: widget.width,
      child: DropdownButtonFormField2<T>(
        key: ValueKey(widget.items.length),
        valueListenable: _selectedItemNotifier,
        style: inputDecoration.hintStyle,
        decoration: InputDecoration(
          constraints: BoxConstraints(
            maxWidth: context.w(200),
            minWidth: context.w(100),
          ),
          hintText: widget.hint,
          hintStyle: inputDecoration.hintStyle,
          filled: true,
          fillColor: widget.fillColor ?? Colors.white,
          border: inputDecoration.border,
          enabledBorder: inputDecoration.enabledBorder,
          focusedBorder: inputDecoration.focusedBorder,
          errorBorder: inputDecoration.errorBorder,
          focusedErrorBorder: inputDecoration.focusedErrorBorder,
          contentPadding: EdgeInsets.symmetric(vertical: context.sp(11)),
        ),
        isExpanded: true,
        hint: Text(widget.hint),
        items: widget.items
            .map(
              (item) =>
                  DropdownItem<T>(value: item, child: widget.builder(item)),
            )
            .toList(),
        onChanged: (newItem) {
          _selectedItemNotifier.value = newItem;
          widget.onChanged?.call(newItem);
        },
        validator: widget.validator,
        buttonStyleData: FormFieldButtonStyleData(padding: EdgeInsets.zero),
        iconStyleData: IconStyleData(
          icon: const Icon(CupertinoIcons.chevron_down),
          iconSize: context.sp(16),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: context.h(300),
          offset: const Offset(0, -10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(context.r(12)),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: context.w(12)),
        ),
        dropdownSearchData: widget.searchController != null
            ? DropdownSearchData(
                searchController: widget.searchController,
                searchBarWidgetHeight: context.h(50),
                searchBarWidget: Container(
                  height: context.h(50),
                  padding: EdgeInsets.only(
                    top: context.h(8),
                    bottom: context.h(4),
                    right: context.w(8),
                    left: context.w(8),
                  ),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: widget.searchController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: context.w(10),
                        vertical: context.h(8),
                      ),
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(context.r(8)),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: widget.searchMatchFn,
              )
            : null,
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            widget.searchController?.clear();
          }
        },
      ),
    );
  }
}
