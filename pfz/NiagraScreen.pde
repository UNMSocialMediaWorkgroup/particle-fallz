import java.util.LinkedList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

public final class NiagraScreen implements PFZScreen, UDPHandler {
  private static final int WIDTH = 1000;
  private static final int HEIGHT = 480;
  private static final int PARTICLES_PER_FRAME = 15;
  private static final int FLAMING_PARTICLES_PER_FRAME = 5;
  private final Random rand = new Random();

  private int flamingParticlesLeft = 0;

  private static final int TRAIL_MASK = 0x10000000;
  private final List<Particle> particles = new LinkedList<Particle>();

  @Override
  public int getWidth() {
    return WIDTH;
  }

  @Override
  public int getHeight() {
    return HEIGHT;
  }

  @Override
  public void update() {
    for (int i = 0; i < PARTICLES_PER_FRAME; i++) {
      particles.add(new NiagraStandardParticle(rand, WIDTH, HEIGHT));
    }
    for (Particle p : particles) {
      p.update();
    }
  }

  @Override
  public void render() {
    fill(TRAIL_MASK);
    stroke(TRAIL_MASK);
    rect(0, 0, WIDTH, HEIGHT);

    for (Particle p : particles) {
      stroke(p.getColor());
      ellipse(p.getPosition().getX(), p.getPosition().getY(),
              p.getSize(), p.getSize());
    }

    if (flamingParticlesLeft > 0) {
      for (int i = 0; i < FLAMING_PARTICLES_PER_FRAME; i++) {
        particles.add(new NiagraFlamingParticle(rand, WIDTH, HEIGHT));
      }
      flamingParticlesLeft--;
    }

    Iterator<Particle> i = particles.listIterator();
    while (i.hasNext()) {
      Particle p = i.next();
      if (!p.isAlive()) {
        i.remove();
      }
    }
  }

  @Override
  public void handleUDPValue(int value) {
    flamingParticlesLeft += value;
  }
}
