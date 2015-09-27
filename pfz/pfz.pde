Engine engine = new Engine();
StarlightScreen screen = new StarlightScreen();

void setup() {
  size(237, 8);
  surface.setSize(screen.getWidth(), screen.getHeight());
  // frame.setSize(screen.getWidth(), screen.getHeight());
  engine.setPFZScreen(screen);
  engine.setUDPListener(new SimpleUDPListener());
  engine.setUDPParser(new SkylightUDPParser());
  engine.setUDPHandler(screen);

  engine.startUDP();
}

void draw() {
  engine.update();
  engine.render();
}
