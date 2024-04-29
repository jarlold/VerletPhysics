//class QuadCollider implements CollisionSystem {
  
//  PVector top_left, bottom_right, bottom_left, top_right;
  
//  public QuadConstraint(float x, float y, float edge_length) {
//    this.top_left = new PVector(x - edge_length/2.0, y - edge_length/2.0, 2);
//    this.top_right = new PVector(x + edge_length/2.0, y - edge_length/2.0, 2);
//    this.bottom_right = new PVector(x + edge_length/2.0, y + edge_length/2.0, 2);
//    this.bottom_left = new PVector(x - edge_length/2.0, y + edge_length/2.0, 2);
//  }
  
//  float triangle_area(PVector A, PVector B, PVector C) {
//     return abs(( (A.x * (B.y - C.y) + B.x * (C.y - A.y) + C.x * (A.y - B.y)) / 2.0)); 
//   }

//   boolean inside_triangle(PVector A, PVector B, PVector C, PVector P) {
//     float sum = triangle_area(P, B, C);
//     sum += triangle_area(A, P, C);
//     sum += triangle_area(A, B, P);
//     return ( triangle_area(A, B, C) == sum );
   
//   }
   
//   boolean inside_quad(PVector point) {
//     return inside_triangle(top_left, bottom_left, bottom_right, point) |
//            inside_triangle(top_left, top_right, bottom_right, point);
//   }
  
  
//  public void apply_constraint(PointMass p) {}
    
//}
