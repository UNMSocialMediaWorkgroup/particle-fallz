import java.util.Random;

public final class NiagraFlamingParticle extends ColorlessNiagraParticle {
  private final int color;

  public NiagraFlamingParticle(Random rand, int maxX, int maxY) {
    super(rand, maxX, maxY);
    color = 0xFFFF0000 | (rand.nextInt() & 0xFF00);
  }

  public int getColor() {
    return this.color;
  }
}
