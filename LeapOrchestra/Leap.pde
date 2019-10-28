enum State {
  NOMOVE, MOVE
}
enum Vector {
  LU, UP, RU, 
    LEFT, CENTER, RIGHT, 
    LD, DOWN, RD
}

public class Leap {

  private LeapMotion leap;

  private boolean change=false;
  private boolean gesture=false;

  private int t=0;
  private State state=State.NOMOVE;
  private Vector vector=Vector.CENTER;
  private ArrayList<Vector> vec=new ArrayList<Vector>(); 


  private com.leapmotion.leap.Controller controller = new com.leapmotion.leap.Controller();
  private boolean gesturezoom=false;
  private float smallestV=500;


  public Leap(LeapMotion leap) {
    this.leap=leap;
  }

  //処理
  public void update() {

    HandDraw();
    if (this.gesture) {
      this.t++;
      check();
    } else if (!this.gesture&&gui.getController("bar").getValue()==1) {
      //wsad();
      think();
      move();
    }
    if (gui.getFlag()&&CheckStop()) {
      gui.getController("PLAY").setValue(0);
    } else if (!gui.getFlag()&&CheckStart()) {
      gui.getController("PLAY").setValue(1);
    }
  }
  private void updateMotion(State s) {
    this.state=s;
  }
  private void think() {
    String msg="";
    for (com.leapmotion.leap.Hand hand : this.controller.frame().hands()) {
      PVector v=new PVector(hand.palmVelocity().getX(), hand.palmVelocity().getY(), hand.palmVelocity().getZ());
      State s=this.state;
      // Vector vec=this.vector;

      switch(s) {
      case NOMOVE:

        if (!isNoMove(v)) {
          s=State.MOVE;
          /*if (v.x<-500 && v.y>500) {
           this.vec.add(Vector.LU);
           } else if (v.x>500 && v.y>500) {
           this.vec.add(Vector.RU);
           } else if (v.x<-500 && v.y<-500) {
           this.vec.add(Vector.LD);
           } else if (v.x>500 && v.y<-500) {
           this.vec.add(Vector.RD);
           } else */          if (v.x<-500) {
            this.vec.add(Vector.LEFT);
          } else if (v.x>500) {
            this.vec.add(Vector.RIGHT);
          } else if (v.y>500/2) {
            this.vec.add(Vector.UP);
          } else if (v.y<-500/2) {
            this.vec.add(Vector.DOWN);
          }
        }
        break;
      case MOVE:
        if (isNoMove(v)) {
          s=State.NOMOVE;
          this.vec.clear();
          // this.vec.add(Vector.CENTER);
          //return;
        } else {
          /*  if (v.x<-500 && v.y>500) {
           this.vec.add(Vector.LU);
           } else if (v.x>500 && v.y>500) {
           this.vec.add(Vector.RU);
           } else if (v.x<-500 && v.y<-500) {
           this.vec.add(Vector.LD);
           } else if (v.x>500 && v.y<-500) {
           this.vec.add(Vector.RD);
           } else */          if (v.x<-500) {
            this.vec.add(Vector.LEFT);
          } else if (v.x>500) {
            this.vec.add(Vector.RIGHT);
          } else if (v.y>500/2) {
            this.vec.add(Vector.UP);
          } else if (v.y<-500/2) {
            this.vec.add(Vector.DOWN);
          }
        }
        /*  switch(this.vec.get(this.vec.size()-1)) {
         case UP:
         if (v.x>500)this.vec.add(Vector.LU);
         if (v.x<-500)this.vec.add(Vector.RU);
         break;
         case DOWN:
         if (v.x>500)this.vec.add(Vector.LD);
         if (v.x<-500)this.vec.add(Vector.RU);
         break;
         case LEFT:
         if (v.y>500)this.vec.add(Vector.LU);
         if (v.y<-500)this.vec.add(Vector.LD);
         break;
         case RIGHT:
         if (v.y>500)this.vec.add(Vector.RU);
         if (v.y<-500)this.vec.add(Vector.RD);
         break;
         }*/
        break;
      }
      updateMotion(s);
    }
  }
  private void move() {
    State s=this.state;
    // Vector vec=this.vector;


    switch(s) {
    case MOVE:
      ArrayList<Vector> temp=new ArrayList<Vector>(); 
      if (this.vec.size()>0) {
        temp.add(this.vec.get(0));
        for (Vector v : this.vec) {
          if (!temp.get(temp.size()-1).equals(v)) {
            temp.add(v);
          }
        }
      }
      print(temp.size()+" ");
      for (Vector v : temp) {
        switch(v) {
        case CENTER:
          print("\nwait……");
          break;
        case LU:
          print("←↑ ");
          break;
        case UP:
          print("↑ ");
          break;
        case RU:
          print("→↑ ");
          break;
        case LEFT:
          print("← ");
          break;
        case RIGHT:
          print("→ ");
          break;
        case LD:
          print("←↓ ");
          break;
        case DOWN:
          print("↓ ");
          break;
        case RD:
          print("→↓ ");
          break;
        }
      }
      println();
      
      //2拍
      /*
      {
        ArrayList<Vector> test=new ArrayList<Vector>(); 
        test.add(Vector.DOWN);
        test.add(Vector.RIGHT);
        test.add(Vector.UP);
        if (temp.size()>=test.size()) {
          for (int i=0; i<temp.size()-test.size()+1; i++) {
            boolean[] t=new boolean[test.size()]; 
            boolean te=true;
            for (int j=0; j<test.size(); j++) {
              if (test.get(j).equals(temp.get(i+j))) {
                t[j]=true;
              }
            }
            for (boolean b : t) {
              if (!b)te=false;
            }
            if (te)println("11111");
          }
        }
      }
      {
        ArrayList<Vector> test=new ArrayList<Vector>(); 
        test.add(Vector.DOWN);
        test.add(Vector.LEFT);
        test.add(Vector.UP);
        if (temp.size()>=test.size()) {
          for (int i=0; i<temp.size()-test.size()+1; i++) {
            boolean[] t=new boolean[test.size()]; 
            boolean te=true;
            for (int j=0; j<test.size(); j++) {
              if (test.get(j).equals(temp.get(i+j))) {
                t[j]=true;
              }
            }
            for (boolean b : t) {
              if (!b)te=false;
            }
            if (te)println("22222");
          }
        }
      }
      */
      
      //3拍
      /*
           {
        ArrayList<Vector> test=new ArrayList<Vector>(); 
        test.add(Vector.DOWN);
        if (temp.size()>=test.size()) {
          for (int i=0; i<temp.size()-test.size()+1; i++) {
            boolean[] t=new boolean[test.size()]; 
            boolean te=true;
            for (int j=0; j<test.size(); j++) {
              if (test.get(j).equals(temp.get(i+j))) {
                t[j]=true;
              }
            }
            for (boolean b : t) {
              if (!b)te=false;
            }
            if (te)println("11111");
          }
        }
      }
           {
        ArrayList<Vector> test=new ArrayList<Vector>(); 
        test.add(Vector.UP);
        test.add(Vector.RIGHT);
        test.add(Vector.DOWN);
        test.add(Vector.RIGHT);
        test.add(Vector.UP);
        if (temp.size()>=test.size()) {
          for (int i=0; i<temp.size()-test.size()+1; i++) {
            boolean[] t=new boolean[test.size()]; 
            boolean te=true;
            for (int j=0; j<test.size(); j++) {
              if (test.get(j).equals(temp.get(i+j))) {
                t[j]=true;
              }
            }
            for (boolean b : t) {
              if (!b)te=false;
            }
            if (te)println("22222");
          }
        }
      }
           {
        ArrayList<Vector> test=new ArrayList<Vector>(); 
        test.add(Vector.DOWN);
        test.add(Vector.LEFT);
        test.add(Vector.UP);
        if (temp.size()>=test.size()) {
          for (int i=0; i<temp.size()-test.size()+1; i++) {
            boolean[] t=new boolean[test.size()]; 
            boolean te=true;
            for (int j=0; j<test.size(); j++) {
              if (test.get(j).equals(temp.get(i+j))) {
                t[j]=true;
              }
            }
            for (boolean b : t) {
              if (!b)te=false;
            }
            if (te)println("33333");
          }
        }
      }
      //4拍
      */
            {
        ArrayList<Vector> test=new ArrayList<Vector>(); 
        test.add(Vector.DOWN);
        if (temp.size()>=test.size()) {
          for (int i=0; i<temp.size()-test.size()+1; i++) {
            boolean[] t=new boolean[test.size()]; 
            boolean te=true;
            for (int j=0; j<test.size(); j++) {
              if (test.get(j).equals(temp.get(i+j))) {
                t[j]=true;
              }
            }
            for (boolean b : t) {
              if (!b)te=false;
            }
            if (te)println("11111");
          }
        }
      }
           {
        ArrayList<Vector> test=new ArrayList<Vector>(); 
        test.add(Vector.UP);
        test.add(Vector.LEFT);
        test.add(Vector.DOWN);
        if (temp.size()>=test.size()) {
          for (int i=0; i<temp.size()-test.size()+1; i++) {
            boolean[] t=new boolean[test.size()]; 
            boolean te=true;
            for (int j=0; j<test.size(); j++) {
              if (test.get(j).equals(temp.get(i+j))) {
                t[j]=true;
              }
            }
            for (boolean b : t) {
              if (!b)te=false;
            }
            if (te)println("22222");
          }
        }
      }
           {
        ArrayList<Vector> test=new ArrayList<Vector>(); 
         test.add(Vector.UP);
        test.add(Vector.RIGHT);
        test.add(Vector.DOWN);
        test.add(Vector.RIGHT);
        test.add(Vector.UP);
        if (temp.size()>=test.size()) {
          for (int i=0; i<temp.size()-test.size()+1; i++) {
            boolean[] t=new boolean[test.size()]; 
            boolean te=true;
            for (int j=0; j<test.size(); j++) {
              if (test.get(j).equals(temp.get(i+j))) {
                t[j]=true;
              }
            }
            for (boolean b : t) {
              if (!b)te=false;
            }
            if (te)println("33333");
          }
        }
      }
          {
        ArrayList<Vector> test=new ArrayList<Vector>(); 
        test.add(Vector.DOWN);
        test.add(Vector.LEFT);
        test.add(Vector.UP);
        if (temp.size()>=test.size()) {
          for (int i=0; i<temp.size()-test.size()+1; i++) {
            boolean[] t=new boolean[test.size()]; 
            boolean te=true;
            for (int j=0; j<test.size(); j++) {
              if (test.get(j).equals(temp.get(i+j))) {
                t[j]=true;
              }
            }
            for (boolean b : t) {
              if (!b)te=false;
            }
            if (te)println("44444");
          }
        }
      }
      break;
    }
    /*  switch(this.vector) {
     case CENTER:
     println("wait……");
     break;
     case LU:
     println("←↑");
     break;
     case UP:
     println("↑");
     break;
     case RU:
     println("→↑");
     break;
     case LEFT:
     println("←");
     break;
     case RIGHT:
     println("→");
     break;
     
     case LD:
     println("←↓");
     break;
     case DOWN:
     println("↓");
     break;
     case RD:
     println("→↓");
     break;
     }*/
  }
  private void wsad() {
    String msg="";
    for (com.leapmotion.leap.Hand hand : this.controller.frame().hands()) {
      PVector v=new PVector(hand.palmVelocity().getX(), hand.palmVelocity().getY(), hand.palmVelocity().getZ());
      if (isNoMove(v)) {
        this.gesturezoom=false;
      }
      if (!gesturezoom) {
        //vector

        if (v.x>500*3.5) {
          msg="→";
          //osc.sendMessage("MUSICNUM", 1);
          //this.gesturezoom=true;
        } else if (v.x<-500*3.5) {
          msg="←";
          //osc.sendMessage("MUSICNUM", -1);
          //this.gesturezoom=true;
        } else if (v.x>500*3) {
          msg="→";
          //osc.sendMessage("TIME", 0.25);
          //this.gesturezoom=true;
        } else if (v.x<-500*3) {
          msg="←";
          //osc.sendMessage("TIME", -0.25);
          //this.gesturezoom=true;
        } else if (v.y>500*3) {
          msg="↑";
          //osc.sendMessage("VOLUME", 1);
          //this.gesturezoom=true;
        } else if (v.y<-500*3) {
          msg="↓";
          //osc.sendMessage("VOLUME", -1);
          //this.gesturezoom=true;
        } else {
          msg="";
          //this.gesturezoom=false;
        }
      }
    }
    text( msg, 50, 150);
  }
  //no move
  private boolean isNoMove(PVector v) {
    return abs(v.x*5)<smallestV&&abs(v.y*5)<smallestV&&abs(v.z*5)<smallestV;
  }
  //ジャスチャーの検出
  void check() {

    for (de.voidplus.leapmotion.Hand hand : this.leap.getHands ()) {
      //ジャスチャーの検出
      if (this.t/60>2) {
        this.t=0;
        fill(255);
        //   text(this.t,width/2,height/2);
        String finger="";
        String msg="";   
        String s="";
        int n=0;

        for (de.voidplus.leapmotion.Finger f : hand.getFingers())finger+=f.isExtended()?1:0;
        switch(finger) {
        case "00000":
          msg="0\nrock";
          s="MUSICNUM";
          n=-1;

          break;
        case "01000":
          s="MUSICNUM";
          n=1;
          msg="1";
          break;

        case "01100":
          s="VOLUME";
          n=-1;
          msg="2\nscissors";
          break;

        case "00111":
          s="VOLUME";
          n=1;
          msg="3";
          break;

        case "01111":
          s="SCALE";
          n=-1;

          msg="4";
          break;

        case "11111":
          s="SCALE";
          n=1;

          msg="5\npaper";
          break;

        case "10001":
          s="TIME";
          n=-1;


          msg="6";
          break;

        case "11000":
          s="TIME";
          n=1;
          msg="7";
          break;

        default:
          msg="?";
          return;
        }
        osc.sendMessage(s, n);
      }
    }
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
  public void setGesture(boolean gesture) {
    this.gesture=gesture;
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
