class ParticleEmitter {
  //read in data from the kinect and extract the performers body shape
  PImage img;
 
  //constants
  int PARTICLE_DISTANCE = 5; // distance between particles in the emitter.
 
  //particles
  ArrayList<Particle> particles = new ArrayList<Particle>() ;
  ArrayList<PVector> emitter = new ArrayList<PVector>() ;
 
  //kinect
  Kinect2 kinect;
 

  ParticleEmitter(Kinect2 _kinect){
    kinect = _kinect;
    //create a blank image to put all the depth info onto.
     img = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);
  }
 

  void refresh(){
    //clears the arraylist of locations where particles can spawn from
    //creates new array list of locations where particles can spawn from
    emitter.clear();
    img.loadPixels(); //need to operate on the pixels of the image. 

 
    //get depth data from the kinect
    int [] depth = kinect2.getRawDepth();  //this is an array of ints relating to pixels in the depth image.
                                         // 0 - 4500 --> 0 relating to distance in mm;
    //first - establish the locations where particles can grow
    for (int x = 0; x < kinect2.depthWidth; x=x+3){
      for(int y = 0; y < kinect2.depthHeight; y=y+3){
        int offset  = x + (y * kinect2.depthWidth);
        int d = depth[offset];
        if (d > RANGE_MIN && d < RANGE_MAX){
          PVector location = new PVector(x, y);
          emitter.add(location);  
          //checks for location existence
          if (!has(location)){
            float temp = random(0,90000);
            if (temp > 89990){
              Particle newParticle = new Particle(location);
              particles.add(newParticle);
            }
          }
        } 
      } 
    } 
  }
 

  void emit(){
    //particle update
    Iterator <Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      //loop through emitter area - is it in or out?
      boolean kill = true;
      for (PVector emitLocation: emitter){
        //if theres a match make it false
        if (p.location.dist(emitLocation) < PARTICLE_DISTANCE){
          kill = false;
        }
      }
      p.kill(kill);
      p.run();
      if (p.isDead()) {
        it.remove();
      }
 
    }
  }

  boolean has(PVector location){
    //checks to see if a particle exists within this location
    boolean has = false;
    for (Particle particle : particles){
        if(location.dist(particle.location) < PARTICLE_DISTANCE){
          has = true;
        }
    }
    return has;
  }
}  
