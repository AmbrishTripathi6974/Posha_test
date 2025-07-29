import 'package:flutter/material.dart';

List<String> categories = [
  'Cats',
  'Dogs',
  'Birds',
  'Fishs',
];

class Cat {
  final Color color;
  final String name, location, sex, image, description;
  final double age, weight;
  final int distance;
  final bool isAvailable;
  final Owner owner;
  final bool isFavorite;

  Cat({
    required this.image,
    required this.color,
    required this.description,
    required this.name,
    required this.location,
    required this.sex,
    required this.age,
    required this.weight,
    required this.distance,
    required this.owner,
    required this.isAvailable,
    this.isFavorite = false,
  });

  Cat copyWith({
    bool? isAvailable,
    bool? isFavorite,
  }) {
    return Cat(
      image: image,
      color: color,
      description: description,
      name: name,
      location: location,
      sex: sex,
      age: age,
      weight: weight,
      distance: distance,
      owner: owner,
      isAvailable: isAvailable ?? this.isAvailable,
      isFavorite : isFavorite ?? this.isFavorite,
    );
  }
}

List<Cat> cats = [
  Cat(
    isAvailable: true,
    color: const Color(0xffffd690),
    name: 'Amber',
    description: desc,
    location: 'Thornridge, Chicago',
    sex: 'Male',
    age: 2.1,
    weight: 4.5,
    image: 'assets/pets_image/cat4.png',
    distance: 5,
    owner: owners[0],
  ),
  Cat(
    isAvailable: false,
    color: const Color(0xffcaeda1),
    name: 'Kitty',
    description: desc,
    location: 'Siak, Riau',
    sex: 'Male',
    age: 1.1,
    image: 'assets/pets_image/cat2.png',
    weight: 2.2,
    distance: 7,
    owner: owners[1],
  ),
  Cat(
    isAvailable: true,
    color: const Color(0xffa4e1ff),
    name: 'Cleo',
    image: 'assets/pets_image/cat3.png',
    description: desc,
    location: 'Pekanbaru, Riau',
    sex: 'Male',
    age: 1.4,
    weight: 3.4,
    distance: 7,
    owner: owners[2],
  ),
  Cat(
    isAvailable: false,
    color: const Color(0xfffa9191),
    image: 'assets/pets_image/cat5.png',
    name: 'Milo',
    description: desc,
    location: 'Kampar, Riau',
    sex: 'Female',
    age: 1.1,
    weight: 3.2,
    distance: 11,
    owner: owners[0],
  ),
  Cat(
    isAvailable: true,
    color: const Color(0xffffd690),
    name: 'Leo',
    description: desc,
    location: 'Dumai, Riau',
    sex: 'Male',
    age: 2.1,
    weight: 4.5,
    image: 'assets/pets_image/cat1.png',
    distance: 7,
    owner: owners[0],
  ),
  Cat(
    isAvailable: true,
    color: const Color(0xfffa9191),
    name: 'Lilly',
    description: desc,
    location: 'Dumai, Riau',
    sex: 'Male',
    age: 2.1,
    weight: 4.5,
    image: 'assets/pets_image/pet6.png',
    distance: 7,
    owner: owners[0],
  ),
  Cat(
    isAvailable: true,
    color: const Color(0xffffd690),
    name: 'Tiger',
    description: desc,
    location: 'Dumai, Riau',
    sex: 'Male',
    age: 2.1,
    weight: 4.5,
    image: 'assets/pets_image/pet7.png',
    distance: 7,
    owner: owners[0],
  ),
  Cat(
    isAvailable: true,
    color: const Color(0xffa4e1ff),
    name: 'Bruno',
    description: desc,
    location: 'Dumai, Riau',
    sex: 'Male',
    age: 2.1,
    weight: 4.5,
    image: 'assets/pets_image/pet8.png',
    distance: 7,
    owner: owners[0],
  ),
  Cat(
    isAvailable: true,
    color: const Color(0xffffd690),
    name: 'Ray',
    description: desc,
    location: 'Dumai, Riau',
    sex: 'Male',
    age: 2.1,
    weight: 4.5,
    image: 'assets/pets_image/pet9.png',
    distance: 7,
    owner: owners[0],
  ),
  Cat(
    isAvailable: true,
    color: const Color(0xffcaeda1),
    name: 'Shadow',
    description: desc,
    location: 'Dumai, Riau',
    sex: 'Female',
    age: 2.1,
    weight: 4.5,
    image: 'assets/pets_image/pet10.png',
    distance: 7,
    owner: owners[0],
  ),
];

String desc =
    'This cat is a domestic species of small carnivorous mammal. It is the only domesticated species in the family Felidae and is often referred to as the domestic cat to distinguish it from wild members. A cat can be a house, farm, or feral cat. Domestic cats are valued by humans for companionship and pest control.';

class Owner {
  final String name, image;

  Owner({required this.name, required this.image});
}

List<Owner> owners = [
  Owner(
    name: 'Sophia',
    image: 'assets/pets_image/woman-with-cat1.png',
  ),
  Owner(
    name: 'Annie',
    image: 'assets/pets_image/woman-with-cat2.png',
  ),
  Owner(
    name: 'Jessica',
    image: 'assets/pets_image/woman-with-cat3.png',
  ),
];
