public abstract class FalseUDPOscillator implements UDPListener {
  private float theta = 0.0f;

  protected abstract float getThetaDelta();

  @Override
  public void start() {
    /* Do nothing */
  }

  @Override
  public void stop() {
    /* Do nothing */
  }
}
