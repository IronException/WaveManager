

public PImage mirror(PImage in){
  PImage rV = createImage(in.width, in.height, ARGB);
  rV.loadPixels();
  in.loadPixels();
  for(int i = 0; i < rV.height; i ++){
    for(int j = 0; j < rV.width; j ++){
      rV.pixels[i * rV.width + j] = in.pixels[i * in.width + in.width - 1 - j];
    }
  }
  
  rV.updatePixels();
  return rV;
}


public class But {
  
  public But(){
    
  }
  
  public But setImg(PImage img){
    this.img = img;
    return this;
  }
  
  public But setPosSize(float xPos, float yPos, float xSize, float ySize){
    this.xPos = xPos;
    this.yPos = yPos;
    this.xSize = xSize;
    this.ySize = ySize;
    nevPosSize();
    return this;
  }
  
  public void nevPosSize(){}
  
  
  PImage img;
  
  float xOffPos, yOffPos, xOffSize, yOffSize;
  float xPos, yPos, xSize, ySize;
  
  
  public boolean tickButton(){
    return tickButton(mouseX, mouseY);
  }
  
  public boolean tickButton(float x, float y){
    if(mousePressed){
    if(x >= xPos && x <= xPos + xSize){
      if(y >= yPos && y <= yPos + ySize){
        return true;
      }
    }
    }
    return false;
  }
  
  public void render(){
    
    if(img != null){
      image(img, xPos, yPos, xSize, ySize);
    }
  }
  
}

public class BoolEnter extends But{
  
  public BoolEnter(){
    
    rn = tick0;
    if(rn == null){
      rn = getImg();
    }
    
    
  }
  
  boolean act;
  String txt;
  PImage rn;
  
  
  
  
  public BoolEnter setTxt(String txt){
    this.txt = txt;
    return this;
  }
  
  
  int timer;
  
  public void tick(){
    if(tickButton() && timer < 0) {
      timer = (int) frameRate / 4;
      
      act = !act;
      if(act){
        rn = tick0;
      } else {
        rn = tick1;
      }
    } else {
      timer --;
    }
  }
  
  
  public void render(){
    
    image(rn, xPos, yPos, ySize, ySize);
    fill(0);
    text(txt, xPos + ySize, yPos + ySize / 2.0 + textAscent() / 2.0);//, ySize, ySize);
    
  }
  
  
}

public class NumEnter extends But{
  
  
  
  
  
  int num;
  String txt;
  boolean active;
  
  int col;
  
  public NumEnter setTxt(String txt){
    this.txt = txt;
    return this;
  }
  
  public NumEnter setCol(int col){
    this.col = col;
    return this;
  }
  
  public NumEnter setNum(int set){
    this.num = set;
    return this;
  }
  
  public void render(){
    fill(col);
    
    if(active){
      if(frameCount % frameRate < frameRate / 2){
        text(txt + ": " + num + "l", xPos, yPos, xSize, ySize);
      } else {
        text(txt + ": " + num + " ", xPos, yPos, xSize, ySize);
      }
    } else {
      text(txt + ": " + num, xPos, yPos, xSize, ySize);
    }
    
    
  }
  
  int timer;
  
  public void tick(){
    if(mousePressed){
      active = tickButton();
      
      
    }
    
    if(active && keyPressed && timer < 0){
      timer = (int) frameRate / 4;
      
      if(keyCode == SHIFT || key == BACKSPACE){
        num /= 10;
      } else {
        try{
          int erg = Integer.parseInt(key + "");
          num *= 10;
          num += erg;
        } catch(Exception e){}
        
        
      }
      
      
    } else {
      timer --;
    }
    
  }
  
  
}




public class FloatEnter extends But{
  
  public FloatEnter(){
    super();
    
    setUnit("m");
    
    
    setNum(0);
    
    canBeActivated(true);
  }
  
  
  String num;
  String txt;
  String unit;
  boolean active;
  
  int col;
  
  boolean canBeA;
  
  public float getNum(){
    String[] sp = this.num.split(komma + "");
    String rV = sp[0];
    if(sp.length > 1){
      rV += "." + sp[1];
    } else if(rV.length() == 0){
      rV = "0";
    }
    
    return Float.parseFloat(rV);
  }
  
  public FloatEnter setTxt(String txt){
    this.txt = txt;
    return this;
  }
  
  public FloatEnter canBeActivated(boolean a){
    this.canBeA = a;
    if(!a) setCol(64);
    return this;
  }
  
  public FloatEnter setUnit(String txt){
    this.unit = txt;
    return this;
  }
  
  public FloatEnter setCol(int col){
    this.col = col;
    return this;
  }
  
  public FloatEnter setNum(float set){
    String[] sp = (set + "").split("\\.");
    this.num = sp[0];
    if(!sp[1].equals("0")){
      this.num += komma + sp[1];
    }
    
    return this;
  }
  
  public void render(){
    fill(col);
    
    if(active){
      if(frameCount % frameRate < frameRate / 2){
        text(txt + ": " + num + "l " + unit, xPos, yPos, xSize, ySize);
      } else {
        text(txt + ": " + num + "  " + unit, xPos, yPos, xSize, ySize);
      }
    } else {
      text(txt + ": " + num + " " + unit, xPos, yPos, xSize, ySize);
    }
    
    
  }
  
  int timer;
  char komma = ',';
  
  public void tick(){
    if(mousePressed && canBeA){
      active = tickButton();
      
      
    }
    
    if(active && keyPressed && timer < 0){
      timer = (int) frameRate / 4;
      
      if(keyCode == SHIFT || key == BACKSPACE){
        try{
          num = num.substring(0, num.length() - 1);
        } catch(Exception e){}
      } else if(key == '.' || key == ','){
        boolean isKomma = false;
        for(int i = 0; i < num.length(); i ++){
          if(num.charAt(i) == komma){
            isKomma = true;
            break;
          }
        }
        
        if(!isKomma){
          num += komma;
        }
        
      } else if(
        key == '0' ||
        key == '1' ||
        key == '2' ||
        key == '3' ||
        key == '4' ||
        key == '5' ||
        key == '6' ||
        key == '7' ||
        key == '8' ||
        key == '9'
      ){
        
        //bei num = "0": ersetzen
        
        if(num.length() == 1 && num.charAt(0) == '0'){
          num = "";
        }
        
        num += key;
        
      }
      
      
    } else {
      timer --;
    }
    
  }
  
  
}

public class RadioBut extends FloatEnter{
  
  float val;
  float dif;
  
  @Override
  public RadioBut setNum(float num){
    this.val = num;
    return this;
  }
  
  public void render(){
    
    dif = xSize / 32.0;
    
    
    
    float y = yPos + txtH + (ySize - txtH) / 2.0;
    float lineStart = xPos + textWidth(txt) + dif;
    
    text(txt, xPos, yPos + txtH);
    line(lineStart, y, xPos + xSize - dif, y);
    ellipse(lineStart + val * (xSize - 2.0 * dif - textWidth(txt)) / 100.0, y, dif, dif);
    // 4x/3 = 24
    
  }
  
  
  public void tick(){
    if(tickButton()){
      val = 100.0 * (mouseX - textWidth(txt) - dif - xPos) / (xSize - 2.0 * dif - textWidth(txt));
      
      if(val > 100.0){
        val = 100.0;
      } else if (val < 0){
        val = 0;
      }
    }
  }
  
  
  public float getNum(){
    // TODOD how to convert....
    return val;
  }
  
}




public float function(float x){
  
  if(x < 0){
    return 0;
  }
  return sin(x);
}
