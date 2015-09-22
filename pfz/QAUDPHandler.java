public abstract class QAUDPHandler implements UDPHandler {
  @Override
  public void handleUDPValue(int value) {
    boolean correct = (value & 1) > 0;
    if (correct) {
      handleCorrect(value >> 4);
    } else {
      handleIncorrect(value >> 4);
    }
  }

  public abstract void handleCorrect(int question);

  public abstract void handleIncorrect(int question);
}
