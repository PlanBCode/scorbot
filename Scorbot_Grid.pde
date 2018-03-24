PImage bg;
import processing.serial.*;
Serial port;
boolean ready = false;
ArrayList<String> queue = new ArrayList();
PVector coordinate = new PVector();

void setup() {
  size(800, 800);
  textSize(14);
  imageMode(CENTER);
  bg = loadImage("bg.png");
  port = new Serial(this, "/dev/cu.usbserial", 9600);
  if (port!=null) port.write("\r");
  
  cmd("DEFP 1");
  cmd("SPEED 50");
}

void draw() {
  update();
  
  background(255);
  pushMatrix();
  translate(width/2-10, height/2+12);
  rotate(radians(-236));
  image(bg, 0, 0);
  popMatrix();

  float xx = map(mouseX, 0, width, -1, 1);
  float yy = map(mouseY, 0, height, 1, -1);
  coordinate = new PVector(xx, yy);
  coordinate.rotate(radians(-236));
  coordinate.mult(3947); //= straal = dist(0,0,1,0)
  coordinate.limit(3947);

  stroke(255, 0, 0);
  line(mouseX, 0, mouseX, height);
  line(0, mouseY, width, mouseY);

  noStroke();
  fill(0);
  textAlign(LEFT);
  text(nf(xx, 0, 2)+","+nf(yy, 0, 2), 5, 30);
  text(round(coordinate.x)+", "+round(coordinate.y), 5, 50);

  textAlign(CENTER);
  text("(3297, 2116)\n(0,-1)", width/2, height-40);
  textAlign(LEFT);
  text("(2549, -3015)\n(-1,0)", 3, height/2);
  textAlign(RIGHT);
  text("(-2119,3331)\n(1,0)", width, height/2);
  
  fill(255,0,0,40);
  noStroke();
  ellipse(width/2,height/2,250,250);
}

void keyPressed() {
  switch (key) {
    case 'h':
      cmd("HOME");
      break;
    case 'p':
      cmd("setpvc 1 z 67");
      cmd("move 1");
      break;
    case 'P':
      cmd("setpvc 1 z 561");
      cmd("move 1");
      break;
    case 'g':
      cmd("jaw 30");
      break;
    case 'G':
      cmd("jaw 40");
      break;
    case 'u':
      cmd("setpvc 1 z 4000");
      cmd("move 1");
      break;
    case 'k':
      cmd("setpvc 1 z 500");
      cmd("move 1");
      break;
  }
}

void mousePressed() {
  cmd("setpvc 1 x "+round(coordinate.x));
  cmd("setpvc 1 y "+round(coordinate.y));
  cmd("move 1");
}