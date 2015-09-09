public final class Vector2 {
  private final float x;
  private final float y;

  public Vector2(float x, float y) {
    this.x = x;
    this.y = y;
  }

  public Vector2(float theta) {
    this.x = (float)Math.cos(theta);
    this.y = (float)Math.sin(theta);
  }

  public float getX() {
    return this.x;
  }

  public float getY() {
    return this.y;
  }

  public Vector2 add(Vector2 other) {
    return new Vector2(x + other.x, y + other.y);
  }

  public Vector2 mult(float scalar) {
    return new Vector2(x * scalar, y * scalar);
  }
}
