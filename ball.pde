class Ball {

  PVector position;    // Position of the ball.
  PVector velocity;    // Amount it moves on each redraw.
  float radius;        // Radius of ball.
  color colour;        // Colour of ball.
  // 

  Ball(float xPos, float yPos) {
    position = new PVector(xPos, yPos);
    velocity = new PVector(random(3,5), random(3,5));
    radius = 15;
    colour   = color(214, 93, 69);
  }

  void draw() {
    // Draw the ball.
    noStroke();
    fill(colour);
    ellipse(position.x, position.y, 2*radius, 2*radius);
  }
  void move() {
    
    // Update the ball position according to the velocity values.
    position.x = position.x + velocity.x;
    position.y = position.y + velocity.y;

    if (position.x - radius < 0 && velocity.x < 0)
    {
      // Escaping to the left, start moving right.
      velocity.x = -1*velocity.x;
    } else if (position.x + radius > width && velocity.x > 0)
    {
      // Escaping to the right, start moving left.
      velocity.x = -1*velocity.x;
    }

    if (position.y - radius < 0 && velocity.y < 0)
    {
      // Escaping upwards, start moving down.
      velocity.y = -1*velocity.y;
    } else if (position.y + radius > height && velocity.y > 0)
    {
      // Escaping downwards, start moving up.
      velocity.y = -1*velocity.y;
    }
  }
}
