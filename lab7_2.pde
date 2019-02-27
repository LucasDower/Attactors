class Attractor {

  public PVector pos;
  public int mass;
  
  public Attractor(float x, float y, int mass) {
    this.pos = new PVector(x, y);
    this.mass = mass;
  }
  
  public PVector getForce(PVector particlePos, int m) {
    float G = 0.0125;
    //float distance = dist(pos.x, pos.y, particlePos.x, particlePos.y);
    PVector p = pos.copy();
    PVector distance = p.sub(particlePos);
    PVector direction = distance.normalize();
    //PVector force = direction.mult(G * mass * m / distance);
    PVector force = direction.mult(G * mass * m / distance.mag());
    return force;    
  }
  
  void drawAttractor() {
    fill(255, 0, 0);
    ellipse(pos.x, pos.y, mass * drawScale, mass * drawScale);
  }
  
}

class Particle {
 
  public PVector pos;
  public PVector vel;
  public int mass;
  public color colour;
  
  public Particle(float x, float y, int mass) {
    this.pos = new PVector(x, y);
    this.vel = new PVector(0, 0);
    this.mass = mass;
    this.colour = color(random(255), random(255), random(255));
  }
  
  void updateParticle() {
    PVector force = attractor1.getForce(pos, mass);
    force.add(attractor2.getForce(pos, mass));
    PVector acc = force.div(mass);
    vel.add(acc);
    pos.add(vel);
  }
  
  void drawParticle() {
    fill(colour);
    ellipse(pos.x, pos.y, mass * drawScale, mass * drawScale);
  }
  
}

Particle[] particles = new Particle[1000];
Attractor attractor1;
Attractor attractor2;
float drawScale = 2;

void settings() {
  size(1000, 1000); 
}

void setup() {
  noStroke();
  attractor1 = new Attractor(width/3, height/3, 10);
  attractor2 = new Attractor(2*width/3, 2*height/3, 5);
  
  for(int i = 0; i < particles.length; i++) {
    float x = random(width);
    float y = random(height);
    int mass = (int) random(1, 5);
    particles[i] = new Particle(x, y, mass);
  }
}

void draw() {
  background(0);
  for(Particle p : particles) {
    p.updateParticle();
    p.drawParticle();
    attractor1.drawAttractor();
    attractor2.drawAttractor();
  }
}
