import processing.sound.*;

SoundFile sample;
FFT fft;
Amplitude amp;
AudioIn in;

int cols,rows;
int scl = 20;
int bands = 128;
int w = bands*scl;  
int h = 9000;
int scale = 5;

float flying = 0;
float[][] terrain; 
float smoothingFactor = 0.05;
float[][] sum;
float barWidth;
float[] spectrum = new float[bands];





public void setup() {
  size(1200,600,P3D);
  cols = w/scl;
  rows = h/scl;
  terrain = new float[cols][rows];
  sum = new float[cols][rows];
  barWidth = width/float(bands);
  fft= new FFT(this, bands);
  amp = new Amplitude(this);
  
  ////////////AUDIO INPUT 

  //++using an audio file++
  //sample = new SoundFile (this, "bdsm.wav");                        //use looseless files like .wav (decoding .mp3 makes the program go slowly)
  sample = new SoundFile (this, "05 - metallo.wav");  
  sample.loop();                                                      //TODO configure for audio input in RaspberryPi
  fft.input(sample);
  amp.input(sample);
  
  
  //++microphone++
  //in = new AudioIn(this, 0);
  //fft.input(in);
  //amp.input(in);
  
  frameRate(60);                                                      // 60 fps;    
}
  

public void draw() {
  //flying -= 0.1;
  //float yoff = flying;
  for (int y = 0; y < rows; y++) {
    //float xoff = 0;
    fft.analyze();
    for (int x = 0; x < cols;  x++) {
      sum[x][y] = (fft.spectrum[x] - sum[x][y]) * smoothingFactor;
      //terrain[x][y] = map(noise(xoff,yoff), 0, 1, -100,100);       //perlin noise  IDEA: perlin noise 'modulated' by the audio signal? the perlin noise flying mesh looks cool
      //xoff += 0.1;
    }
    
    //yoff += 0.1;
  }
  translate(0,height/4,-400);
  
  background(0);
  stroke(40,254,20);
  noFill();
  
  
  translate((width/2)*amp.analyze(),(height/2)*amp.analyze());                                
  rotateX(amp.analyze()*PI/4);   //rotates the plane
  rotateX(PI/5+PI*(1.05-amp.analyze())/4);                                                 //TODO mirror fft in the same loop so that the low frequencies stay in the middle. x symmetry  
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols;  x++) {
      vertex(x*scl,y*scl,sum[x][y]*10000);
      vertex(x*scl,(y+1)*scl,sum[x][y+1]*10000);
    }
    endShape();
    //translate(0,-400);                  //looks cool
  }
  
}
  
