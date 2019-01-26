





// Page for new waves


public class NevWave{
  
  
  boolean isNev;
  int indr;
  
  public NevWave(int indr, boolean isNev){
    this.indr = indr;
    this.isNev = isNev;
    
    
    wOv = new WaveOverview();
    
    isLine = new BoolEnter().setTxt("Schnur");
    isLine.act = true;
    
    
    pointN = new NumEnter().setTxt("Teilchen");
    pointN.setNum(12);
    
    
    
    
    
    float xP = txtH * 2.0;
    
    float xPos, xSize, yPos, ySize;
    xPos = xP;
    xSize = width - xP * 2.0;
    ySize = height / 4.0;
    yPos = height / 2.0 - ySize / 2.0;
    
    
    wOv.setPosSize(xPos, yPos, xSize, ySize);
    
    xPos = xP * 1.5; //width / 2.0 - xP * 3.0;
    yPos += ySize;
    ySize = txtH;
    
    
    isLine.setPosSize(xPos, yPos, xSize, ySize);
    
    yPos += ySize + xP / 2.0;
    pointN.setPosSize(xPos, yPos, xSize, ySize);
    
    
    
    xSize = width / 2.0 - xPos;
    
    xPos = xP;
    yPos = xP * 1.5;
    xSize = width / 2.0 - xP;
    
    int ind = 0;
    floats = new FloatEnter[5];
    floats[ind] = new RadioBut().setTxt("Amplitude s");
    floats[ind].setPosSize(xPos, yPos, xSize, ySize);
    floats[ind].setNum(50);
    ind ++;
    
    xPos += xSize + xP;
    
    floats[ind] = new FloatEnter().setTxt("Träger");
    floats[ind].setPosSize(xPos, yPos, xSize, ySize);
    floats[ind].setNum(5);
    ind ++;
    
    xPos -= xSize + xP;
    yPos += ySize + xP / 1.5;
    
    floats[ind] = new FloatEnter().setTxt("Frequenz f");
    floats[ind].setPosSize(xPos, yPos, xSize, ySize);
    floats[ind].setNum(0.5);
    fInd = ind;
    floats[ind].setUnit("1/s");
    ind ++;
    
    xPos += xSize + xP;
    
    floats[ind] = new FloatEnter().setTxt("Wellenlänge");
    floats[ind].setPosSize(xPos, yPos, xSize, ySize);
    lambdaInd = ind;
    floats[ind].setNum(1);
    floats[ind].canBeActivated(false);
    ind ++;
    
    xPos -= xSize + xP;
    yPos += ySize + xP / 1.5;
    
    floats[ind] = new FloatEnter().setTxt("Ausbreitungsgeschwindigkeit c");
    floats[ind].setPosSize(xPos, yPos, xSize, ySize);
    cInd = ind;
    floats[ind].setNum(1);
    floats[ind].setUnit("m/s");
    //floats[ind].canBeActivated(false);
    ind ++;
    
    
    
    
    xP = txtH * 3.0;
    
    
    xSize = width / 8.0;
    
    ySize = txtH * 2.5;
    
    yPos = height - 1.8 * ySize;
    xPos = width - xSize * 3.0;
    
    cancel = new But();
    cancel.setImg(imgs[4]);
    cancel.setPosSize(xPos, yPos, xSize, ySize);
    
    xPos += 1.5 * xSize;
    
    done = new But();
    done.setImg(imgs[3]);
    done.setPosSize(xPos, yPos, xSize, ySize);
    
    
    
    // make: Gegenwelle: + Ursprungswelle erstellen, anzeigen
    
    
    extraW = new BoolEnter[]{
      new BoolEnter().setTxt("erstellen"),
      new BoolEnter().setTxt("anzeigen"),
      new BoolEnter().setTxt("erstellen"),
      new BoolEnter().setTxt("anzeigen")
      
    };
    
    
    xSize = width / 8.0;
    ySize = txtH * 2.2;
    
    xPos = 2.0 * width / 3.0;
    yPos = 3.0 * height / 5.0;
    
    //xSize = width / 7.0;
    
    
    extraW[0].setPosSize(xPos, yPos, xSize, ySize);
    xPos += xSize;
    extraW[1].setPosSize(xPos, yPos, xSize, ySize);
    yPos += ySize;
    xPos -= xSize;
    extraW[2].setPosSize(xPos, yPos, xSize, ySize);
    xPos += xSize;
    extraW[3].setPosSize(xPos, yPos, xSize, ySize);
    
    
    this.xPos = xPos - 2.0 * xSize;
    this.yPos = yPos - ySize / 3.0;
    this.y2Pos = this.yPos + ySize;
    
  }
  
  float xPos, yPos, y2Pos;
  
  WaveOverview wOv;
  int pointNums;
  
