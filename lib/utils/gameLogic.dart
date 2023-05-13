class Player{
  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game{
  static final bordlenth = 9;
  static final blocSize = 100.0;
  
  List<String>? board;
  static List<String>? initGameBoard() => List.generate(bordlenth, (index) => Player.empty);

  bool winnerCheck(String player , int index , List<int> scoreboard, int gridSize){
    int raw = index~/ 3;
    int col = index % 3;
    int score = player == "X" ? 1 : -1;

    scoreboard[raw]+=score;
    scoreboard[gridSize + col ]+=score;
    if(raw == col ) scoreboard[2*gridSize] +=score;
    if (gridSize -1 -col == raw) scoreboard[2 * gridSize +1] += score;

    if (scoreboard.contains(3) || scoreboard.contains(-3)){
      return true;
    }
    return false;
  }
}