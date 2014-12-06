// Tic-Tac-Toe Game

Cell[][] board;
ArrayList<Position> positionLeft;

int rows = 3;
int cols = 3;
int w;
int h;

int player;
int cellsleft;
int r_rows, r_cols;

int winner = 0;
boolean gameover;
boolean computer = true;

void setup()  {
  size(300,300);
  smooth();

  w = width/cols;
  h = height/rows;

  player = int(random(1,3));
  println(player);

  positionLeft = new ArrayList<Position>();

  board = new Cell[rows][cols];
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      board[i][j] = new Cell(j*w, i*h, w, h);
      positionLeft.add(new Position(i, j));
    }
  }
}


void draw()  {
  background(255);

  //generate random numbers
  r_rows = (int) random(rows);
  r_cols = (int) random(cols);

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
      } else {
        computer = false;
      }
    }
  }
  //in case nothing is clicked successfully
  return null;
}


void mousePressed()  {

  //save clicked cell to result
  Position result = tryClick();
  for (int i = 0; i < positionLeft.size(); ++i) {
    //get every position in positionLeft
    Position current = positionLeft.get(i);
    //if result's position matches, delete postionLeft objects
    if (result.row == current.row && result.col == current.col) {
      positionLeft.remove(i);
    }
  }

  if(computer && board[r_rows][r_cols].state == 0) board[r_rows][r_cols].state = 3-player;

  //println("random : " + r_cols + ", " + r_rows);
  displayPosition();
  //displayState();
  //checkGameOver();
}


void displayPosition () {
  for (int i = 0; i < positionLeft.size(); ++i) {
    println(positionLeft.get(i).row, positionLeft.get(i).col);
  }
}

void displayState() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if(board[i][j].state != 0) {
        //println("(" + j + ", " + i + ") state : " + board[i][j].state);
      }
    }
  }
}


void availablecells() {
  cellsleft = rows*cols;
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (board[i][j].state != 0) cellsleft --;
    }
  }

  if(cellsleft > 1) {
    println(cellsleft + " cells available");
  }else if(cellsleft == 1) {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if(board[i][j].state == 0) board[i][j].state = 1;
      }
    }
  }else {
    println("game over! nobody wins.");

  }
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
    if (winner == 0){ text("Game over! Nobody wins.", width/2, height/2);}
    if (winner == 1){ text("Winner: Player 1", width/2, height/2);}
    if (winner == 2){ text("Winner: Player 2", width/2, height/2);}
}

void startGame() {

  winner = 0;
  cellsleft = rows*cols;
  player = int(random(1,2));

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      board[i][j].state = 0;
    }
  }
}
