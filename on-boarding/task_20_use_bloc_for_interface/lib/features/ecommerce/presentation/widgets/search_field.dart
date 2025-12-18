import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final Function(String) onChanged;
  const SearchField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 261,
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          hintText: "Leather",
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final VoidCallback onPressed;
  const FilterButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 10, 92, 216),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.filter_list, color: Colors.white),
      ),
    );
  }
}
