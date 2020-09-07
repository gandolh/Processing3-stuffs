//credits to Daniel Shiffman who taught me those crazy ideas
void setup() {
  size(800, 800);
  colorMode(HSB, 1);
}
float angle=0;
void draw() {
  frameRate(30);
  background(255);
  float ca = cos(angle*3); //0 crazy stuff
  float cb= sin(angle*2); //0 crazy stuff
  angle+=0.01; 
  float w = (abs(sin(2*angle))+1)*3; //aici zooming;
  float h = (w * height) / width;
  float xmin = -w/2;
  float ymin = -h/2;
  loadPixels();
  int maxiterations = 100;
  float xmax = xmin + w;
  float ymax = ymin + h;
  float dx = (xmax - xmin) / (width);
  float dy = (ymax - ymin) / (height);
  float y = ymin;
  for (int j = 0; j < height; j++) {
    // Start x
    float x = xmin;
    for (int i = 0; i < width; i++) {
      float a = x;
      float b = y;
      int n = 0;
      while (n < maxiterations) {
        float aa = a * a;
        float bb = b * b;
        float twoab = 2.0 * a * b;
        a = aa - bb +ca;
        b = twoab +cb;
        if (a*a + b*b > 4.0) {
          break;
        }
        n++;
      }
      if (n == maxiterations) {
        pixels[i+j*width] = color(0);
      } else {
        float hue=sqrt(float(n) / maxiterations);
        pixels[i+j*width] = color(hue, 255, 155   );
      }
      x += dx;
    }
    y += dy;
  }
  updatePixels();
  //println(frameRate);
}
