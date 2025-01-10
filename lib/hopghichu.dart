import 'package:flutter/material.dart';



class NoteBox extends StatelessWidget {
  final String hintText;
  final Function(String) onSaved;

  const NoteBox({
    super.key,
    required this.hintText,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
          onChanged: onSaved,
        ),
      ),
    );
  }
}
