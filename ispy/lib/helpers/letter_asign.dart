import 'package:flutter/cupertino.dart';

/// Using this helper class to get the letter from out beloved competitor
/// and setting it up on screen for our beloved player
///
/// Sometimes it takes time to get the letter from the server
/// TODO: Make it so that it doesn't take time to get the letter
///

class GetLetter {
  GetLetter(this.letter);
  String letter;

  String getLetter() {
    return letter;
  }

  void setLetter(String letter) {
    this.letter = letter;
  }
}
