import 'package:flutter/material.dart';

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({Key? key, required this.onSearch}) : super(key: key);

  final ValueChanged<String> onSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextField(
        onChanged: onSearch,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          hintText: 'Pesquisar cliente',
          suffixIcon: Icon(Icons.search),
          fillColor: Colors.red,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
