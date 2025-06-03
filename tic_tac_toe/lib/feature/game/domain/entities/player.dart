enum Player {
  x,
  o,
  none;

  String get S_value {
    switch (this) {
      case Player.x:
        return 'X';
      case Player.o:
        return 'O';
      case Player.none:
        return '';
    }
  }
}
