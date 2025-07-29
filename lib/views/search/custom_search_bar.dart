import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../blocs/pet_bloc.dart';
import '../../blocs/pet_event.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: (value) {
          context.read<PetBloc>().add(SearchPets(value));
        },
        decoration: InputDecoration(
          hintText: "Search your favourite pet...",
          prefixIcon: const Icon(Icons.search, color: Colors.yellow),
          hintStyle: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily, fontSize: 12),
          suffixIcon: IconButton(
            icon: const Icon(Icons.mic_none_rounded),
            onPressed: () {},
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 1),
          ),
        ),
      ),
    );
  }
}
