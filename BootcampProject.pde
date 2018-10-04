// The Sound does not work without importing this package

import processing.sound.*;  

// Initializes an array and a variable both of type Ball

Ball[] balls;
Ball player;

// Initializes an arraylist of the type Food

ArrayList<Food> foods;

// Initializes three sound files

SoundFile gameSoundtrack, gameOver, levelWin;

// Initializes variables of type float and int

float xPos; // Centre of x axis
float yPos; // Centre of y axis
int numOfFood;
float speed = 60;
float score = 0;
float newScore;

// Initializes variables of type boolean and String

boolean inPlayMode = false;
boolean winGame = false;
boolean endGame = false;
String endMessageLose;
String endMessageWin = "Congratulations! You Win! \n Your score: " + newScore;
String startGame = "Press Y to Start Game \n Press Z or X to Alternate Levels \n Press Q to Exit \n \n \n \n Collect the Yellow Squares \n Avoid the Red Balls  ";

// Initializes color variables

color black = (0);
color blue = (0xff4B4ABC);
color yellow = (0xffFFEB0A);

// Set up method

public void setup()
{
  size(800, 800); // size of window
  gameSoundtrack  = new SoundFile(this, "ArcadeTheme.wav"); // soundtrack
  gameOver = new SoundFile(this, "GameOver.wav");  // Gameover sound
  levelWin = new SoundFile(this, "LevelWin.wav");  // Game Complete Sound
  textSize(20);
  balls = new Ball[10];
  foods = new ArrayList();
  foods.add(new Food());
  frameRate(speed);
  gameSoundtrack.loop();

  player = new Ball(mouseX, mouseY);  // Set player movement
  player.colour = color(blue);

  setBalls();
  numOfFood = 0;

  winGame = false;
  endGame = false;
}

// Draw Method

public void draw()
{
  background(254, 244, 232);

  mainMenu();

  if (inPlayMode) {

    background(254, 244, 232);

    player.position = new PVector(mouseX, mouseY);
    player.draw();
    textSize(15);
    fill(black);
    text("speed: " + speed, 60, height - 35);
    text("Score: " + score, 250, height - 35);

    if (numOfFood < 10)
    {
      if ( dist(player.position.x, player.position.y, foods.get(numOfFood).xPos, foods.get(numOfFood).yPos) <= 30) {
        
        // If player gets yellow squares then another is added into the array and the speed is increased. The score is also multiplied.
        
        numOfFood++;
        foods.add(new Food());
        speed = speed + 2;
        frameRate(speed);
        score = score + (10 * speed * 0.1f);
      }
      foods.get(numOfFood).draw();
    } else {
      winGame = true;
    }
    
    // Creating dodgeballs from the array using the ball class

    for (int index = 0; index < 10; index++) {
      balls[index].draw();
      balls[index].move();
    }
    
    // If player collides with dodgeballs then it triggers game over.

    for (int index = 0; index < 10; index++) {
      if ( dist(player.position.x, player.position.y, balls[index].position.x, balls[index].position.y) <= 30) {
        endGame = true;
        gameOver.play();
      }
    }
  }
  if (endGame) {
    end_Game();
  }
  if (winGame) {
    win_Game();
  }
}

// Keyboard Input Methods

public void keyPressed() {
  if (key == 'y' || key == 'Y') {
    inPlayMode = true;
    endGame = false;
  }
  
  // Changing levels using z and x
  
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
  
  // The r key is used to return back to main menu and all variables are reset for new game
  
  if (key == 'r' || key == 'R') {
    inPlayMode = false;
    endGame = false;
    winGame = false;
    mainMenu();
    foods.clear();
    foods.add(new Food());
    numOfFood = 0;
    score = 0;
    newScore = 0;
    speed = 60;
  }
  
  // The q key is used to quit from the main menu. Quickest way to quit the game.
  
  if (key == 'q' || key == 'Q') {
    System.exit(0);
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

// Changing levels method corresponding to speed.

public int changeLevels() {
  if (speed == 60) {
    return 1;
  } else if (speed == 80) {
    return 2;
  } else if (speed == 100) {
    return 3;
  } 
  return 0;
}

// Main menu method which sorts the main menu screen

void mainMenu() {
  background(254, 244, 232);
  textSize(30);
  fill(black);
  text("level: " + changeLevels(), 60, height - 35);
  text("Score: " + score, 250, height - 35);
  textSize(30);
  textAlign(CENTER, CENTER);
  fill(black);
  text(startGame, width/2, height/2);
}

// Game over method which reacts to player colliding with dodgeballs

void end_Game() {
  background(254, 244, 232);
  println("Collision");
  textAlign(CENTER, CENTER);
  textSize(30);
  fill(black);
  newScore = score;
  endMessageLose = "Game Over! \n Your score: " + newScore + "\n Press R to Return to Main Menu";
  text(endMessageLose, width/2, height/2);
}

// Case of completion method which sends a congrats message and presents their score

void win_Game() {
  background(254, 244, 232);
  textAlign(CENTER, CENTER);
  textSize(30);
  fill(black);
  newScore = score;
  endMessageWin = "Congratulations! You Win! \n Your score: " + newScore;
  text(endMessageWin, width/2, height/2);
}
