import 'package:flutter/material.dart';

class ShoeModel {
  final int? id;
  final String img;
  final String title;
  final String? category;
  final double price;
  bool? isFav = false;
  final Size? size;
  final Color? color;
  final String? descriptions;
  final double? rating;

  ShoeModel(
      {this.id,
      required this.img,
      required this.title, this.category,
      required this.price,
      this.size,
      this.isFav,
        this.rating,
      this.color,
      this.descriptions});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'img': img,
      'title': title,
      'category': category.toString(), // Convert the enum to a string
      'price': price,
      'isFav': isFav,
      'size': size?.toString(), // Convert the Size enum to a string
      'color': color?.value, // Convert the Color to an int
      'descriptions': descriptions,
      'rating': rating,
    };
  }

  factory ShoeModel.fromJson(Map<String, dynamic> json) {
    return ShoeModel(
      id: json['id'],
      img: json['image'],
      title: json['title'],
      category: json['category'], // Since the category is hardcoded as "men's clothing" in the JSON
      price: json['price'].toDouble(), // Parse the price as a double
      descriptions: json['description'],
      rating: json['rating']['rate'].toDouble(), // Parse the rating as a double
    );
  }
}

enum Category { men, women, kid }

enum Size { US, UK, EU }
