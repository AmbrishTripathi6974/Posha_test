import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            name,
            style: theme.textTheme.headlineLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          Row(
            children: [
              Text(
                "View All",
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  color: Colors.amber,
                ),
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsetsDirectional.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.amber,
                ),
                child: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
