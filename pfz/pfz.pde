Engine engine = new Engine();
TestScreen screen = new TestScreen();


void setup() {
  size(640, 480);
  engine.setScreen(screen);
  engine.setUDPListener(new SimpleUDPListener());
  engine.setUDPParser(new PerByteUDPParser());
  engine.setUDPHandler(screen);
  engine.startUDP();
}

void draw() {
  engine.update();
  engine.render();
}
