ArrayList<Ball> balls;
Solver solver ;
int count;
void setup() {
  count = 0;
  background(0);
  size(800, 600);
  frameRate(60);
  balls = new ArrayList();
  balls.add(new Ball(400, 150, 10));
  balls.add(new Ball(400, 250, 10));
  balls.add(new Ball(500, 150, 10));
  balls.add(new Ball(500, 250, 10));
  //balls.get(0).inverse_mass = 1.0f;
  balls.get(0).c = color(255, 0, 0);
  
  solver = new Solver(balls);
  solver.add_link(balls.get(0), balls.get(1), 1, 100);
  solver.add_link(balls.get(2), balls.get(0), 1, 100);
  solver.add_link(balls.get(3), balls.get(2), 1, 100);
  solver.add_link(balls.get(3), balls.get(1), 1, 100);
  solver.add_link(balls.get(3), balls.get(0), 1, 141.42);
  solver.add_link(balls.get(2), balls.get(1), 1, 141.42);
}

void draw() {
  background(0);
  noFill();
  stroke(255);
  circle(400, 300, 600);
  fill(255);
  solver.update(0.5/frameRate);
  for (Ball b : balls) {
    b.draw();
    for (Ball a: balls)
      line(a.current_pos.x, a.current_pos.y, b.current_pos.x, b.current_pos.y);
  }
  
  if (mousePressed) balls.get(1).current_pos = new PVector(mouseX, mouseY); 
}
