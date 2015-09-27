import java.util.ArrayList;
import java.util.List;
import processing.serial.*;
import java.awt.Rectangle;

public final class Teensy {
  private static final int MAX_PORTS = 1;
  private static final float FRAME_RATE = 0;
  private static final String PORT_NAME = "/dev/serial/by-id/usb-Teensyduino_USB_Serial_350950-if00";
  private static final int PINS = 8;

  private Serial[] ledSerial = new Serial[MAX_PORTS];
  private Rectangle[] ledArea = new Rectangle[MAX_PORTS];
  private boolean[] ledLayout = new boolean[MAX_PORTS];
  private PImage[] ledImage = new PImage[MAX_PORTS];

  private int numPorts = 0;

  public void configure(pfz parent, int width, int height) {
    if (numPorts >= MAX_PORTS) {
      println("too many serial ports, please increase MAX_PORTS");
      return;
    }
    try {
      ledSerial[numPorts] = new Serial(parent, PORT_NAME);
      if (ledSerial[numPorts] == null) throw new NullPointerException("Null after Serial call");
      ledSerial[numPorts].write('?');
    } catch (Exception e) {
      e.printStackTrace();
      println(e.getMessage());
      println("Serial port " + PORT_NAME + " does not exist or is non-functional");
      return;
    }
    delay(50);
    String line = ledSerial[numPorts].readStringUntil(10);
    if (line == null) {
      println("Serial port " + PORT_NAME + " is not responding.");
      println("Is it really a Teensy 3.0 running VideoDisplay?");
      return;
    }
    String param[] = line.split(",");
    if (param.length != 12) {
      println("Error: port " + PORT_NAME + " did not respond to LED config query");
      return;
    }
    // only store the info and increase numPorts if Teensy responds properly
    ledImage[numPorts] = new PImage(Integer.parseInt(param[0]), Integer.parseInt(param[1]), RGB);
    ledArea[numPorts] = new Rectangle(Integer.parseInt(param[5]), Integer.parseInt(param[6]),
                                      Integer.parseInt(param[7]), Integer.parseInt(param[8]));
    //ledArea[numPorts] = new Rectangle(0, 0,
    //                                  Integer.parseInt(param[0]), Integer.parseInt(param[1]));
    ledLayout[numPorts] = (Integer.parseInt(param[5]) == 0);
    numPorts++;
  }

  public void writeToLEDs(PImage m) {
    for (int i=0; i < numPorts; i++) {
      // copy a portion of the image to the LED image
      int xoffset = percentage(m.width, ledArea[i].x);
      int yoffset = percentage(m.height, ledArea[i].y);
      int xwidth =  percentage(m.width, ledArea[i].width);
      int yheight = percentage(m.height, ledArea[i].height);

      //    println(xoffset + "\t" + yoffset + "\t" + xwidth + "\t" + yheight );

      ledImage[i].copy(m, xoffset, yoffset, xwidth, yheight,
                       0, 0, ledImage[i].width, ledImage[i].height);

      //ledImage[i].save( savePath("./testout/test-" + millis() + hour() + minute() + ".jpg") );

      // convert the LED image to raw data
      byte[] ledData =  new byte[(ledImage[i].width * ledImage[i].height * 3) + 3];
      for (int j = 0; j < ledData.length; j++) {
        ledData[j] = byte(0xff);
      }
      imageToData(ledImage[i], ledData, ledLayout[i]);
      if (i == 0) {
        ledData[0] = '*';  // first Teensy is the frame sync master
        int usec = (int)((1000000.0 / FRAME_RATE ) * 0.75);
        ledData[1] = (byte)(usec);   // request the frame sync pulse
        ledData[2] = (byte)(usec >> 8); // at 75% of the frame time
      } else {
        ledData[0] = '%';  // others sync to the master board
        ledData[1] = 0;
        ledData[2] = 0;
      }
      // send the raw data to the LEDs  :-)
      ledSerial[i].write(ledData);
      //    println(ledData);
    }
  }

  private byte[] imageToData(PImage image, byte[] data, boolean layout) {
    int offset = 3;
    int x, y, xbegin, xend, xinc, mask;

    int linesPerPin = image.height / 8; // XXX this seems to break when using 6 instead of 8
    int pixel[] = new int[PINS];

    for (y = 0; y < linesPerPin; y++) {
      if ((y & 1) == (layout ? 0 : 1)) {
        // even numbered rows are left to right
        xbegin = 0;
        xend = image.width;
        xinc = 1;
      } else {
        // odd numbered rows are right to left
        xbegin = image.width - 1;
        xend = -1;
        xinc = -1;
      }
      for (x = xbegin; x != xend; x += xinc) {
        for (int i=0; i < PINS; i++) {
          // fetch 8 pixels from the image, 1 for each pin
          pixel[i] = image.pixels[x + (y + linesPerPin * i) * image.width];
          pixel[i] = colorWiring(pixel[i]);
        }
        // convert 8 pixels to 24 bytes -- XXX
        for (mask = 0x800000; mask != 0; mask >>= 1) {
          byte b = 0;
          for (int i=0; i < PINS; i++) {
            if ((pixel[i] & mask) != 0) b |= (1 << i);
          }
          data[offset++] = b;
        }
      }
    }
    return data;
  }

  private int colorWiring(int c) {
    //   return c;  // RGB
    return ((c & 0xFF0000) >> 8) | ((c & 0x00FF00) << 8) | (c & 0x0000FF); // GRB - most common wiring
  }

  private int percentage(int num, int percent) {
    double mult = percentageFloat(percent);
    double output = num * mult;
    return (int)output;
  }

  // scale a number by the inverse of a percentage, from 0 to 100
  private int percentageInverse(int num, int percent) {
    double div = percentageFloat(percent);
    double output = num / div;
    return (int)output;
  }

  private double percentageFloat(int percent) {
    if (percent == 33) return 1.0 / 3.0;
    if (percent == 17) return 1.0 / 6.0;
    if (percent == 14) return 1.0 / 7.0;
    if (percent == 13) return 1.0 / 8.0;
    if (percent == 11) return 1.0 / 9.0;
    if (percent ==  9) return 1.0 / 11.0;
    if (percent ==  8) return 1.0 / 12.0;
    return (double)percent / 100.0;
  }
}
