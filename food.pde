class Food {

  float xPos;
  float yPos;
  color yellow = #FFEB0A;

  Food() {
    xPos = random(20, 780);
    yPos = random(20, 780);
  }

  void draw() {
    fill(yellow);
    rect(xPos, yPos, 15, 15);
  }
}
