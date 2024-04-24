class Link {
  Ball a;
  Ball b;
  float restitution;
  float radius;
  
  public Link(Ball a, Ball b, float restitution, float radius) {
    this.a = a;
    this.b = b;
    this.restitution = restitution;
    this.radius = radius;
  }
  
  void apply_constraint() {
    PVector axis = PVector.sub(b.current_pos, a.current_pos);
    float dist = axis.mag();
    PVector n = PVector.mult(PVector.div(axis, dist), 0.5f*(dist - radius));
    float a_share = (1.0f/a.inverse_mass) / (1.0f/a.inverse_mass + 1.0f/b.inverse_mass);
    float b_share = (1.0f/a.inverse_mass) / (1.0f/a.inverse_mass + 1.0f/b.inverse_mass);
    a.current_pos.add(PVector.mult(n, this.restitution*a_share));
    b.current_pos.sub(PVector.mult(n, this.restitution*b_share));
  }

}
