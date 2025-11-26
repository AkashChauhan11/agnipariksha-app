import 'package:agni_pariksha/core/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomSearchableDropdown<T> extends StatefulWidget {
  final String hintText;
  final IconData? prefixIcon;
  final List<T> items;
  final String Function(T) displayItem;
  final String? Function(T)? valueItem;
  final T? selectedItem;
  final Function(T?) onChanged;
  final String? Function(T?)? validator;
  final bool isLoading;
  final String? errorText;

  const CustomSearchableDropdown({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    required this.items,
    required this.displayItem,
    this.valueItem,
    this.selectedItem,
    required this.onChanged,
    this.validator,
    this.isLoading = false,
    this.errorText,
  }) : super(key: key);

  @override
  State<CustomSearchableDropdown<T>> createState() =>
      _CustomSearchableDropdownState<T>();
}

class _CustomSearchableDropdownState<T>
    extends State<CustomSearchableDropdown<T>> {
  final TextEditingController _searchController = TextEditingController();
  List<T> _filteredItems = [];
  bool _isDropdownOpen = false;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _dropdownKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _searchController.addListener(_filterItems);
  }

  @override
  void didUpdateWidget(CustomSearchableDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _filterItems();
    }
  }

  void _filterItems() {
    setState(() {
      final query = _searchController.text.toLowerCase();
      if (query.isEmpty) {
        _filteredItems = widget.items;
      } else {
        _filteredItems = widget.items
            .where((item) =>
                widget.displayItem(item).toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    if (widget.items.isEmpty && !widget.isLoading) return;

    setState(() {
      _isDropdownOpen = true;
    });

    _overlayEntry = _createOverlay();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isDropdownOpen = false;
      _searchController.clear();
    });
  }

  OverlayEntry _createOverlay() {
    RenderBox renderBox = _dropdownKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 4.0),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 300),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Search field
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: const TextStyle(color: Color(0xFF999999)),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.primary,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.primary.withOpacity(0.3),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.primary.withOpacity(0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  // Items list
                  Flexible(
                    child: _filteredItems.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              widget.isLoading
                                  ? 'Loading...'
                                  : 'No items found',
                              style: const TextStyle(
                                color: Color(0xFF999999),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: _filteredItems.length,
                            itemBuilder: (context, index) {
                              final item = _filteredItems[index];
                              final isSelected = widget.selectedItem == item;

                              return InkWell(
                                onTap: () {
                                  widget.onChanged(item);
                                  _closeDropdown();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  color: isSelected
                                      ? AppColors.primary.withOpacity(0.1)
                                      : Colors.transparent,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.displayItem(item),
                                          style: TextStyle(
                                            color: isSelected
                                                ? AppColors.primary
                                                : Colors.black87,
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      if (isSelected)
                                        const Icon(
                                          Icons.check,
                                          color: AppColors.primary,
                                          size: 20,
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _closeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          _toggleDropdown();
        },
        child: Container(
          key: _dropdownKey,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.errorText != null
                  ? Colors.red
                  : AppColors.primary.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: FormField<T>(
            initialValue: widget.selectedItem,
            validator: widget.validator,
            builder: (formFieldState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: _toggleDropdown,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Row(
                        children: [
                          if (widget.prefixIcon != null) ...[
                            Icon(
                              widget.prefixIcon,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 12),
                          ],
                          Expanded(
                            child: Text(
                              widget.selectedItem != null
                                  ? widget.displayItem(widget.selectedItem!)
                                  : widget.hintText,
                              style: TextStyle(
                                color: widget.selectedItem != null
                                    ? Colors.black87
                                    : const Color(0xFF999999),
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Icon(
                            _isDropdownOpen
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (formFieldState.hasError || widget.errorText != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 4),
                      child: Text(
                        formFieldState.errorText ?? widget.errorText ?? '',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

