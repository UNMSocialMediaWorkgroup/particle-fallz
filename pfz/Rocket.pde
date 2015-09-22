public class Rocket implements RenderableParticle {
  public static final int HEIGHT = 6;
  public static final int FLAME_HEIGHT = 2;
  public static final int OFF_HEIGHT = HEIGHT - FLAME_HEIGHT;
  /* Rockets live to be one hour old */
  private static final long MAX_AGE = 60 * 60;
  private final Vector2 GRAVITY = new Vector2(-0.2, 0);

  private static final int FLAME_BOTTOM = 0xff505000;
  private static final int FLAME_TOP = 0xffffff00;
  private static final int CORRECT_BODY = 0xff00ff00;
  private static final int CORRECT_MIDDLE = 0xff007f00;
  private static final int INCORRECT_BODY = 0xffff0000;
  private static final int INCORRECT_MIDDLE = 0xff7f0000;
  private static final int NOSECONE = 0xff7f7f7f;

  private long creationTime;
  private int minX;
  private boolean correct;
  private boolean drawFlame = true;

  private Vector2 position;

  public void init(int question, int maxX, int minX,
                   boolean correct) {
    this.minX = minX;
    this.creationTime = getEpoch();
    this.correct = correct;
    position = new Vector2(maxX + HEIGHT, question);
  }

  public void update() {
    if (this.position.getX() - HEIGHT > minX) {
      this.position = this.position.add(GRAVITY);
      drawFlame = true;
    } else {
      drawFlame = false;
    }
  }

  public void setMinX(int minX) {
    this.minX = minX;
  }

  public void render() {
    int c = 0;
    for (int i = 0;
         i < HEIGHT - (drawFlame ? 0 : FLAME_HEIGHT); i++) {
      switch (i) {
      case 5: c = FLAME_BOTTOM; break;
      case 4: c = FLAME_TOP; break;
      case 3:
      case 1: c = correct ? CORRECT_BODY : INCORRECT_BODY;
        break;
      case 2: c = correct ? CORRECT_MIDDLE : INCORRECT_MIDDLE;
        break;
      case 0: c = NOSECONE; break;
      }
      stroke(c);
      fill(c);
      rect(position.getX() - i, position.getY(), 0, 0);
    }
  }

  public Vector2 getPosition() {
    return position;
  }

  public int getColor() {
    return 0xffffffff;
  }

  public int getSize() {
    return 0;
  }

  public boolean isAlive() {
    return (getEpoch() - creationTime) < MAX_AGE;
  }

  private long getEpoch() {
    return System.currentTimeMillis() / 1000;
  }
}
