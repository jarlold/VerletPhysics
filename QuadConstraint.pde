class QuadConstraint {
  PVector top_left;
  PVector bottom_right;
  PVector bottom_left;
  PVector top_right;
  
  public QuadConstraint(PVector top_left, PVector bottom_right) {
    this.top_left = top_left;
    this.bottom_right = bottom_right;
    // We'll store this instead of computing them all the time because 
    // we're gonna make the inside_quad check A LOT
    this.bottom_left = new PVector(top_left.x, bottom_right.y);
    this.top_right = new PVector(bottom_right.x, top_left.y);
  }
   
   float triangle_area(PVector A, PVector B, PVector C) {
     return abs(( (A.x * (B.y - C.y) + B.x * (C.y - A.y) + C.x * (A.y - B.y)) / 2.0)); 
   }
   
   boolean inside_triangle(PVector A, PVector B, PVector C, PVector P) {
     float sum = triangle_area(P, B, C);
     sum += triangle_area(A, P, C);
     sum += triangle_area(A, B, P);
     return ( triangle_area(A, B, C) == sum );
   
   }
   
   boolean inside_quad(PVector point) {
     return inside_triangle(top_left, bottom_left, bottom_right, point) |
            inside_triangle(top_left, top_right, bottom_right, point);
   }
   
   public void draw() {
    if (inside_quad( new PVector(mouseX, mouseY)))
      fill(255, 0, 0);
    else
      fill(255, 255, 255);
     
    circle(top_left.x, top_left.y, 15);
    circle(bottom_left.x, bottom_left.y, 15);
    circle(bottom_right.x, bottom_right.y, 15);
    circle(top_right.x, top_right.y, 15);
   }
  
}
