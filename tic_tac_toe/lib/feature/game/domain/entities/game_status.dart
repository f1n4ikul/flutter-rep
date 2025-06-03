enum GameStatus {
  ongoing,
  xWins,
  oWins,
  draw;

  String get message {
    switch (this) {
      case GameStatus.ongoing:
        return 'Игра идет...';
      case GameStatus.xWins:
        return 'Игрок X победил!';
      case GameStatus.oWins:
        return 'Игрок O победил!';
      case GameStatus.draw:
        return 'Ничья!';
    }
  }
}
