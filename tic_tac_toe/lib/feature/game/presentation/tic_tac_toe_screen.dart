import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'tic_tac_toe_wm.dart';
import '../domain/entities/player.dart';

class TicTacToeScreen extends ElementaryWidget<ITicTacToeWidgetModel> {
  const TicTacToeScreen({
    Key? key,
    WidgetModelFactory wmFactory = ticTacToeWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ITicTacToeWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Крестики-нолики ',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurpleAccent, Colors.purple],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StateNotifierBuilder<String>(
                  listenableState: wm.currentPlayerMessageState,
                  builder: (_, currentPlayerMessage) {
                    if (currentPlayerMessage == null ||
                        currentPlayerMessage.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Text(
                      currentPlayerMessage,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                StateNotifierBuilder<List<Player>>(
                  listenableState: wm.boardState,
                  builder: (context, board) {
                    if (board == null || board.isEmpty) {
                      return const CircularProgressIndicator(
                        color: Colors.white,
                      );
                    }

                    // Ограничиваем ширину под разные экраны
                    final screenWidth = MediaQuery.of(context).size.width;
                    double maxWidth = screenWidth * 0.8;
                    if (maxWidth > 400) maxWidth = 400;

                    return SizedBox(
                      width: maxWidth,
                      height: maxWidth,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          final player = board[index];
                          return GestureDetector(
                            onTap: () => wm.cellTapped(index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  player.S_value,
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: player == Player.x
                                        ? Colors.blueAccent
                                        : Colors.pinkAccent,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                StateNotifierBuilder<String>(
                  listenableState: wm.statusMessageState,
                  builder: (_, statusMessage) {
                    return Text(
                      statusMessage ?? 'Загрузка...',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: wm.resetGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Начать заново'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
