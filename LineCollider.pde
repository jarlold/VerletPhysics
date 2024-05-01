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
    
    // The way im computing the normal angle is not very efficient...
    float theta;
    float new_theta;
    PVector AtoB;
    PVector vel;
    PVector new_vel;
    
    // And then make sure he's actually touching the line of course
    if (dist(p.current_pos) < p.radius) {
      vel = PVector.sub(p.current_pos, p.previous_pos);
      AtoB = PVector.sub(a, b);
      theta = PVector.angleBetween(vel, AtoB);
      
      new_theta = AtoB.heading() + PI - theta;
      new_vel = PVector.fromAngle(new_theta);
      
      // There's two ways to rotate by theta, one brings us to the reflected angle
      // the other brings us back to the original. We want the reflect angle.
      if (round(degrees(PVector.angleBetween(vel, new_vel))) == 180)
        new_vel.rotate(2*theta);
      
      // Set our point mass to face the right way with the right velocity
      new_vel.mult(vel.mag());
      p.previous_pos = new PVector(p.current_pos.x, p.current_pos.y);
      p.current_pos.sub(new_vel);
    }
  }
  
}
