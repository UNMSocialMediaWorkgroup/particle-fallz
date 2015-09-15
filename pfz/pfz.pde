Engine engine = new Engine();
NiagraScreen screen = new NiagraScreen();

void setup() {
  size(1000, 480, P3D);
  surface.setSize(screen.getWidth(), screen.getHeight());
  frame.setSize(screen.getWidth(), screen.getHeight());
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
