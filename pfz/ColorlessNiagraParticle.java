import java.util.Random;

public abstract class ColorlessNiagraParticle implements Particle {
  private static final float INITIAL_GRAVITY = 0.1f;
  private static final float GRAVITY_FLUCTUATION = 0.02f;
  private static final float MAX_VELOCITY = 3;
  private final Vector2 bounds;

  private Vector2 position;
  private final Vector2 initialVelocity;
  private Vector2 velocity;
  private final Vector2 acceleration;

  public ColorlessNiagraParticle(Random rand, int maxX, int maxY) {
    position = new Vector2(rand.nextInt() % maxX, 0);
    velocity = Vector2.I.mult(0.1f + (rand.nextFloat() * 5.0f));
    initialVelocity = velocity;
    acceleration = Vector2.J.mult(INITIAL_GRAVITY + rand.nextFloat() * GRAVITY_FLUCTUATION);
    bounds = new Vector2(maxX, maxY);
  }

  @Override
  public void update() {
    position = position.add(velocity);
    velocity = velocity.add(acceleration);
    if (velocity.magnitude() > MAX_VELOCITY) {
      velocity = velocity.normalize().mult(MAX_VELOCITY);
    }
  }

  @Override
  public Vector2 getPosition() {
    return this.position;
  }

  @Override
  public int getSize() {
    return 1;
  }

  @Override
  public boolean isAlive() {
    return position.getX() < bounds.getX() &&
           position.getY() < bounds.getY();
  }
}
