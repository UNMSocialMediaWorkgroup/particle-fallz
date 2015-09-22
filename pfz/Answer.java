public class Answer {
  private final int question;
  private final boolean correct;

  public Answer(int question, boolean correct) {
    this.question = question;
    this.correct = correct;
  }

  public int getQuestion() {
    return question;
  }

  public boolean isCorrect() {
    return correct;
  }
}
