public class Ray {
  private static final int CORRECT_COLOR = 0xff00ff00;
  private static final int INCORRECT_COLOR = 0xffff0000;

  private static final int SKIP_RECTS = 5;
  private final int questionNum;
  private int skipOffset = 0;
  private final int minX;
  private final int maxX;
  private final boolean correct;

  public Ray(int questionNum, int minX,
             int maxX, boolean correct) {
    this.questionNum = questionNum;
    this.minX = minX;
    this.maxX = maxX;
    this.correct = correct;
  }

  public void update() {
    skipOffset = (skipOffset + 1) % SKIP_RECTS;
  }

  public int getQuestionNum() {
    return questionNum;
  }

  public void render() {
    int c = correct ? CORRECT_COLOR : INCORRECT_COLOR;
    stroke(c);
    fill(c);
    for (int i = minX + skipOffset; i < maxX; i += SKIP_RECTS) {
      rect(i, questionNum, 0, 0);
    }
  }
}
