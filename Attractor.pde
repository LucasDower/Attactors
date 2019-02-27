class Attractor {

  public PVector pos;
  public PVector vel;
  public PVector forceToApply;
  public int mass;
  public color colour;
  
  public Attractor(float x, float y, int mass, PVector vel) {
    this.pos = new PVector(x, y);
    this.mass = mass;
    this.colour = color(random(255), random(255), random(255));
    this.vel = vel;    
  }
  
  public PVector getForce(PVector pos_, int m) {
    float G = 0.00125;
    PVector p = pos_.copy();
    PVector distance = p.sub(pos);
    if (distance.mag() == 0) {
      return new PVector();
    }
    PVector direction = distance.normalize();
    PVector force = direction.mult(G * mass * m / distance.mag());
    return force;
  }
  
  void calculateForce() {
    PVector force = new PVector();
    for (Attractor a : attractors) {
      force.add(getForce(a.pos, a.mass));
    }
    forceToApply = force;
  }
  
  void updateAttractor() {
    PVector acc = forceToApply.div(mass);
    vel.add(acc);
    pos.add(vel);
    if (pos.x < 0 || pos.x > width) {
      vel.x *= -1;
    }
    if (pos.y < 0 || pos.y > height) {
      vel.y *= -1;
    }
  }
  
  void drawAttractor() {
    fill(colour);
    ellipse(pos.x, pos.y, mass * drawScale, mass * drawScale);
  }
  
}
