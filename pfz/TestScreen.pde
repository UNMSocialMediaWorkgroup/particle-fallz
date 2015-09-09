public final class TestScreen implements Screen, UDPHandler {
  float cRadius = Math.min(Screen.WIDTH, Screen.HEIGHT);
  float theta = 0.0f;
  final float deltaTheta = 0.02f;
  Vector2 ellipseVector;

  @Override
  public void update() {
    theta += deltaTheta;
    ellipseVector = new Vector2(theta).mult(cRadius);
  }

  @Override
  public void render() {
    clear();
    fill(color(255, 128, 0));
    ellipse(ellipseVector.getX() + Screen.WIDTH,
            ellipseVector.getY() + Screen.HEIGHT, 20, 20);
  }

  @Override
  public void handleUDPValue(int value) {
    Log.info("Screen input value: " + value);
  }
}
