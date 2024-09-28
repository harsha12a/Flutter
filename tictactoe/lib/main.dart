import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});
  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> board = List.filled(9, '', growable: false);
  String gameRes = '';
  bool isX = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: gamePlan(),
    );
  }

  Widget gamePlan() {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: 9,
              itemBuilder: (context, index) => GestureDetector(
                    onTap: () => _handleTap(index: index),
                    child: Container(
                      margin: EdgeInsets.all(4),
                      color: Colors.green,
                      child: Center(
                        child: Text(
                          board[index],
                          style: TextStyle(fontSize: 80, color: Colors.red),
                        ),
                      ),
                    ),
                  )),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            '$gameRes',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        ElevatedButton(onPressed: _reset, child: Text('Restart Game')),
      ],
    );
  }

  void _handleTap({required int index}) {
    if (board[index] == '' && gameRes == '') {
      setState(() {
        board[index] = isX ? 'X' : 'O';
        isX = !isX;
        gameRes = _checkWinner();
      });
    }
  }

  String _checkWinner() {
    const winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];
    for (var pattern in winPatterns) {
      if (board[pattern[0]] == board[pattern[1]] &&
          board[pattern[1]] == board[pattern[2]] &&
          board[pattern[0]] != '') {
        return 'Player ${board[pattern[0]]} wins';
      }
    }
    if (!board.contains('')) {
      return 'It\'s a Draw';
    }
    return '';
  }

  void _reset() {
    setState(() {
      board = List.filled(9, '', growable: false);
      gameRes = '';
      isX = false;
    });
  }
}
