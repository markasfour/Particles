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
  //background(0);
  fill(0,100);
  rect(0, 0, width, height);
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
  float radius;
  float R;
  float G;
  float B;

  Particle() 
  {
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
    if (mousePressed)
    {
      acceleration = new PVector(-1, -1);
      velocity.limit(7);
    }
    else
    {
      acceleration = new PVector(.1, .1);
      velocity.limit(4);
    }
    
    angle = findAngle(mouseX, mouseY);
    
    radius = findHypotenuse(mouseX, mouseY);
    
    velocity.x += acceleration.x * cos(angle);
    velocity.y += acceleration.y * sin(angle);
    
    location.add(velocity);
  }

  // Method to display
  void display() 
  {
    fill(R, G, B);
    ellipse(location.x, location.y, 8, 8);
  }
}
