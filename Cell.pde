public class Cell {
  int state;
  float x, y, w, h;

  Cell(float x, float y, float w, float h) {
    this.state = 0;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  boolean click(int mx, int my, int player) {
    if (mx >= x && mx < x + w && my >= y && my < y + h) {
      state = player;
      return true;
    } else {
      return false;
    }
  }

  void display() {
    stroke(0);
    noFill();
    rect(x,y,w,h);

    float b = 8.0f;

    if (state == 0) {
      // nothing
    } else if (state == 1) {
      // Draw an O
      ellipse(x+w/2,y+h/2,w-b,h-b);
    } else if (state == 2) {
      // Draw an X
      line(x+b,y+b,x+w-b,y+h-b);
      line(x+w-b,y+b,x+b,y+h-b);
    }
  }
}
