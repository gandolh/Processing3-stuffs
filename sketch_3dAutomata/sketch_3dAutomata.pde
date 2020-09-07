import peasy.*;
PeasyCam cam;
int sSize=120;
int dim=2;
int AS= sSize/dim;
int [][][] CA; //cellular automaton
int k=0;
int ramification=1;
double angleX=0.007, angleY=0.008, angleZ=0.009;
CAS ca;
void setup() {
  size(1000, 1000, P3D);
  //colorMode(HSB);
  cam= new PeasyCam(this, 0);
  cam.setMinimumDistance(250);
  cam.setMaximumDistance(500);
  cam.setSuppressRollRotationMode();
  cam.lookAt(sSize/2, sSize/2, sSize/2);
  cam.rotateX(PI/2);


  ca= new CAS();
  reset();
}

void draw() {

  //cam.rotateX(angleX);
  cam.rotateY(angleY);
  //cam.rotateZ(angleZ);
  background(51);
  ambientLight(255, 255, 255);

  if (k<AS-1 ) {
    k++;
    ca.generate();
  }
  if(k==AS-1)k=0; //looping
  for (int i=0; i< AS; i++) {
    for (int j=0; j<AS; j++) {
      for (int k=0; k<AS; k++) {
        if (CA[i][j][k]==1) {
          showBox(i, j, k);
          //  println(i, j, k,CA[i][j][k]);
        }
      }
    }
  }

  //showSimulationBox();
}

void reset() {
  CA = new int[AS][AS][AS];
  /*
  for(int i=0;i<6;i++)
   for(int j=0;j<6;j++)
   for(int k=0;k<6;k++)
   CA[i][j][k]=1;
   */
  ReInitializeCA();
}
void ReInitializeCA() {
  //int offset=0;
  //for (int i=0; i<AS; i++)
  //  for (int j=0; j<AS; j++)
  //    for (int k=0; k<AS; k++)
  //      CA[(offset+i+AS)%AS][(offset+j+AS)%AS][(offset+k+AS)%AS]=1;
  CA[int(AS/2)][int(AS/2)][0]=1;
}
void keyPressed() {

  //2D random Generalizing
  // for(int i=0;i<8;i++)ca.ruleset[i]=ca.randomBool();

  for (int i=0; i<AS; i++)
    for (int j=0; j<AS; j++)
      for (int k=0; k<AS; k++)
        CA[i][j][k]=0;
 ReInitializeCA();
  //CA[int(AS/2)][int(AS/2)][0]=1;
  k=0;
  ramification++;
}

void showSimulationBox() {
  pushMatrix();
  translate(sSize/2, sSize/2, sSize/2);
  scale(sSize, sSize, sSize);
  stroke(0);
  strokeWeight( 0.9/sSize);
  noFill();
  box(1, 1, 1);
  popMatrix();
}
void showBox(int x, int y, int z) {
  pushMatrix();
  translate(x*dim+dim/2, y*dim+dim/2, z*dim+dim/2 );
  scale(dim, dim, dim);
  float lowBound=0;
  float highBound=255;
  float r= map(x*dim, 0, AS*dim, lowBound, highBound);
  float g=map(y*dim, 0, AS*dim, lowBound, highBound);
  float b=map(z*dim, 0, AS*dim, lowBound, highBound);
  fill(r, g, b);
  noStroke();
  //strokeWeight(1.0/dim/4);
  box(1, 1, 1);
  popMatrix();
}
