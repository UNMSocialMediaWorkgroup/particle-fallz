public enum LogLevel {
  NONE(0),
  ERROR(1),
  WARNING(2),
  DEBUG(3),
  INFO(4);

  private final int value;

  private LogLevel(int value) {
    this.value = value;
  }

  public int getValue() {
    return this.value;
  }
}
