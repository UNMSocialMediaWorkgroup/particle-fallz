public class SkylightUDPParser implements UDPParser {
  public int convertMessage(byte[] message) {
    String str = new String(message);
    int ans = 0;
    int correct;
    String[] splits = str.split(",");

    correct = Integer.parseInt(splits[2]);

    ans = ((Integer.parseInt(splits[3]) & 0xf) << 4) | correct;
    return ans;
  }
}
