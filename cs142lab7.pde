
Attractor[] attractors = new Attractor[100];
float drawScale = 5;

void settings() {
  size(1920/2, 1080/2); 
}

void setup() {
  noStroke();
  float maxMag = min(width, height)/2;
  for(int i = 0; i < attractors.length; i++) {
    float angle = random(PI * 2);
    float x = width/2 + maxMag * cos(angle) * random(1);
    float y = height/2 + maxMag * sin(angle) * random(1);
    PVector p1 = new PVector(x, y);
    PVector p2 = p1.copy().rotate(random(-0.01, 0.01));
    p2.sub(p1);
    int mass = (int) random(1, 5);
    attractors[i] = new Attractor(x, y, mass, p2);
  }
}

void draw() {
  background(0);
  for(Attractor a : attractors) {
    a.calculateForce();
  }
  for(Attractor a : attractors) {
    a.updateAttractor();
    a.drawAttractor();
  }
}
