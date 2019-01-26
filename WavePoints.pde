

// standard WaveRender

public class WavePoints extends WavePanel{
  
  public WavePoints(int ind, float trager, float f, float c, float lamda, int lEnd, int rEnd, float amp){
    super(ind);
    
    this.trager = trager;
    this.f = f;
    this.c = c;
    this.lamda = lamda;
    this.amp = amp;
    
    
    float xP = txtH;
    float afterW = xSubSize - 2.0 * txtH;
    float afterWH = panelSize - 2.0 * txtH;
    
    wOv = new WaveView(lEnd, rEnd);
    wOv.setPosSize(xP, yPos + txtH, afterW, afterWH);
    wOv.isLine = 64;
    wOv.setEnds(lEnd, rEnd);
    
  }
  
  
  
  WaveView wOv;
  
  
  public void setPosSize(){
    super.setPosSize();
    
    float xP = txtH;
    //float afterW = xSubSize - 2.0 * txtH;
    float afterW = width - getEndSize() - 2.0 * xP;
    float afterWH = panelSize - 2.0 * txtH;
    try{
      wOv.setPosSize(xP, yPos + txtH, afterW, afterWH);
    } catch(Exception e){}
    
  }
  
  public void render(){
    super.render();
    wOv.render(super.getTime(), trager, f, c, lamda, amp);
    
  }
  
  float trager, f, c, lamda, amp;
  
  
  public void setNevWave(){
    
    nevWave.wOv.setEnds(wOv.lEnd, wOv.rEnd);
    
    
    
  }
  
  
  
  
  
  
  
  
}
