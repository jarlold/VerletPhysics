Simulator simulator;
LineCollider l;


void setup() {
  size(800, 600);
  frameRate(60);
  background(0);
  simulator = new Simulator();
  simulator.add_point(400, 200, 20, 1);
  simulator.add_universal_constraint(
    new LineCollider(400+100, 350, 400-100, 300)
  );
 
}

void draw() {
  background(0);
  noFill();
  stroke(255);
  circle(400, 200, 300*2);
  simulator.update(0.2/frameRate);
  for (PointMass p : simulator.points)
    p.draw();
  stroke(255);

  line(400-100, 300, 400+100, 350);
  
  if (mousePressed) 
    simulator.points.get(0).current_pos = new PVector(mouseX, mouseY);
}
