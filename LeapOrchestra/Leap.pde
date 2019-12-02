enum Vector {
  LU, UP, RU, 
    LEFT, CENTER, RIGHT, 
    LD, DOWN, RD
}

public class Leap {

  private LeapMotion leap;

  private boolean change=false;
  private Tempo vec=new Tempo();
  private com.leapmotion.leap.Controller controller = new com.leapmotion.leap.Controller();
  private float smallestV=500;

  private Tempo[][] tempo={{}, {}, 
    //Tempo2
    {new Tempo(new Vector[]{Vector.DOWN, Vector.RIGHT, Vector.UP}), 
      new Tempo(new Vector[]{Vector.DOWN, Vector.LEFT, Vector.UP})}, 
    //Tempo3
    {new Tempo( new Vector[]  {Vector.DOWN}), 
      new Tempo( new Vector[]  {Vector.DOWN, Vector.RIGHT, Vector.UP}), 
      new Tempo( new Vector[]  {Vector.DOWN, Vector.LEFT, Vector.UP}), 
    }, 
    //Tempo4
    {new Tempo(new Vector[]{Vector.DOWN}), 
      new Tempo(new Vector[]{Vector.LEFT}), 
      new Tempo(new Vector[]{Vector.DOWN, Vector.RIGHT, Vector.UP}), 
      new Tempo(new Vector[]{ Vector.DOWN, Vector.LEFT, Vector.UP})}
  };
  public TempoList tempolist=new TempoList(tempo[2]);
  int f=0;
  int tf=0;
  int t=0;
  public Leap(LeapMotion leap) {
    this.leap=leap;
  }

  //処理
  public void update() {
    HandDraw();
    if (gui.getController("bar").getValue()!=0) {
      if (think()) {
        move();
      }
    }
    if (gui.getFlag()&&CheckStop()) {
      gui.getController("PLAY").setValue(0);
    } else if (!gui.getFlag()&&CheckStart()) {
      gui.getController("PLAY").setValue(1);
    }
  }

  private boolean think() {

    for (com.leapmotion.leap.Hand hand : this.controller.frame().hands()) {
      PVector v=new PVector(hand.palmVelocity().getX(), hand.palmVelocity().getY(), hand.palmVelocity().getZ());
      String frame=this.controller.frame().toString();
      f=Integer.parseInt(frame.substring(9, frame.length()))/60/2;
            // println(f);
    
    t++;
    println(t/3*0.1);
      if (isNoMove(v)) {
        this.vec.clear();
        return false;
      }
      //  this.vec.clear();

     

      Vector rvector=Vector.CENTER;
      Vector vector=Vector.CENTER;
      if (this.vec.size()!=0) {
        rvector=this.vec.getVector(this.vec.size()-1);
      }
      if (v.x<-500) {
        vector=Vector.LEFT;
      } else if (v.x>500) {
        vector=Vector.RIGHT;
      } else if (v.y>500/2) {
        vector=Vector.UP;
      } else if (v.y<-500/2) {
        vector=Vector.DOWN;
      }
      if (!rvector.equals(vector)&&!vector.equals(Vector.CENTER)) {
        this.vec.add(vector);
        //    println(vec.toString());
      }
      return this.vec.size()>0;
    } 
    return false;
  }
  private void move() {
    checkVector();
  }
  private void checkVector() {

    if (tempolist.check(this.vec)) {
      this.vec.clear();
    }
  }
  public void changeTempo(int n) {
    this.tempolist=new TempoList(this.tempo[n]);
  }
  //no move
  private boolean isNoMove(PVector v) {
    return abs(v.x*2)<smallestV&&abs(v.y*2)<smallestV&&abs(v.z*2)<smallestV;
  }
  private void HandDraw() {
    for (de.voidplus.leapmotion.Hand hand : this.leap.getHands ()) {
      for (de.voidplus.leapmotion.Finger finger : hand.getFingers()) {
        strokeWeight(10);
        finger.drawBones();
        finger.drawJoints();
      }
    }
  }
  public boolean CheckStop() {
    if (this.leap.getHands().size()!=2)return false;
    int n=0;
    for (de.voidplus.leapmotion.Hand hand : this.leap.getHands ()) {
      n+=(hand.getGrabStrength()==1)?1:0;
    }
    return n==2;
  }
  public boolean CheckStart() {
    if (this.leap.getHands().size()!=2)return false;
    int n=0;
    for (de.voidplus.leapmotion.Hand hand : this.leap.getHands ()) {
      n+=(hand.getGrabStrength()==1)?1:0;
    }
    return n==0;
  }
  public  boolean isExist() {
    return this.leap.getHands().size()>0;
  }
  public boolean isRight() {
    for (de.voidplus.leapmotion.Hand hand : this.leap.getHands ()) {
      return hand.isRight();
    }
    return false;
  }
  public PVector getPos() {
    for (de.voidplus.leapmotion.Hand hand : this.leap.getHands ()) {
      return hand.isRight()?hand.getPosition():new PVector(width/2, height/2);
    }
    return null;
  }

  public boolean getClick() {
    for (de.voidplus.leapmotion.Hand hand : this.leap.getHands ()) {
      if (hand.isRight()) {
        String finger="";
        for (de.voidplus.leapmotion.Finger f : hand.getFingers())finger+=f.isExtended()?1:0;
        return finger.equals("00000");
      }
    }
    return false;
  }
  public boolean CheckChange() {
    return !change&&getClick();
  }
  public boolean getChange() {
    return this.change;
  }
  public void setChange(boolean change) {
    this.change=change;
  }
}

public  void leapOnInit() {
  println("Leap Motion Init");
}
public  void leapOnConnect() {
  println("Leap Motion Connect");
}
public  void leapOnDisconnect() {
  println("Leap Motion Disconnect");
}
public  void leapOnExit() {
  println("Leap Motion Exit");
}
