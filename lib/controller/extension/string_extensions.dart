import 'package:flutter/material.dart';

extension StringExtensions on String {
  String whitespace() => " $this ";
  String addQuotes() => "'$this'";
  String removeQuotes() => replaceAll('"', '');
  String addSymbolBefore({String symbol = ''}) => "$symbol $this";
  String addSymbolAfter({String symbol = ''}) => "$this $symbol";
  String truncate({int maxLength = 25}) => (length <= maxLength) ? this : '${substring(0, maxLength)}...';
  bool containsCase(String other) => toLowerCase().contains(other.toLowerCase());
  String addQuta() => "$this ''";

  String firstLetterUpperCase() {
    List<String> words = split(' ');
    List<String> res = [];
    for (var element in words) {
      res.add("${element[0].toUpperCase()}${element.substring(1).toLowerCase()}");
    }
    return res.join(' ');
  }

  String firstLetter() {
    if (isNotEmpty) {
      final parts = split(' ').where((part) => part.isNotEmpty);
      return parts.first;
    } else {
      return "?";
    }
  }

  String firstLetters() {
    if (isNotEmpty) {
      final parts = split(' ').where((part) => part.isNotEmpty);
      final initials = parts.map((part) => part[0].toUpperCase()).join('');
      return initials;
    } else {
      return "?";
    }
  }

  Color hex2Color() {
    final int value = int.parse(this, radix: 16); // Hex kodunu integer'a dönüştür
    return Color(0xff000000 + value); // Alpha değerini (tam opak) ekleyerek Color nesnesini oluştur
  }

  String repeat(int count) {
    return List.generate(count, (index) => this).join('');
  }
}
