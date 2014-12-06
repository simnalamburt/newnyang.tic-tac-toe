//
// Tic-Tac-Toe Game
//
final int rows = 3;
final int cols = 3;

final Cell[][] board = new Cell[rows][cols];
final ArrayList<Position> positionLeft = new ArrayList<Position>();

int player = random(1) > 0.5f ? 1 : 2;

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

  isGameOver();

  int lefts = positionLeft.size();
  if (lefts > 0) {
    int selectedIndex = (int) random(positionLeft.size());
    Position selected = positionLeft.get(selectedIndex);
    positionLeft.remove(selectedIndex);
    board[selected.row][selected.col].state = 3 - player;
  }

  isGameOver();
}


//
// Check if the game is over
//
// Return player's number when the player has won
// Otherwise, 0
//
int isGameOver() {
  for (int player = 1; i <= 2; ++i) {
    // rows & cols
    for(int i = 0; i < rows; ++ i) {
      for(int j = 0; j < cols; ++j) {
        if (board[i][0].state == player && board[i][1].state == player && board[i][1].state == player) return player;
        if (board[0][j].state == player && board[0][j].state == player && board[0][j].state == player) return player;
      }
    }
    // diagonal
    if (board[0][0].state == player && board[1][1].state == player && board[2][2].state == player) return player;
    if (board[0][2].state == player && board[1][1].state == player && board[2][0].state == player) return player;
  }

  // Passed all tests, the game is not over yet
  return 0;
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
