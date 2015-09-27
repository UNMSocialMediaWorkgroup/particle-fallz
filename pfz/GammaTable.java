public final class GammaTable {
  private static final double GAMMA = 1.7;
  private static int[] table = new int[256];

  static {
    for (int i = 0; i < table.length; i++) {
      table[i] = (int)(Math.pow((float)i / 255.0, GAMMA) * 255.0 + 0.5);
    }
  }

  public int get(int i) {
    return i % table.length;
  }
}
