class Simulator {
 ArrayList<PointMass> points;
 ArrayList<Constraint> constraints;
 ArrayList<CollisionSystem> universal_constraints;
 
 // Gravity and container are technically force-generator/constraints
 // but they affect everything and are pretty ubiquitious so for sake
 // of optimization they will get special treatement
 PVector gravity = new PVector(0, 10000);
 
 public Simulator() {
  points = new ArrayList();
  constraints = new ArrayList();
  universal_constraints = new ArrayList();
 }
 
 void update(float dt) {   
   // We'll apply gravity here
   for (PointMass p : points)
     p.accelerate(PVector.div(gravity, p.inverse_mass)); // Gravity doesn't care about mass
   
   // Make sure PointMasses don't go through each other
   resolve_collisions();
   
   // Make sure they're following their constraints
   for (Constraint c: constraints)
     c.apply_constraint();
   
   // Container gets to be a special universal constraint because i say so
   for (PointMass p : points)
     apply_container_constraint(p);
     
   for (CollisionSystem u: universal_constraints)
     for(PointMass p: points)
       u.apply_constraint(p);
   
   // Move all the points
   for (PointMass p : points)
   p.update(dt);
 }
 
 void apply_container_constraint(PointMass a) {
   PVector center = new PVector(400, 200);
   float radius = 300;
   PVector axis = PVector.sub(center, a.current_pos);
   float dist = axis.mag();
   if (dist > radius - a.radius) {
     PVector n = PVector.mult(PVector.div(axis, dist), (dist - radius + a.radius));
     a.current_pos.add(n);
   }
 }
 
 void resolve_collisions() {
   PVector collision_axis;
   PVector n;
   float delta = 0;
   float total_mass = 0; // TODO: The mass interfacing here could be better optimized
   float a_share = 0;
   float b_share = 0;
  
   for (PointMass a: points) { // I love double iterating wowheee!
     for (PointMass b: points) {
       if (a == b) continue;
       collision_axis = PVector.sub(a.current_pos, b.current_pos);
       if (a.current_pos.dist(b.current_pos) < (a.radius + b.radius)) {
         n = PVector.div(collision_axis, collision_axis.mag());
         delta = a.radius + b.radius - a.current_pos.dist(b.current_pos);
         total_mass = (1.0f/a.inverse_mass + 1.0f/b.inverse_mass);
         a_share = (1.0f/a.inverse_mass) / total_mass;
         b_share = 1 - a_share;
         
         a.current_pos.add(PVector.mult(n, delta*b_share));
         b.current_pos.sub(PVector.mult(n, delta*a_share));
       }
     }
   }
   // We'll implement spatial partitioning... eventually
 }
 
 void add_point(float x, float y, float radius, float mass) {
   points.add(new PointMass(x, y, radius));
 }
 
 void add_constraint(Constraint constraint) {
   constraints.add(constraint);
 }

 void add_universal_constraint(CollisionSystem constraint) {
   universal_constraints.add(constraint);
 }

}
