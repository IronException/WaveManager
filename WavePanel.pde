


public class WavePanel{
  
  public void init(){}
  
  int pos;
  
  public WavePanel(int pos){
    yPos = pos * ySize;
    this.pos = pos;
    
    buts = new But[]{
      new But().setImg(imgs[5]),
      new But().setImg(imgs[6]),
      new But().setImg(imgs[7]),
      new But().setImg(imgs[8])
      
    };
    
    // the buttonSize
    
    setPosSize();
    
    
    // TODO scrollSize...
    
    for(int i = 0; i < panels.size(); i ++){
      panels.get(i).init();
    }
    
    init();
    
  }
  
  float ySize;
  
  public void setPosSize(){
    float sSize = panelSize - 2.0 * txtH;
    yPos = pos * panelSize;
    
    this.ySize = sSize;
    if(sSize < 100){
      buts[0].setPosSize(xSubSize + txtH, yPos + txtH, sSize, sSize);
      buts[1].setPosSize(width - txtH - sSize, yPos + txtH, sSize, sSize);
      buts[2].setPosSize(xSubSize + txtH, yPos + txtH, sSize / 2.0, sSize);
      buts[3].setPosSize(xSubSize + txtH + sSize / 2.0, yPos + txtH, sSize / 2.0, sSize);
      
      this.endSize = 2.0 * txtH + 2.0 * sSize;
    } else {
      
      sSize = panelSize / 2.0;
      // xPos = width - (txtH) - sSize
      // yPos = yPos + (txtH) && yPos + (txtH) + sSize
      // xSize = sSize && sSize / 2.0 d
      // ySize = sSize d
      buts[0].setPosSize(width - sSize, yPos + sSize, sSize, sSize);
      buts[1].setPosSize(width - sSize, yPos + 1, sSize, sSize);
      buts[2].setPosSize(width - sSize, yPos + sSize, sSize / 2.0, sSize);
      buts[3].setPosSize(width - sSize / 2.0, yPos + sSize, sSize / 2.0, sSize);
      
      this.endSize = sSize;
      
    }
  }
  
  
  But[] buts;
  
  float yPos, endSize;
  
  int start;
  
  public int getTime(){
    if(pause){
      return pauseDif;
    }
    return millis() - start;
  }
  
  
  
  public boolean doRender(){
    //if(scrollPosY + yPos < height){
      render();
    return false;
  }
  
  public void render(){
    render(yPos);
  }
  
  boolean pause;
  
  public void render(float yPos){
    fill(255);
    
    setPosSize();
    
    rect(0, yPos, width, panelSize);
    // render pause + edit
    
    
    if(pause){
      buts[2].render();
      buts[3].render();
      
    } else {
      buts[0].render();
      
    }
    buts[1].render();
    
      
      fill(128);
      text(getTime() + "", width - 2.0 * txtH, yPos + panelSize / 2.0, panelSize, panelSize / 4.0);
      // TODO remove this text reńder ^
    
  }
  
  public float getEndSize(){
    return endSize;
  }
  
  int pauseDif;
  
  int timer;
  
  public void setNevWave(){}
  
  public void tick(){
    
    
    
    if(timer > 0){
      timer --;
      return;
    }
    
    boolean didSth = true;
    if(buts[1].tickButton()){
      nevWave = new NevWave(pos, false);
      setNevWave();
      pause();
    } else if(pause){
      if(buts[2].tickButton()){
        start = millis();
        pause = false;
      } else if(buts[3].tickButton()){
        start = millis() - pauseDif;
        pause = false;
      } else {
        didSth = false;
      }
    } else if(buts[0].tickButton()){
      pause();
    }else{
      didSth = false;
    }
    
    if(didSth){
      timer = (int) frameRate / 4;
    }
    
  }
  
  public void pause(){
    pauseDif = getTime();
    pause = true;
    
  }
  
}


public class UniversalW extends WavePanel{
  
  public UniversalW(){
    super(0);
  }
  
  
  
  
}
