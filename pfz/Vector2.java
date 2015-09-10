public final class Vector2 {
  private final float x;
  private final float y;

  public static final Vector2 I = new Vector2(1, 0);
  public static final Vector2 J = new Vector2(0, 1);

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

  public Vector2 setX(float x) {
    return new Vector2(x, this.y);
  }

  public Vector2 setY(float y) {
    return new Vector2(this.x, y);
  }

  public Vector2 add(Vector2 other) {
    return new Vector2(x + other.x, y + other.y);
  }

  public Vector2 mult(float scalar) {
    return new Vector2(x * scalar, y * scalar);
  }

  public float magnitude() {
    return (float)Math.sqrt(x * x + y * y);
  }

  public Vector2 normalize() {
    float mag = magnitude();
    return new Vector2(x / mag, y / mag);
  }
}
