public enum StarlightState {
  IDLE(0, null),
  HANDLE_CORRECT(250, IDLE),
  HANDLE_INCORRECT(250, IDLE);

  public final int length;
  public final StarlightState nextState;

  private StarlightState(int length,
                        StarlightState nextState) {
    this.length = length;
    this.nextState = nextState;
  }
}
