class Ball {
  PVector current_pos, previous_pos, acceleration;
  float radius;
  float inverse_mass;
  color c = color(255, 255, 255);
  
  void draw() {
    fill(c);
    circle(
      current_pos.x,
      current_pos.y,
      radius*2
    );
  }
  
  void update(float dt) {
    PVector velocity = PVector.sub(current_pos, previous_pos);
    velocity.mult(0.9);
    previous_pos = new PVector(current_pos.x, current_pos.y);
    
    current_pos.add(velocity);
    current_pos.add(PVector.mult(acceleration, dt*dt*this.inverse_mass));
    
    acceleration = new PVector(0f, 0f); 
  }
  
  void accelerate(PVector amount) {
    acceleration.add(amount);
  }
  
  void reset_momentum() {
    this.previous_pos = current_pos;
  }
  
  public Ball(float x, float y, float radius) {
    this.radius = radius;
    this.inverse_mass = 1.0f/(PI*this.radius*this.radius*1); // Our material has a density of 1 unit per pixel squared I guess
    acceleration = new PVector(0, 0);
    current_pos = new PVector(x, y);
    previous_pos = new PVector(x, y);
  }
}
