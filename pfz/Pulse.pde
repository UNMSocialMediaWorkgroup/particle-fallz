public class Pulse implements RenderableParticle {
  private static final float FADE_RATE = 0.9;

  private int clr;
  private Vector2 position;
  private int maxX;
  private int minX;
  private int minY;
  private int maxY;

  public Pulse(int maxX, int minX, int minY, int maxY) {
    this.position = new Vector2(minX, (maxY + minY) / 2.0);
    this.maxX = maxX;
    this.minX = minX;
    this.maxY = maxY;
    this.minY = minY;
    this.clr = generateColor();
  }

  public void update() {
    this.position = this.position.add(Vector2.I);
  }

  public void render() {

    renderLoop(1.0f, 0);


  }

  private void renderLoop(float initial, int delta) {
    if (initial >= 0.01) {
      int col = (clr & 0xffffff) | (int(initial * 255) << 24);
      stroke(col);
      fill(col);
      rect(position.getX() + delta, minY, 0, maxY - minY);
      rect(position.getX() - delta, minY, 0, maxY - minY);
      renderLoop(initial * FADE_RATE, delta + 1);
    }
  }

  public Vector2 getPosition() {
    return new Vector2(0, 0);
  }

  public int getColor() {
    return 0;
  }

  public int getSize() {
    return 1;
  }

  public boolean isAlive() {
    return position.getX() <= maxX;
  }

  private int generateColor() {
    int green = int(random(128));
    return 0xff0000ff | (green << 8);
  }
}
