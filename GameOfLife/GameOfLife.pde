int [][] grid;
color[][] colorsGrid;
float xoff=0,yoff=0;
int scl=6;
int rows,cols;
int[] dl={-1,-1,0,1,1,1,0,-1};
int[] dc={0,1,1,1,0,-1,-1,-1};
void setup(){
size(900,900);
background(51);
//fill(255);
rows=height/scl;
cols=width/scl;
grid= new int[rows+1][cols+1];
colorsGrid= new int[rows+1][cols+1];
colorMode(HSB,360,100,100);
resetGrid();
}

void drawGrid(){
  for(int i=1;i<rows;i++){
  for(int j=1;j<cols;j++){
   //int count= numberOfNeighbours(i,j);
   //fill(map(count,0,8,0,360),40,100);
    //fill(map(i+j,0,rows+cols,0,360),40,100);
    fill(colorsGrid[i][j]);
    if(grid[i][j]==1)rect(j*scl,i*scl,scl,scl);
  }
  }
}
int numberOfNeighbours(int x,int y){
  int nr=0;
  for(int i=0;i<8;i++){
  int nextX=x+dc[i];
  int nextY=y+dl[i];
  if(grid[nextX][nextY]==1)nr++;
  }
  return nr;
}
void playRule(){
  int [][]next= new int[rows+1][cols+1];
  for(int i=1;i<rows;i++){
    for(int j=1;j<cols;j++){
      int count= numberOfNeighbours(i,j);
      if(grid[i][j]==1){
        if(count==2 || count==3)next[i][j]=1;
        else next[i][j]=0;
      }else if(count==3)next[i][j]=1;  
    }
  }
  grid=next;
}
void resetGrid(){  
  xoff=0;yoff=0;
  for(int i=1;i<rows;i++){
  for(int j=1;j<cols;j++){
  grid[i][j]=0; 
//colorsGrid[i][j]=color(random(0,120),60,60);

colorsGrid[i][j]=color(map(noise(xoff,yoff),0,1,240,360),60,60);
xoff+=0.03;
}
yoff+=0.03;
  }
  //grid[rows/2][cols/2]=1;
  
  //cross desenat;
  //for(int k=-3;k<=3;k++){
  //for(int i=1;i<=rows;i++)grid[i][cols/2+k]=1;
  // for(int i=1;i<=cols;i++)grid[rows/2+k][i]=1;
  //}
  
  // idk whats this
  //int foo=rows/4;
  //for(int i=rows/2-foo;i<=rows/2+foo;i++)
  //  for(int j=cols/2-foo;j<cols/2+foo;j++){
  //    grid[i][j]=1; 
  //  }
for(int i=1;i<=rows;i++)
for(int j=-cols;j<cols;j+=3)
if(i+j<cols && i+j>0)grid[i][i+j]=1;
}
void draw(){
  background(51);
  //fill(255);
  playRule();
  drawGrid();
}
void keyTyped(){
  if(keyCode==0)resetGrid();
}
