//
// Tic-Tac-Toe Game
//
final int rows = 3;
final int cols = 3;

final Cell[][] board = new Cell[rows][cols];
final ArrayList<Position> positionLeft = new ArrayList<Position>();

int player = random(1) > 0.5f ? 1 : 2;

int winner = 0;
boolean gameover;

void setup()  {
  size(300,300);
  smooth();

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      board[i][j] = new Cell(width/cols*i, height/rows*j, width/cols, height/rows);
      positionLeft.add(new Position(i, j));
    }
  }
}


void draw()  {
  background(255);

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      board[i][j].display();
    }
  }
}

Position tryClick() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (board[i][j].state == 0) {
        //check if cell is clickable
        boolean success = board[i][j].click(mouseX, mouseY, player);
        //return clicked cell's position
        if (success) return new Position(i, j);
      }
    }
  }
  //in case nothing is clicked successfully
  return null;
}


void mousePressed()  {
  //save clicked cell to result
  Position result = tryClick();
  if (result == null) { return; }
  for (int i = 0; i < positionLeft.size(); ++i) {
    //get every position in positionLeft
    Position current = positionLeft.get(i);
    //if result's position matches, delete postionLeft objects
    if (result.row == current.row && result.col == current.col) {
      positionLeft.remove(i);
    }
  }

  int lefts = positionLeft.size();
  if (lefts > 0) {
    int selectedIndex = (int) random(positionLeft.size());
    Position selected = positionLeft.get(selectedIndex);
    positionLeft.remove(selectedIndex);
    board[selected.row][selected.col].state = 3 - player;
  }

  //checkGameOver();
}


void checkGameOver() {

  // three across : \
  if(board[0][0].state == 1 && board[1][1].state == 1 && board[2][2].state == 1)  gameover = true; winner = 1; gameover();
  if(board[0][0].state == 2 && board[1][1].state == 2 && board[2][2].state == 2)  gameover = true; winner = 2; gameover();

  // three across : /
  if(board[0][2].state == 1 && board[1][1].state == 1 && board[2][0].state == 1) gameover = true; winner = 1; gameover();
  if(board[0][2].state == 2 && board[1][1].state == 2 && board[2][0].state == 2) gameover = true; winner = 2; gameover();


  for(int i = 0; i < 3; ++ i) {
    for(int j = 0; j < 3; ++j) {
      // three in a row
      if(board[i][0].state == 1 && board[i][1].state == 1 && board[i][1].state == 1) gameover = true; winner = 1; gameover();
      if(board[i][0].state == 2 && board[i][1].state == 2 && board[i][1].state == 2) gameover = true; winner = 2; gameover();

      // three in a column
      if(board[0][j].state == 1 && board[0][j].state == 1 && board[0][j].state == 1) gameover = true; winner = 1; gameover();
      if(board[0][j].state == 2 && board[0][j].state == 2 && board[0][j].state == 2) gameover = true; winner = 2; gameover();
    }
  }
}

void gameover(){
  fill(0);
  textSize(20);

  switch(winner) {
  case 0:
    text("Game over! Nobody won.", width/2, height/2);
    break;
  case 1:
    text("Winner: Player 1", width/2, height/2);
    break;
  case 2:
    text("Winner: Player 2", width/2, height/2);
    break;
  }
}
