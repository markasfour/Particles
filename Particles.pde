ParticleSystem ps;

void setup() 
{
  size(640,480);
  noStroke();
  ps = new ParticleSystem(new PVector(width/2,height/2));
  for (int i = 0; i < 500; i++)
  {
    ps.addParticle();
  }
}

void draw() 
{
  background(0);
  ps.run();
}

class ParticleSystem 
{
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector location) 
  {
    origin = location.copy();
    particles = new ArrayList<Particle>();
  }

  void addParticle() 
  {
    particles.add(new Particle());
  }

  void run() 
  {
    for (int i = 0; i < particles.size(); i++) 
    {
      Particle p = particles.get(i);
      p.run();
    }
  }
}

class Particle 
{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float angle;
  float R;
  float G;
  float B;

  Particle() 
  {
    //location = new PVector(random(0, width), random(0, height));
    location = new PVector(random(width), random(height));
    velocity = new PVector(0,0);
    acceleration = new PVector(.05, .05);
    angle = 0;
    R = random(255);
    G = random(255);
    B = random(255);
  }

  void run() 
  {
    update();
    display();
  }

  float findAngle(float x, float y) 
  {
    float a = atan2(y - location.y, x - location.x);
    return a;
  }
  
  float findHypotenuse(float x, float y)
  {
    return dist(x, y, location.x, location.y);
  }

  // Method to update location
  void update() 
  {
    angle = findAngle(mouseX, mouseY);
    
    float r = findHypotenuse(mouseX, mouseY);
    
    velocity.x += acceleration.x * cos(angle);
    velocity.y += acceleration.y * sin(angle);
    location.add(velocity);
  }

  // Method to display
  void display() 
  {
    float r = R * (velocity.x/1.5) * (velocity.y/1.5);
    float g = G * (velocity.x/1.5) * (velocity.y/1.5);
    float b = B * (velocity.x/1.5) * (velocity.y/1.5);
    fill(R, G, B);
    tint(255, 127);
    ellipse(location.x, location.y, 8, 8);
    //ellipse(location.x,location.y,8 * (velocity.x/1.5) * (velocity.y/1.5),8 * (velocity.x/1.5) * (velocity.y/1.5));
  }
}