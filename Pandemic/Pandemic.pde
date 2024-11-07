PImage TheRedRock;
PImage TheGreenRock;
PImage TheBlueRock;
int numPeople = 20;
people[] p = new people[ numPeople ];

void setup() {
  size(1000, 700);
  int radius = 40;
  String S;
  //Humans have an immune system variable displayed in their center that shows how severe their condition is
  //If the number is <= 0 they are immune but will still weaken when hit
  //If the number is >= 0 then they can be infected
  //If the infected's immune system is over 15 then they die
  //Doctor's immune systems weaken after healing someone and will become infected if immune system is over 7
  
  TheRedRock = loadImage("TheRedRock.png");
  TheGreenRock = loadImage("TheGreenRock.png");
  TheBlueRock = loadImage("TheBlueRock.png");
 
  for(int i = 0; i < numPeople; i++) {
    //Change these numbers to raise or lower the chace of healthy, sick and healers
    float sickness = random(10);
    if (sickness < 4)
      S = "green";
    else if (sickness < 7)
      S = "red";
    else
      S = "blue";
    p[i] = new people(random(1000),random(700),random(-3,3),random(-3,3),radius,S);
  }
}

void draw() {
  background(0);
  
  for (int i=0; i<p.length;i++) {
    p[i].drawPeople();
    p[i].updatePos(i);
  }
}
