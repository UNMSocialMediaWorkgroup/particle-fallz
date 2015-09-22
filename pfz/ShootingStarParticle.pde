import java.util.Random;

public class ShootingStarParticle
  implements RenderableParticle {
  private static final double STRENGTH_MULTIPLIER = 0.8;
  private static final int MIN_X = 40;

  private Vector2 position;
  private final int maxHeight;

  public ShootingStarParticle(Random rand,
                              int maxHeight,
                              int maxWidth) {
    this.maxHeight = maxHeight;
    position = new Vector2(maxHeight - 1,
                           Math.abs(rand.nextInt() % maxWidth));
  }

  public void update() {
    position = position.add(new Vector2(-1, 0));
  }

  public void render() {
    renderLoop(1.0, 0);
  }

  public Vector2 getPosition() {
    return position;
  }

  public int getColor() {
    return 0;
  }

  public int getSize() {
    return 0;
  }

  public boolean isAlive() {
    return position.getX() > 0;
  }

  private void renderLoop(double strength, int tail) {
    if (strength < 0.001 ||
        position.getX() + tail >= maxHeight) {
    } else {
      int component = (int)(0xff * strength) & 0xff;
      int x = (int)(position.getX() + tail);
      int c = (component << 24) |
              (component << 16) |
              (component << 8)  |
              component;
      if (x >= MIN_X) {
        fill(c);
        stroke(c);
        rect(x, position.getY(), 0, 0);
      }
      renderLoop(strength * STRENGTH_MULTIPLIER, tail + 1);
    }
  }
}
