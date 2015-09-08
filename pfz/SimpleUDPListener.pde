import hypermedia.net.UDP;
import java.io.UnsupportedEncodingException;
import java.util.Queue;
import java.util.concurrent.ConcurrentLinkedQueue;

public final class SimpleUDPListener implements UDPListener {
  public static final int PORT = 6982;
  private UDP udp = new UDP(this, PORT);
  private final Queue<byte[]> messages = new ConcurrentLinkedQueue<byte[]>();

  public void start() {
    udp.listen(true);
    Log.info("UDP initialized, listening on port " + PORT);
  }

  public void stop() {
    udp.close();
  }

  public byte[] getMessage() {
    return messages.poll();
  }

  public void receive(byte[] data) {
    messages.add(data);
    try {
      Log.info("UDP Receive (Bytes as UTF-8): " + new String(data, "UTF-8"));
    } catch (UnsupportedEncodingException e) {
      Log.error("UDP.receive: Unsupported format: " + e.getMessage());
      e.printStackTrace();
    }
  }
}
