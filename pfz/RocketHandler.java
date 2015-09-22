import java.util.ArrayList;
import java.util.List;

public class RocketHandler {
  private pfz.Rocket[][] rockets;
  private int counts[];

  public RocketHandler(int columns, int rows) {
    rockets = new pfz.Rocket[columns][];
    counts = new int[columns];
    for (int i = 0; i < columns; i++) {
      rockets[i] = new pfz.Rocket[rows];
      counts[i] = 0;
    }
  }

  public void update() {
    for (int i = 0; i < rockets.length; i++) {
      for (int j = 0; j < counts[i]; j++) {
        rockets[i][j].update();
        if (!rockets[i][j].isAlive()) {
          for (int k = j; k < counts[i] - 1; k++) {
            rockets[i][k] = rockets[i][k + 1];
            rockets[i][k].setMinX(k * pfz.Rocket.OFF_HEIGHT);
            counts[i]--;
          }
        }
      }
    }
  }

  public void render() {
    for (int i = 0; i < rockets.length; i++) {
      for (int j = 0; j < counts[i]; j++) {
        rockets[i][j].render();
      }
    }
  }

  public void add(pfz.Rocket r, int column, boolean correct) {
    if (counts[column] >= rockets[column].length) {
      for (int i = 0; i < rockets[column].length - 1; i++) {
        rockets[column][i] = rockets[column][i + 1];
        rockets[column][i].setMinX(i * pfz.Rocket.OFF_HEIGHT);
      }
      counts[column]--;
    }
    r.setMinX(counts[column] * pfz.Rocket.OFF_HEIGHT);
    rockets[column][counts[column]++] = r;
  }
}
