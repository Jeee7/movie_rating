import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_rating/const/custom_colors.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchField({
    Key? key,
    required this.onChanged,
    this.hintText = 'Search movies...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
    );
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: colors.background,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }
}
