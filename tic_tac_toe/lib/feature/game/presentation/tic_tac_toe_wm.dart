import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart'; 

import 'tic_tac_toe_model.dart';
import 'tic_tac_toe_screen.dart'; 
import '../domain/entities/player.dart';
import '../domain/entities/game_status.dart';




abstract interface class ITicTacToeWidgetModel implements IWidgetModel {
  ListenableState<List<Player>> get boardState;
  ListenableState<String> get statusMessageState;
  ListenableState<String> get currentPlayerMessageState; // Переименовано для ясности

  

  void cellTapped(int index);
  void resetGame();
}


TicTacToeWidgetModel ticTacToeWidgetModelFactory(BuildContext context) {
  final model =
      TicTacToeModel(); 
  return TicTacToeWidgetModel(model);
}


class TicTacToeWidgetModel extends WidgetModel<TicTacToeScreen, TicTacToeModel>
    implements ITicTacToeWidgetModel {
  TicTacToeWidgetModel(TicTacToeModel model) : super(model);

  
  final _boardStateNotifier = StateNotifier<List<Player>>(initValue: List.filled(9, Player.none));
  final _statusMessageNotifier = StateNotifier<String>(initValue: '');
  final _currentPlayerMessageNotifier = StateNotifier<String>(initValue: '');
  final _winnerNotifier = StateNotifier<Player>(initValue: Player.none);
  ListenableState<Player> get winnerState => _winnerNotifier;


  @override
  ListenableState<List<Player>> get boardState => _boardStateNotifier;

  @override
  ListenableState<String> get statusMessageState => _statusMessageNotifier;

  @override
  ListenableState<String> get currentPlayerMessageState => _currentPlayerMessageNotifier;

 
  void _updateStateFromModel() {
    _boardStateNotifier.accept(
        List.from(model.board)); 
    _statusMessageNotifier.accept(_getGameStatusMessage());
    _currentPlayerMessageNotifier.accept(model.gameStatus == GameStatus.ongoing
            ? 'Ход игрока: ${model.currentPlayer.S_value}'
            : '' 
        );

  
  }

  String _getGameStatusMessage() {
    if (model.gameStatus == GameStatus.ongoing &&
        model.board.every((p) => p == Player.none)) {
      return 'Нажмите на клетку, чтобы начать игру.';
    } else if (model.gameStatus == GameStatus.ongoing) {
      return 'Игра продолжается...';
    }
    return model.gameStatus.message;
  }

  @override
  void cellTapped(int index) {
    if (model.gameStatus == GameStatus.ongoing) {
      model.makeMove(index);
      _updateStateFromModel();
    }
  }

  @override
  void resetGame() {
    model.resetGame();
    _updateStateFromModel();
  }
}