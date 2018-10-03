// The Sound does not work without importing this package

import processing.sound.*;  

// Initializes an array and a variable both of type Ball

Ball[] balls;
Ball player;

// Initializes an arraylist of the type Food

ArrayList<Food> foods;

// Initializes three sound files

SoundFile gameSoundtrack;
SoundFile gameOver;
SoundFile levelWin;

// Initializes variables of type float and int

float xPos; // Centre of x axis
float yPos; // Centre of y axis
int numOfFood;
float speed = 60;
float score = 0;

// Initializes variables of type boolean and String

boolean inPlayMode = false;
String endMessageLose = "Game Over!";
String endMessageWin = "Congratulations! You Win!";
String startGame = "Press Y to Start Game \n Press Z to Increase Difficulty \n Press X to Decrease Difficulty \n Collect the Yellow Squares \n Avoid the Red Balls  ";

// Initializes color variables

color black = (0);
color blue = (0xff4B4ABC);
color yellow = (0xffFFEB0A);

// Set up method

public void setup()
{

  size(800, 800); // size of window
  gameSoundtrack  = new SoundFile(this, "ArcadeTheme.wav"); // soundtrack
  gameSoundtrack.play();
  gameOver = new SoundFile(this, "GameOver.wav");  // Gameover sound
  levelWin = new SoundFile(this, "LevelWin.wav");  // Game Complete Sound
  textSize(20);
  balls = new Ball[10];
  foods = new ArrayList();
  foods.add(new Food());
  frameRate(speed);

  player = new Ball(mouseX, mouseY);  // Set player movement
  player.colour = color(blue);

  setBalls();
  numOfFood = 0;
}

// Draw Method

public void draw()
{
  background(254, 244, 232);

  textSize(10);
  fill(black);
  text("Speed: " + speed, 60, height - 35);
  text("Score: " + score, 150, height - 35);

  if (!inPlayMode) {
    textSize(30);
    textAlign(CENTER, CENTER);
    fill(black);
    text(startGame, width/2, height/2);
  } else if (inPlayMode) {

    if (numOfFood < 10)
    {
      if ( dist(player.position.x, player.position.y, foods.get(numOfFood).xPos, foods.get(numOfFood).yPos) <= 30) {
        numOfFood++;
        foods.add(new Food());
        speed = speed + 2;
        frameRate(speed);
        score = score + (10 * speed * 0.1f);
      }
      foods.get(numOfFood).draw();
    } else {
      textAlign(CENTER, CENTER);
      textSize(30);
      fill(black);
      levelWin.play();
      text(endMessageWin, width/2, height/2);
      frameRate(0);
      inPlayMode = false;
    }

    for (int index = 0; index < 10; index++) {
      balls[index].draw();
      balls[index].move();
    }


    for (int index = 0; index < 10; index++) {
      if ( dist(player.position.x, player.position.y, balls[index].position.x, balls[index].position.y) <= 30) {
        println("Collision");
        textAlign(CENTER, CENTER);
        textSize(30);
        fill(black);
        gameOver.play();
        text(endMessageLose, width/2, height/2);
        frameRate(0);
        inPlayMode = false;
      }
    }
    player.position = new PVector(mouseX, mouseY);
    player.draw();
  }
}

// Keyboard Input Method

public void keyPressed() {
  if (key == 'y' || key == 'Y') {
    inPlayMode = true;
  }
  if (key == 'z' || key == 'Z') {
    if (speed < 100) {
      speed = speed + 20;
    }
  }
  if (key == 'x' || key == 'X') {
    if (speed > 60) {
      speed = speed - 20;
    }
  }
}

// Positioning the dodgeballs

public void setBalls() {
  for (int i = 0; i < balls.length; i++) {
    xPos = random(15, 799);
    yPos = /*random(1, 799)*/0;
    balls[i] = new Ball(xPos, yPos);
  }
}
