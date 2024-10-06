import 'package:flutter/material.dart';

class Dropdown extends StatelessWidget {
  const Dropdown(
      {super.key,
      // required this.focus,
      required this.onChange,
      required this.hint,
      required this.value,
      required this.items});

  // final bool focus;
  final String hint;
  final String value;
  final List<String> items;
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: double.infinity, // This makes the dropdown take the full width
        padding: const EdgeInsets.symmetric(horizontal: 12), // Optional padding
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey), // Optional border styling
        ),
        child: DropdownButtonHideUnderline(
          // Hides the default underline
          child: DropdownButton(
            isExpanded: true, // Ensures the dropdown takes up full width
            hint: Text(hint),
            onChanged: (newValue) {
              onChange(newValue!);
            },
            value: value,
            items: items.map((selectedType) {
              return DropdownMenuItem(
                value: selectedType,
                child: Text(
                  selectedType,
                ),
              );
            }).toList(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            icon: const Icon(Icons
                .arrow_drop_down), // Optional: customize the dropdown arrow
            dropdownColor:
                Colors.pink, // Optional: change dropdown background color
          ),
        ),
      ),
    );
  }
// }
}
