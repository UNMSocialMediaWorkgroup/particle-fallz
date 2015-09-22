import java.util.Random;

public class StarParticle implements Particle {
  private static final double MAX_STRENGTH = 1.0;
  private static final double MIN_STRENGTH = 0.5;
  private static final double DELTA_STRENGTH = MAX_STRENGTH -
                                               MIN_STRENGTH;

  private static final double MAX_DELTA_THETA = 0.05;
  private static final double MIN_DELTA_THETA = 0.01;
  private static final double DELTA_DELTA_THETA =
    MAX_DELTA_THETA - MIN_DELTA_THETA;

  private static final double TAU = Math.PI * 2;

  private double strength = 0;
  private double theta;
  private double deltaTheta;
  private Vector2 position;

  public StarParticle(Random rand, int minX,
                      int minY, int maxX, int maxY) {
    deltaTheta = MIN_DELTA_THETA +
                 rand.nextFloat() * DELTA_DELTA_THETA;
    theta = rand.nextFloat() * TAU;
    position = new Vector2(
           (Math.abs(rand.nextInt() % (maxX - minX))) + minX,
           (Math.abs(rand.nextInt() % (maxY - minY))) + minY);
  }

  public void update() {
    theta += deltaTheta;
    if (theta > TAU) {
      theta -= TAU;
    }
    strength = Math.abs(Math.sin(theta)) * DELTA_STRENGTH +
               MIN_STRENGTH;
  }

  public Vector2 getPosition() {
    return position;
  }

  public int getColor() {
    int channel = (int)(0xff * strength) & 0xff;

    return (channel << 24) |
           (channel << 16) |
           (channel << 8)  |
           channel;
  }

  public int getSize() {
    return 0;
  }

  public boolean isAlive() {
    return true;
  }
}
