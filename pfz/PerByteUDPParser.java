public final class PerByteUDPParser implements UDPParser {
  @Override
  public int convertMessage(byte[] bytes) {
    return (int)bytes[0];
  }
}
