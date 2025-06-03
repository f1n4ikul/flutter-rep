import 'package:elementary/elementary.dart';
import '../domain/logic/tic_tac_toe_logic.dart';
import '../domain/entities/player.dart';
import '../domain/entities/game_status.dart';



class TicTacToeModel extends ElementaryModel {
  final TicTacToeLogic _gameLogic = TicTacToeLogic();

  List<Player> get board => List.unmodifiable(_gameLogic.board);
  Player get currentPlayer => _gameLogic.currentPlayer;
  GameStatus get gameStatus => _gameLogic.gameStatus;
  

  TicTacToeModel({ErrorHandler? errorHandler})
      : super(errorHandler: errorHandler);

  void makeMove(int index) {
    _gameLogic.makeMove(index);
  }

  void resetGame() {
    _gameLogic.resetGame();
  }
}
