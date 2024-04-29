class AnchorConstraint implements Constraint {
  PointMass a;
  PVector b;
  float restitution;
  float radius;
  
  public AnchorConstraint(PointMass a, PVector b, float restitution, float radius) {
    this.a = a;
    this.b = b;
    this.restitution = restitution;
    this.radius = radius;
  }
  
  void apply_constraint() {
    //TODO: Need to make this go through accelerate somehow, otherwise constraint
    // won't respect masses
    PVector axis = PVector.sub(b, a.current_pos);
    float dist = axis.mag();
    if (dist > radius - a.radius) {
      PVector n = PVector.mult(PVector.div(axis, dist), (dist - radius + a.radius));
      a.current_pos.add(PVector.mult(n, this.restitution));
    }
  }
}
