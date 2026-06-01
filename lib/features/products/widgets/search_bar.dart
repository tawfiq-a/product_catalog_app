import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.all(8.0),
    child: TextField(decoration: InputDecoration(hintText: 'Search')),
  );
}