  float xTxtPos, yTxtPos, xTxtSize, yTxtSize;
  
  int cInd, lambdaInd, fInd;
  
  BoolEnter isLine;
  NumEnter pointN;
  
  FloatEnter[] floats;
  
  BoolEnter[] extraW;
  
  But done, cancel;
  
  public void render(){
    background(255);
    
    isLine.render();
    pointN.render();
    
    
    // c = lambda * f
    float fI = floats[fInd].getNum();
    if(fI != 0){
      floats[lambdaInd].setNum(floats[cInd].getNum() / fI);
    }
    
    
    for(int i = 0; i < floats.length; i ++){
      floats[i].render();
    }
    
    
    wOv.render();
    
    // TODO maybe test wether act render?
    //-----------------------------------------
    for(int i = 0; i < extraW.length; i ++){
      extraW[i].render();
      
    }
    
    
    
    // text:
    text("Gegenwelle: ", xPos, yPos);
    text("Ursprungswelle: ", xPos, y2Pos);
    
    // eyts
    // -------------------------------------------
    
    done.render();
    cancel.render();
    
    
  }
  
  
  
  
  public void tick(){
    
    for(int i = 0; i < extraW.length; i ++){
      extraW[i].tick();
    }
    
    wOv.tick();
    isLine.tick();
    for(int i = 0; i < floats.length; i ++){
      floats[i].tick();
    }
    
    if(isLine.act){
      pointN.setCol(0);
      wOv.isLine = pointN.num;
    } else {
      pointN.setCol(128);
      wOv.isLine = -1;
    }
    pointN.tick();
    
    
    
    if(cooldown > 0){
      cooldown --;
    } else if(cancel.tickButton()){
      
      if(isNev){
        panels.remove(indr);
      }
      
      cooldown = (int) frameRate / 2;
      nevWave = null;
    } else if(done.tickButton()){
      
      float trager = floats[1].getNum();
      float f = floats[2].getNum();
      float c = floats[4].getNum();
      float lamda = floats[3].getNum();
      float amp = floats[0].getNum();
      
      WavePoints nev = new WavePoints(indr, trager, f, c, lamda, wOv.lEnd, wOv.rEnd, amp);
      nev.wOv.setEnds(wOv.lEnd, wOv.rEnd);
      nev.start = millis();
      
      
      panels.set(indr, nev);
      cooldown = (int) frameRate / 2;
      nevWave = null;
    }
    //nevWave = null;
  }
  
  
  
  
}

public class WaveOverview extends But{
  
  int lEnd, rEnd;
  
  float erregerPos;
  
  float size;
  
  
  
  
  
  public WaveOverview(){
    super();
    
    lEnd = 2;
    rEnd = 2;
    
    
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
    
    erregerPos = xPos + xSize / 2.0;
    
  }
  
  But[] ends;
  
  float xEnd;
  
  
  
  int timer;
  
  public void tick(){
    if(timer > 0){
      timer --;
      return;
    }
    
    if(tickButton()){
      if(ends[0].tickButton()){
        timer = (int) frameRate / 4;
        
        lEnd ++;
        if(lEnd > 2){
          lEnd = 0;
        }
        ends[0].setImg(mirror(imgs[lEnd]));
      } else if(ends[1].tickButton()){
        timer = (int) frameRate / 4;
        
        rEnd ++;
        if(rEnd > 2){
          rEnd = 0;
        }
        ends[1].setImg(imgs[rEnd]);
        
      } else {
        
        if(mouseX >= xPos + xEnd - 1 && mouseX <= xPos + xSize - xEnd){
          erregerPos = mouseX;
        }
        
        
      }
      
      
    }
    
    
  }
  
  
  int isLine;
  
  public WaveOverview setEnds(int lEnd, int rEnd){
    this.lEnd = lEnd;
    this.rEnd = rEnd;
    ends[0].setImg(mirror(imgs[lEnd]));
    ends[1].setImg(imgs[rEnd]);
    return this;
  }
  
  public void render(){
    
    ends[0].render();
    ends[1].render();
    
    
    float y = yPos + ySize / 2.0;
    float lS;
    if(isLine < 1){
      line(xPos + xEnd, y, xPos + xSize - xEnd, y);
      
      lS = xEnd / 32.0;
      line(erregerPos, y - lS, erregerPos, y + lS);
      
    } else {
      
      lS = (xSize - 2.0 * xEnd) / (isLine - 1);
      for(int i = 0; i < isLine; i ++){
        
        fill(255);
        if((int) ((erregerPos - xEnd - xPos) / lS + 0.5) == i){
          fill(255, 0, 0);
        }
        
        ellipse(xPos + xEnd + i * lS, y, size, size);
      }
      
      
    }
    
    
    
    
  }
  
  
}
