float increment = 0.01;
float zoff=0.0;
float zincrement=0.02;
OpenSimplexNoise noise;
void setup(){
size(540,540);
noise = new OpenSimplexNoise();
colorMode(HSB);

}
void draw(){
  loadPixels();
  float xoff=0;
  for(int x=0;x<width;x++){
  xoff+=increment;
  float yoff=0;
  for(int y=0;y<height;y++){
  yoff+=increment;
  //float bright=noise(xoff,yoff,zoff)*255;
  float n=(float)noise.eval(xoff,yoff,zoff);
  float bright= map(n,-1,1,0,360);
  pixels[x+y*width]=color(bright,255,255);
  }
  }
  updatePixels();
  zoff+=zincrement;
}
