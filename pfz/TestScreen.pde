public final class TestScreen implements Screen, UDPHandler {
  @Override
  public void update() {

  }

  @Override
  public void render() {
    clear();
    ellipse(mouseX, mouseY, 20, 20);
  }

  @Override
  public void handleUDPValue(int value) {
    Log.info("Screen input value: " + value);
  }
}
