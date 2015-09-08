import java.io.PrintStream;

public final class Log {
  private static LogLevel level = LogLevel.INFO;
  private static PrintStream stream = System.err;

  public static void setLevel(LogLevel level) {
    Log.level = level;
  }

  public static void setPrintStream(PrintStream stream) {
    Log.stream = stream;
  }

  public static void error(String message) {
    if (level.getValue() >= LogLevel.ERROR.getValue()) {
      stream.println("[ERROR]: " + message);
    }
  }

  public static void warning(String message) {
    if (level.getValue() >= LogLevel.WARNING.getValue()) {
      stream.println("[WARNING]: " + message);
    }
  }

  public static void debug(String message) {
    if (level.getValue() >= LogLevel.DEBUG.getValue()) {
      stream.println("[DEBUG]: " + message);
    }
  }

  public static void info(String message) {
    if (level.getValue() >= LogLevel.INFO.getValue()) {
      stream.println("[INFO]: " + message);
    }
  }
}
