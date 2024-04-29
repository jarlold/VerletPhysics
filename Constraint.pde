public interface Constraint {
  public void apply_constraint();
}

public interface CollisionSystem {
  public void apply_constraint(PointMass p);
}
