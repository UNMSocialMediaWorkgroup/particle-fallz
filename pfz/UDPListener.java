public interface UDPListener {
  void start();

  void stop();

  byte[] getMessage();
}
