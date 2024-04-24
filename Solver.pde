class Solver {
  PVector gravity = new PVector(0, 10000f);
  ArrayList<Ball> balls;
  ArrayList<Link> links;
  
  public Solver(ArrayList<Ball> balls) {
    this.links = new ArrayList();
    this.balls = balls;
    apply_all_constraints();
    for (Ball b: balls) b.reset_momentum();
  }
  
  void add_link(Ball a, Ball b, float restitution, float radius) {
    links.add(new Link(a, b, restitution, radius));
  }
  
  void unlink_ball(Ball b) {
    for (Link l : links)
      if (l.a == b | l.b == b)
        links.remove(l);
  }
  
  void update(float dt) {
    apply_gravity();
    apply_all_constraints();
    update_positions(dt);
  }
  
  void apply_all_constraints() {
    // Constraints are listed least to most important
    resolve_collisions();
    apply_container_constraint();
    apply_link_constraints();
  }
  
  void update_positions(float dt) {
    for (Ball b: balls) {
      b.update(dt);
    }
  }
  
  void apply_gravity() {
    for (Ball b: balls) {
      b.accelerate(PVector.div(gravity, b.inverse_mass));
    }
  }
  
  void apply_container_constraint() {
    PVector centre = new PVector(400, 300);
    float radius = 300;
    float dist;
    PVector to_obj;
    PVector n;
    
    for (Ball b : balls) {
      to_obj = PVector.sub(b.current_pos, centre);
      dist = to_obj.mag();
      if (dist > radius - b.radius) {
        n = PVector.div(to_obj, dist);
        b.current_pos = PVector.add(centre, PVector.mult(n, radius - b.radius));
      }
    }
  }
  
  void apply_link_constraints() {
    for (Link l : links)
      l.apply_constraint();
  }
  
  void resolve_collisions() {
    PVector collision_axis;
    PVector n;
    float delta = 0;
    
    for (Ball a: balls) { // I love double iterating wowheee!
      for (Ball b: balls) {
        if (a == b) continue;
        collision_axis = PVector.sub(a.current_pos, b.current_pos);
        if (a.current_pos.dist(b.current_pos) < (a.radius + b.radius)) {
          n = PVector.div(collision_axis, collision_axis.mag());
          delta = a.radius + b.radius - a.current_pos.dist(b.current_pos);
          a.current_pos.add(PVector.mult(n, 0.5*delta));
          b.current_pos.sub(PVector.mult(n, 0.5*delta));
        }
      }
    }
    
    // We'll implement spatial partitioning... eventually
  }
  
  
}
