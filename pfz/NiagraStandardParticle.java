import java.util.Random;

public final class NiagraStandardParticle extends ColorlessNiagraParticle {
  private final int color;

  public NiagraStandardParticle(Random rand, int maxX, int maxY) {
    super(rand, maxX, maxY);
    color = 0xFF0000FF | (rand.nextInt() & 0xFF00);
  }

  public int getColor() {
    return this.color;
  }
}
