class CAS {
  int generation;

  int[] ruleset={this.randomBool(), this.randomBool(), this.randomBool(), this.randomBool(), this.randomBool(), this.randomBool(), this.randomBool(), this.randomBool()};
  int w=dim;

  int randomBool() {
    return int(random(1) > .5);
  }
  //3D generate
   
   void generate() {
   int [][]nextgen = new int[AS][AS];
   
   for (int i=0; i<AS; i++) {
   for (int j=0; j<AS; j++) {
   int neighbours= neighboursCountVM(i,j,k);
   int state= CA[i][j][k];
   //if((neighbours>=1 && neighbours<=4) || (neighbours>=10))nextgen[i][j]=1;
  //if(neighbours%8==1)nextgen[i][j]=1;
  if((neighbours>=0 && neighbours<=6) && state==1)nextgen[i][j]=1;
  else if(neighbours==1 || neighbours==3  && state==0)nextgen[i][j]=1;
  else nextgen[i][j]=0;
   }
   }
   
   for(int i=0;i<AS;i++)
   for(int j=0;j <AS;j++){
   CA[i][j][k]=nextgen[i][j];
   
   }
   }
   int  neighboursCountMoore(int x,int y,int z){
   int sum=0;
   for(int i=-1;i<=1;i++)
   for(int j=-1;j<=1;j++)
   for(int k=-1;k<=1;k++)
   sum+=int(CA[(x+i+AS)%AS][(y+j+AS)%AS][(z+k+AS)%AS]);
   return sum-int(CA[x][y][z]);
   }
      int  neighboursCountVM(int x,int y,int z){
   int sum=0;
   sum+=CA[(x+1+AS)%AS][y][z];
   sum+=CA[(x-1+AS)%AS][y][z];
   sum+=CA[x][(y+1+AS)%AS][z];
   sum+=CA[x][(y-1+AS)%AS][z];
   sum+=CA[x][y][(z+1+AS)%AS];
   sum+=CA[x][y][(z-1+AS)%AS];
   return sum;
   }
  /*
  //for 2d generation,pretty boring
  void generate() {
    int [][]nextgen = new int[AS][AS];
    for (int i=0; i<AS; i++) {
      for (int j=0; j<AS; j++) {
        int left= CA[(i+AS-1)%AS][j][k-1];
        int me=  CA[i][j][k-1];
        int right= CA[(i+1+AS)%AS][j][k-1];
        nextgen[i][j] = rules(left, me, right);
      }
    }
    for (int i=0; i<AS; i++)
      for (int j=0; j <AS; j++) 
        CA[i][j][k]=nextgen[i][j];
  }
    int rules (int a, int b, int c) {
      if (a == 1 && b == 1 && c == 1) return ruleset[0];
      if (a == 1 && b == 1&& c == 0) return ruleset[1];
      if (a == 1 && b == 0 && c == 1) return ruleset[2];
      if (a == 1 && b == 0 && c == 0) return ruleset[3];
      if (a == 0 && b == 1 && c == 1) return ruleset[4];
      if (a == 0 && b == 1 && c == 0) return ruleset[5];
      if (a == 0 && b == 0 && c == 1) return ruleset[6];
      if (a == 0 && b == 0 && c == 0) return ruleset[7];
      return 0;
    }
    */
  }
