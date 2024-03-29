import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
FFT fft;




class Boid {

 

    PVector position  = new PVector();
     PVector vel = new PVector();
    PVector acc = new PVector();
    float maxSteer = 0.5;
    float maxSpeed = 1;
    
    
     
  
  Boid(){
    position = new PVector(random(width), random(height));
    vel = PVector.random2D();
    
    
    
    
  }
  
  void coll(){
    
    if(this.position.x > width){
    
      this.position.x = 0;
    }
     if(this.position.x < 0){
    
      this.position.x = width;
    }
    
     if(this.position.y > height){
    
      this.position.y = 0;
    }
     if(this.position.y < 0){
    
      this.position.y = height;
    }
  
  }
  
  void show(){
  


    point(this.position.x, this.position.y);
    
  }
  
  void update(){
  
    this.position.add(vel);
    this.vel.add(acc);
    this.acc.x = 0;
    this.acc.y = 0;
    this.vel.limit(maxSpeed);
      
    
  }
  
  

  
  void setVel(PVector vel){
    this.vel = vel;
  }

   
   
   
 
  
  
  

  
}
  







Boid b[] = new Boid[513];


void setup(){
  size(600,600);
  colorMode(HSB, 255,255,255);
  minim = new Minim(this);
  
  
  //ADD YOUR MUSIC FILE HERE
  
  
  player = minim.loadFile("PATH/TO/YOUR/MUSIC/FILE");
  player.play();
  stroke(255,255,255);
  
  
  strokeWeight(10);
  background(0);
  noFill();
  fft = new FFT(player.bufferSize(), player.sampleRate());
   for(int i =0; i<b.length; i++){

    b[i] = new Boid();
  }

}

PVector acc = new PVector();





void draw(){
  clear();
  
  
  fft.forward(player.mix);
  
  float real[] = fft.getSpectrumReal();
  
  int i;
  
  for( i =0; i<fft.specSize(); i++){
    

    acc.x = (-real[i]/100);
    acc.y = abs(-real[i] /10) ;
    
    strokeWeight(abs(real[i])/3);
    stroke(255-real[i]*4,255,255);
    b[i].show();
    b[i].coll();
    b[i].update();
    b[i].setVel(acc);
    

    
  }
}
