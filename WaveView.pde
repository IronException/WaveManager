
public class WaveView extends But{
  
  int lEnd, rEnd;
  
  float erregerPos;
  
  float size;
  
  int timer;
  
  
  
  public WaveView(int lEnd, int rEnd){
    super();
    
    this.lEnd = lEnd;
    this.rEnd = rEnd; // 2 doesnt render anything
    // but y?
    
    size = 10;
    
    ends = new But[]{
      new But().setImg(mirror(imgs[lEnd])),
      new But().setImg(imgs[rEnd])
      
    };
    
  }
  
  
  public void nevPosSize(){
    xEnd = ySize / 2.0;
    
    ends[0].setPosSize(xPos, yPos, xEnd, ySize);
    ends[1].setPosSize(xPos + xSize - xEnd, yPos, xEnd, ySize);
    //  TODOD prly not wanted...
    erregerPos = xPos + xSize / 2.0;
  }
  
  But[] ends;
  
  float xEnd;
  
  
  
  
  
  public WaveView setEnds(int lEnd, int rEnd){
    this.lEnd = lEnd;
    this.rEnd = rEnd;
    ends[0].setImg(mirror(imgs[lEnd]));
    ends[1].setImg(imgs[rEnd]);
    return this;
  }
  
  public void tick(){
    if(tickButton()){
      if(ends[0].tickButton() && timer < 0){
        timer = (int) frameRate / 4;

        lEnd ++;
        if(lEnd > 2){
          lEnd = 0;
        }
        ends[0].setImg(mirror(imgs[lEnd]));
      } else if(ends[1].tickButton() && timer < 0){
        timer = (int) frameRate / 4;
        
        rEnd ++;
        if(rEnd > 2){
          rEnd = 0;
        }
        ends[1].setImg(imgs[rEnd]);
        
      } else {
        timer --;
        
        if(mouseX >= xPos + xEnd - 1 && mouseX <= xPos + xSize - xEnd){
          erregerPos = mouseX;
        }
        
        
      }
      
      
    }
    
    
  }
  
  
  int isLine;
  
  
  
  public void render(int time, float trager, float f, float c, float lamda, float amp){
    // render the ends
    if(lEnd != 2 && dontRenderInf){
      ends[0].render();
    }
    if(rEnd != 2 && dontRenderInf){
      ends[1].render();
    }
    
    // the points
    float yy = yPos + ySize / 2.0;
    float lS;
    float y;
    if(isLine < 1){
      // 0 niveau line
      line(xPos + xEnd, yy, xPos + xSize - xEnd, yy);
      
      lS = xEnd / 32.0;
      // a marker where the erreger point is
      line(erregerPos, yy - lS, erregerPos, yy + lS);
      
    } else {
      // show all the points
      lS = (xSize - 2.0 * xEnd) / (isLine - 1);
      
      float t = time / 1000.0;
      float fac = trager / (xSize);// - 2.0 * xEnd);
      float e = (erregerPos - xPos) * fac;
      float a = amp * ySize / 200.0;
      fac = trager / (isLine - 1);
      /*
        x      = 
        trager = ySize
      */
      for(int i = 0; i < isLine; i ++){
        
        fill(255);
        if((int) ((erregerPos - xEnd - xPos) / lS + 0.5) == i){
          fill(255, 0, 0);
        }
        
        // amp = ySize / 2.0
        //y = getY(i, isLine, amp, time, trager, f, c, lEnd, rEnd); // TODO expand prly
        y = getWave(i * fac, e, t, a, f, c, lEnd, rEnd);
        // i * fac, e
        ellipse(xPos + xEnd + i * lS, yy  - y, size, size);
      }
      
      
    }
    
    
    
    
  }
  
  /*
    pos m
    erregerPos m
    time s
    amp m
    f 1/s
    c m/s
    lEnd
    rEnd
  */
  
  
  public float getY(float xx, float maxX, float maxY, float time, float trager, float f, float c, int lEnd, int rEnd){
    float x = trager * xx / maxX;
    time /= 1000.0;
    float xErregerPos = erregerPos * xx / maxX;
    
    
    float rV = (time * c - abs(x - erregerPos)) * f;
    
    
    
    if(lEnd != 0){
      // ...
    }
    
    /*
    //Träger,
    Amplitute = maxY
    Frequenz,
    Ausbreitungsgeschw. c,
    Wellenlänge
    //
    // 
    // xPos
    
    */
    return maxY * function(rV);
  }
  
  public float getWave(float pos, float erregerPos, float time, float amp, float f, float c, int lEnd, int rEnd){
    float rV = calcWavePoint(amp, time, c, abs(erregerPos - pos), f);
    float toAdd = 0;
    if(lEnd != 0){
      toAdd = calcWavePoint(amp, time, c, abs(erregerPos - pos), f);
    }
    
    return rV;
  }
  
  public float calcWavePoint(float amp, float time, float c, float dist, float f){
    return amp * function((time * c - dist) * f);
  }
  
  
}
