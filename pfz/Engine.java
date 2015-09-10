public final class Engine {
  private PFZScreen screen;
  private UDPListener listener;
  private UDPParser parser;
  private UDPHandler handler;

  public void setUDPHandler(UDPHandler handler) {
    this.handler = handler;
  }

  public void setUDPParser(UDPParser parser) {
    this.parser = parser;
  }

  public void setPFZScreen(PFZScreen screen) {
    this.screen = screen;
  }

  public void setUDPListener(UDPListener listener) {
    this.listener = listener;
  }

  public void startUDP() {
    if (!this.isUDPReady()) {
      Log.warning("Cannot start UDP, components are still null.");
    } else {
      this.listener.start();
    }
  }

  private boolean isUDPReady() {
    return this.listener != null &&
           this.handler != null &&
           this.parser != null;
  }

  public void update() {
    if (isUDPReady()) {
      byte[] byteMessage = listener.getMessage();
      if (byteMessage != null) {
        handler.handleUDPValue(parser.convertMessage(byteMessage));
      }
    }

    if (screen != null) {
      screen.update();
    }
  }

  public void render() {
    if (screen != null) {
      screen.render();
    }
  }
}
