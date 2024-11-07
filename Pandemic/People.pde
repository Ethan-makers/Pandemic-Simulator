class people {
  PVector pos, v;
  int r;
  String Status; 
  float ImmuneSystem;
  
  people(float x, float y, float vx, float vy, int radius, String S) {
    this.r = radius;
    this.pos = new PVector (x,y);
    this.v = new PVector (vx,vy);
    this.ImmuneSystem = random(-2,3);
    this.Status = S;
  }
  
  void drawPeople() {
    if (this.ImmuneSystem < 15) {
      if (this.Status == "blue") {
        //fill(0,0,255);
        image(TheBlueRock, this.pos.x-r, this.pos.y-r, r*2, r*1.7);
      }
      else if (this.Status == "green") {
        //fill(0,255,0);
        image(TheGreenRock, this.pos.x-r, this.pos.y-r, r*2, r*1.7);
      }
      else {
        //fill(255,0,0);
        image(TheRedRock, this.pos.x-r, this.pos.y-r, r*2, r*1.7);
      }
      //circle(this.pos.x, this.pos.y, this.r*2);
      
      textSize(this.r/2);
      fill(255);
      text(int(this.ImmuneSystem), this.pos.x-5, this.pos.y+5);
    }
  }
  
  void updatePos(int i) {
    if (this.ImmuneSystem < 15) {
      
      this.pos.add(this.v);
      
      if (this.Status == "red")
        this.ImmuneSystem += 0.01;
        
      for (int j=i+1; j<p.length; j++) {
        checkCollision(j);
      }
      
      if (this.pos.x < 0 || this.pos.x > width && (this.pos.y < 0 || this.pos.y > height)) { //Corners check
        this.v.x *= (-1);
        this.v.y *= (-1);
      }
      else if (this.pos.x < 0 || this.pos.x > width)
        this.v.x *= (-1);
      else if (this.pos.y < 0 || this.pos.y > height)
        this.v.y *= (-1);
    }
  }
  
  void checkCollision(int j) {
    if (p[j].ImmuneSystem < 15 && this.ImmuneSystem < 15) {
      PVector S = new PVector(p[j].pos.x-this.pos.x, p[j].pos.y-this.pos.y);
      
      
      if( S.mag() <= this.r*2) {
        PVector SHat = PVector.div(S,S.mag());
        Float k = (this.v.dot(SHat))-(p[j].v.dot(SHat));
        PVector DeltaV = PVector.mult(SHat,-k);
        PVector DeltaW = PVector.mult(SHat,k);
        
        //Velocity update
        this.v = this.v.add(DeltaV);
        p[j].v = p[j].v.add(DeltaW);
        
        //Clump Fix
        PVector Stimes2r = PVector.mult(SHat, 2*this.r); 
        p[j].pos = PVector.add( this.pos, Stimes2r );
        
        //Update Status
        if (this.Status == "blue" && p[j].Status == "red" && this.ImmuneSystem >= 7) {
          this.Status = "red";
        }
        else if (this.Status == "red" && p[j].Status == "blue" && this.ImmuneSystem >= 7) {
          p[j].Status = "red";
        }
        else if (this.Status == "blue" && p[j].Status == "red") {
          p[j].Status = "green";
          p[j].ImmuneSystem -= 3;
          this.ImmuneSystem += 1; 
        }
        else if (this.Status == "red" && p[j].Status == "blue") {
          this.Status = "green";
          this.ImmuneSystem -= 3;
          p[j].ImmuneSystem += 1; 
        }
        else if (this.Status=="green" && p[j].Status=="red" && this.ImmuneSystem >= 0) {
          this.Status = "red";
        }
        else if (this.Status=="red" && p[j].Status == "green" && p[j].ImmuneSystem >= 0) {
          p[j].Status = "red";
        }
        else if (this.Status=="green" && p[j].Status=="red") {
          this.ImmuneSystem += 1;
        }
        else if (this.Status=="red" && p[j].Status == "green") {
          p[j].ImmuneSystem += 1;
        }
      }
    }
  }
}
