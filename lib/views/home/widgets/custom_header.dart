import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Text(
                "Let's Find a",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.headlineSmall?.color,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text.rich(
                TextSpan(
                  text: "Little ",
                  style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.headlineLarge?.color),
                ),
              ),
              Text.rich(
                TextSpan(
                  text: "Friend... ",
                  style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      color: theme.textTheme.headlineLarge?.color),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
