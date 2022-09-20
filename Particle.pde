class Particle {
  //// defines the individual particles and methods for behaviour
  float MAX_LIFESPAN = 255;
  color PARTICLE_COLOR = color(255,255,255);
 

  PVector location;
  PVector velocity;
  PVector acceleration;
 
  boolean dying;
  float lifespan;
  float mass; //may or may not be used...
 
 
  Particle(PVector _location){
    location = _location;
 
    acceleration = new PVector(0,0.1);//downward
    velocity = new PVector(random(-1,1),random(-1,2));
 
    dying = false;
    //lifespan = RESET_LIFESPAN;
    lifespan = 10.0;
  }
 
  void run(){
    update();
    display();
  }
 
  void update(){
    println(lifespan);
    if (dying){
      velocity.add(acceleration);
      location.add(velocity);
      lifespan -= 2.0;
    }
    else{
      if (lifespan < MAX_LIFESPAN){
        lifespan += 4.0;
      }
    }
  }
 
  void display(){
    noStroke();
    fill(PARTICLE_COLOR, lifespan);
    ellipse(location.x, location.y, 3, 3);
  }
 
  boolean isDead() {
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }
 
  void kill(boolean _dying){
    dying = _dying;    
  }
 
}  
