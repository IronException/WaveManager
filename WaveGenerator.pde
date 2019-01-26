
// setting
boolean dontRenderInf = false;



float pSize, panelSize, xSubSize;

public void init() {
  pSize = height / 5.0;
  xSubSize = width - 2.0 * (panelSize - 2.0 * txtH) - 3.0 * txtH; // TODO transform...
  
  if(xSubSize < 0){
    xSubSize = 0;
  }
}

float scrollPosY;


float txtH;


void setup() {
  size(960, 540);
  //frameRate(1);
  loadImgs();

  try{
    surface.setIcon(loadImage("icon.png"));
  } catch (Exception e){}

  init();



  panels = new ArrayList<WavePanel>(); // 5m, 
  panels.add(new WavePoints(panels.size(), 5, 0.5, 1, 2, 0, 0, 100));
  //panels.add(new WavePoints(panels.size()));
  
  
  
  
  
  //nevWave = new NevWave(1);
}




ArrayList<WavePanel> panels;

NevWave nevWave;


int cooldown;

void draw() {
  background(255);
  
  
  
  if(nevWave != null){
    nevWave.render();
    nevWave.tick();
    
    return;
  }
  
  panelSize = (float) height / (panels.size() + 1.0);
  if(panelSize < pSize){
    panelSize = pSize;
  }
  xSubSize = width - 2.0 * (panelSize - 2.0 * txtH) - 3.0 * txtH; // TODO transform...
  // TODO what to do with this ^, it somehow messes up all renders when it changes for no reason
  
  for (int i = 0; i < panels.size(); i ++) {
    panels.get(i).doRender();
    panels.get(i).tick();
    
  }
  
  renderAddAndTick(panels.size() * panelSize);
  
  
  // remove from here
  fill(0);
  text(panels.size(), 0, height);
  
}

public void renderAddAndTick(float yPos){
  
  fill(255, 0, 0);
  rect(0, yPos, width, panelSize);
  if(cooldown > 0){
    cooldown --;
    return;
  } else if(mousePressed && mouseY > yPos){
    // a new wave
    cooldown = (int) frameRate / 2;
    nevWave = new NevWave(panels.size(), true);
    panels.add(new WavePoints(panels.size(), 0, 0, 0, 0, 0, 0, 0));
    
  }
  
}


//--------------------------------------------------------


PImage[] imgs;
PImage tick0, tick1;


public void loadImgs(){
  textSize(height / 32);
  txtH = textAscent() + textDescent();
  
  imgs = new PImage[]{
    loadImage("res/fest.png"),
    loadImage("res/lose.png"),
    loadImage("res/infinite.png"),
    loadImage("res/done.png"),
    loadImage("res/cancel.png"),
    loadImage("res/pause.png"),
    loadImage("res/edit.png"),
    loadImage("res/stop.png"),
    loadImage("res/play.png")
    
    
  };
  
  for(int i = 0; i < imgs.length; i ++){
    if(imgs[i] == null){
      imgs[i] = getImg();
    }
  }
  
  tick0 = loadImage("res/tick0.png");
  if(tick0 == null){
    tick0 = getImg();
  }
  
  tick1 = loadImage("res/tick1.png");
  if(tick1 == null){
    tick1 = getImg();
  }
  
  
  
}

public PImage getImg(){
  PImage rV = createImage(2, 2, RGB);
      rV.loadPixels();
      rV.pixels[0] = 0;
      rV.pixels[1] = color(255, 0, 255);
      rV.pixels[2] = color(255, 0, 255);
      rV.pixels[3] = 0;
      rV.updatePixels();
  return rV;
}
