Engine engine = new Engine();
TestScreen screen = new TestScreen();


void setup() {
  surface.setSize(screen.getWidth(), screen.getHeight());
  engine.setPFZScreen(screen);
  engine.setUDPListener(new SimpleUDPListener());
  engine.setUDPParser(new PerByteUDPParser());
  engine.setUDPHandler(screen);
  engine.startUDP();
}

void draw() {
  engine.update();
  engine.render();
}
