class LineCollider implements CollisionSystem {
  PVector a, b;
  
  public LineCollider(float ax, float ay, float bx, float by) {
    this.a = new PVector(ax, ay);
    this.b = new PVector(bx, by);
  }
  
  float dist(PVector p) {
      float x_diff = b.x - a.x;
      float y_diff = b.y - a.y;
      float num = abs(y_diff*p.x - x_diff*p.y + b.x*a.y - b.y * a.x);
      float den = sqrt( pow(y_diff, 2) + pow(x_diff, 2));
      return num/den;
  }
  
  void apply_constraint(PointMass p) {
    // if we're not in the square box defined by the line then we can't collide with the line
    // so don't bother doing any complicated maths
    // (this also makes sure we collide with the line segment
    if ( a.x < b.x & (p.current_pos.x + p.radius < a.x | p.current_pos.x - p.radius > b.x))
      return;
      
    if ( a.x > b.x & (p.current_pos.x - p.radius > a.x | p.current_pos.x + p.radius < b.x))
      return; 
    
    // Same but along the Y axis
    if ( a.y < b.y & (p.current_pos.y + p.radius < a.y | p.current_pos.y - p.radius > b.y))
      return;
      
    if ( a.y > b.y & (p.current_pos.y - p.radius > a.y | p.current_pos.y + p.radius< b.y))
      return; 
      
    float theta;
    PVector l;
    PVector vel; 
    // And then make sure he's actually touching the line of course
    if (dist(p.current_pos) < p.radius) {
      vel = PVector.sub(p.current_pos, p.previous_pos);
      l = PVector.sub(a, b);
      theta = PVector.angleBetween(vel, l);
      
      if ( a.y + p.previous_pos.x*l.y/l.x < p.previous_pos.y)
        theta = -theta;
      
      theta = PI + l.heading() - theta;
      
      p.current_pos.add( PVector.mult(PVector.fromAngle(theta), vel.mag()));
      
    }
  }
  
}
