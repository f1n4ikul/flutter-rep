import '../entities/player.dart';
import '../entities/game_status.dart';

class TicTacToeLogic {
  List<Player> board = List.filled(9, Player.none);
  Player currentPlayer = Player.x;
  GameStatus gameStatus = GameStatus.ongoing;



  

  void makeMove(int index) {
    if (board[index] == Player.none && gameStatus == GameStatus.ongoing) {
      board[index] = currentPlayer;
      _checkGameStatus();
      if (gameStatus == GameStatus.ongoing) {
        currentPlayer = (currentPlayer == Player.x) ? Player.o : Player.x;
      }
    }
  }

  void _checkGameStatus() {
    // Проверка строк
    for (int i = 0; i < 9; i += 3) {
      if (board[i] != Player.none &&
          board[i] == board[i + 1] &&
          board[i] == board[i + 2]) {
        gameStatus = board[i] == Player.x ? GameStatus.xWins : GameStatus.oWins;
        return;
      }
    }

    // Проверка столбцов
    for (int i = 0; i < 3; ++i) {
      if (board[i] != Player.none &&
          board[i] == board[i + 3] &&
          board[i] == board[i + 6]) {
        gameStatus = board[i] == Player.x ? GameStatus.xWins : GameStatus.oWins;
        return;
      }
    }

    // Проверка диагоналей
    if (board[0] != Player.none &&
        board[0] == board[4] &&
        board[0] == board[8]) {
      gameStatus = board[0] == Player.x ? GameStatus.xWins : GameStatus.oWins;
      return;
    }
    if (board[2] != Player.none &&
        board[2] == board[4] &&
        board[2] == board[6]) {
      gameStatus = board[2] == Player.x ? GameStatus.xWins : GameStatus.oWins;
      return;
    }

    // Проверка на ничью
    if (!board.contains(Player.none)) {
      gameStatus = GameStatus.draw;
      return;
    }

    gameStatus = GameStatus.ongoing;
  }

  void resetGame() {
    board = List.filled(9, Player.none);
    currentPlayer = Player.x;
    gameStatus = GameStatus.ongoing;
  }
}
