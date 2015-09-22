import java.util.List;
import java.util.ArrayDeque;
import java.util.Queue;
import java.util.ArrayList;
import java.util.Random;

public class StarlightScreen extends QAUDPHandler
  implements PFZScreen {
  private static final int WIDTH = 237;
  private static final int HEIGHT = 8;

  private static final int BACKGROUND_COLOR = 0xff000000;

  private static final int GROUND_COLOR = 0xff303030;
  private static final int GROUND_HEIGHT = 5;

  private static final int STAR_COUNT = 50;
  private static final int SHOOTING_STAR_SPAWN_CHANCE = 50;

  private Random rand = new Random();

  private StarlightState state = StarlightState.IDLE;
  private int stateFrames = 0;
  private Ray ray;

  private Queue<Answer> answers =
    new ArrayDeque<Answer>();
  private Queue<Integer> correctQuestions =
    new ArrayDeque<Integer>();
  private Queue<Integer> incorrectQuestions =
    new ArrayDeque<Integer>();

  private List<Particle> stars =
    new ArrayList<Particle>();

  private List<RenderableParticle> shootingStars =
    new ArrayList<RenderableParticle>();

  private RocketHandler rockets =
    new RocketHandler(HEIGHT, WIDTH / Rocket.HEIGHT);

  public StarlightScreen() {
    initStars();
  }

  @Override
  public int getWidth() {
    return WIDTH;
  }

  @Override
  public int getHeight() {
    return HEIGHT;
  }

  @Override
  public void update() {
    /* Stuff that always needs updating */
    updateStars();
    if ((rand.nextInt() % SHOOTING_STAR_SPAWN_CHANCE) == 1) {
      spawnShootingStar();
    }
    updateShootingStars();
    rockets.update();

    /* Conditional updating */
    switch (state) {
    case IDLE:
      updateIdle();
      break;
    case HANDLE_CORRECT:
    case HANDLE_INCORRECT:
      updateHandleQuestion();
      break;
    }

    /* Change state */
    if (state != StarlightState.IDLE) {
      stateFrames++;
      if(stateFrames > state.length) {
        stateFrames = 0;
        handleEndState(state);
        state = state.nextState;
      }
    }
  }

  @Override
  public void render() {
    renderBackground();
    renderGround();
    renderStars();
    renderShootingStars();
    renderRockets();

    if (state != StarlightState.IDLE) {
      renderRay();
    }
  }

  @Override
  public void handleCorrect(int question) {
    answers.add(new Answer(question, true));
  }

  @Override
  public void handleIncorrect(int question) {
    answers.add(new Answer(question, false));
  }

  private void initStars() {
    for (int i = 0; i < STAR_COUNT; i++) {
      stars.add(new StarParticle(rand, GROUND_HEIGHT, 0,
                                 WIDTH, HEIGHT));
    }
  }

  private void spawnShootingStar() {
    shootingStars.add(
           new ShootingStarParticle(rand, WIDTH, HEIGHT));
  }


  private void updateStars() {
    for (int i = 0; i < stars.size(); i++) {
      stars.get(i).update();
    }
  }

  private void updateShootingStars() {
    for (int i = 0; i < shootingStars.size(); i++) {
      shootingStars.get(i).update();
      if (!shootingStars.get(i).isAlive()) {
        shootingStars.remove(i--);
      }
    }
  }

  private void updateIdle() {
    if (answers.size() > 0) {
      Answer a = answers.remove();
      this.state = a.isCorrect() ?
        StarlightState.HANDLE_CORRECT :
        StarlightState.HANDLE_INCORRECT;
      this.ray =
        new Ray(a.getQuestion(), GROUND_HEIGHT,
                WIDTH, a.isCorrect());
    }
  }

  private void updateHandleQuestion() {
    ray.update();
  }

  private void handleEndState(StarlightState state) {
    Rocket r = new Rocket();
    r.init(ray.getQuestionNum(), WIDTH, GROUND_HEIGHT / 2,
           state == StarlightState.HANDLE_CORRECT);
    rockets.add(r, ray.getQuestionNum(),
                state == StarlightState.HANDLE_CORRECT);
  }

  private void renderBackground() {
    fill(BACKGROUND_COLOR);
    stroke(BACKGROUND_COLOR);
    rect(0, 0, WIDTH, HEIGHT);
  }

  private void renderGround() {
    fill(GROUND_COLOR);
    stroke(GROUND_COLOR);
    rect(0, 0, GROUND_HEIGHT, HEIGHT);
  }

  private void renderStars() {
    for (int i = 0; i < STAR_COUNT; i++) {
      fill(stars.get(i).getColor());
      stroke(stars.get(i).getColor());
      rect(stars.get(i).getPosition().getX(),
           stars.get(i).getPosition().getY(),
           stars.get(i).getSize(),
           stars.get(i).getSize());
    }
  }

  private void renderShootingStars() {
    for (int i = 0; i < shootingStars.size(); i++) {
      shootingStars.get(i).render();
    }
  }

  private void renderRockets() {
    rockets.render();
  }

  private void renderRay() {
    ray.render();
  }
}
