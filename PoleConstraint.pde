class LineConstraint implements Constraint {
  PointMass a;
  PointMass b;
  float restitution;
  float radius;
  boolean is_rigid = false;
  
  public LineConstraint(PointMass a, PointMass b, float restitution, float radius) {
    this.a = a;
    this.b = b;
    this.restitution = restitution;
    this.radius = radius;
  }
  
  public LineConstraint(PointMass a, PointMass b, float restitution, float radius, boolean is_rigid) {
    this.a = a;
    this.b = b;
    this.restitution = restitution;
    this.radius = radius;
    this.is_rigid = is_rigid;
  }
  
  
  void apply_constraint() {
    //TODO: Need to make this go through accelerate somehow, otherwise constraint
    // won't respect masses
    PVector axis = PVector.sub(b.current_pos, a.current_pos);
    float dist = axis.mag();
    if (dist > radius - a.radius | !this.is_rigid) {
      PVector n = PVector.mult(PVector.div(axis, dist), 0.5f*(dist - radius));
      a.current_pos.add(PVector.mult(n, this.restitution));
      b.current_pos.sub(PVector.mult(n, this.restitution));
    }
  }
}
