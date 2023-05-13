import 'package:flutter/material.dart';
import 'package:tictactoeflutter/utils/gameLogic.dart';

import 'uiThem/color.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = "X";
  bool gameOver =false;
  int turn = 0 ;
  String result ="";
  List<int> scoreboard = [0,0,0,0,0,0,0,0];

  Game game =Game();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              "It's ${lastValue} turn",
            style: TextStyle(
              color: Colors.white,
              fontSize: 58,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
                crossAxisCount: Game.bordlenth ~/ 3,
              padding:EdgeInsets.all(16.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(Game.bordlenth, (index) => InkWell(
                onTap: gameOver ? null : (){
                  if (game.board![index] == ""){
                    setState(() {
                      game.board![index] = lastValue;
                      turn++;
                      gameOver = game.winnerCheck(
                          lastValue, index, scoreboard, 3);
                      if (gameOver){
                        result ="$lastValue is the WINNER";
                      }else if(!gameOver && turn == 9){
                        result = "It's a Draw !";
                        gameOver=true;
                      }
                      if (lastValue == "X")
                        lastValue = "O";
                      else
                        lastValue = "X";
                    });
                  }
                },
                child: Container(
                width: Game.blocSize,
                height: Game.blocSize,
                decoration: BoxDecoration(
                  color: MainColor.secondaryColor,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Center(
                  child: Text(
                    game.board![index],
                    // "X",
                    style: TextStyle(
                      color: game.board![index] == "X"
                          ? Colors.blue
                          : Colors.pink,
                      fontSize: 64.0,
                    ),
                  ),
                ),
              ),),
              ),
            ),
          ),
          SizedBox(height: 25.0),
          Text(
            result,
            style: TextStyle(
              color: Colors.white,
              fontSize: 35.0,
            ),
          ),
          SizedBox(height: 15.0,),
          ElevatedButton.icon(
              onPressed: (){
                setState(() {
                  game.board=Game.initGameBoard();
                  gameOver =false;
                  lastValue = "X";
                  turn = 0;
                  result ="";
                  scoreboard = [0,0,0,0,0,0,0,0];
                });
              },
            icon: Icon(Icons.replay),
            label: Text("Replay the Game"),
          ),
        ],
      ),
    );
  }
}
