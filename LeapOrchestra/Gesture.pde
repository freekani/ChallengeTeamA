import java.util.Arrays;
import java.util.List;
class Gesture {
  List<Vector> vector=new ArrayList<Vector>(); 
  Gesture() {
  }
  Gesture(Vector... v) {
    this.vector=Arrays.asList(v);
  }  
  void add(Vector v) {
    this.vector.add(v);
  }
  int size() {
    return this.vector.size();
  }
  void clear() {
    this.vector.clear();
  }
  Vector get(int index) {
    return this.vector.get(index);
  }
  boolean check(Gesture g) {
    if (g.size()>=this.vector.size()) {
      for (int i=0; i<g.size()-this.vector.size()+1; i++) {
        boolean[] checkGesture=new boolean[this.vector.size()]; 
        boolean check=true;
        for (int j=0; j<this.vector.size(); j++) {
          if (this.vector.get(j).equals(g.get(i+j))) {
            checkGesture[j]=true;
          }
        }
        for (boolean b : checkGesture) {
          if (!b)check=false;
        }
        if (check)return true;
      }
    }
    return false;
  } 
  String toString() {
    String str="";
    for (int i=0; i<this.vector.size(); i++) {
      Vector v=(Vector)this.vector.get(i);
      switch(v) {
      case CENTER:
        str+="wait…… ";
        break;
      case LU:
        str+="←↑ ";
        break;
      case UP:
        str+="↑ ";
        break;
      case RU:
        str+="→↑ ";
        break;
      case LEFT:
        str+="← ";
        break;
      case RIGHT:
        str+="→ ";
        break;
      case LD:
        str+="←↓ ";
        break;
      case DOWN:
        str+="↓ ";
        break;
      case RD:
        str+="→↓ ";
        break;
      }
    }
    return str;
  }
  boolean equals(Gesture g) {
    if (this.size()!=g.size())return false;
    for (int i=0; i<this.size(); i++) {
      if (!this.vector.get(i).equals(g.get(i)))return false;
    }
    return true;
  }
}
class GestureList {

  int num;
  List<Gesture> list;
  List<Float> bpm;
  GestureList(Gesture... g) {
    this.num=0;
    this.list=Arrays.asList(g);
    this.bpm=new ArrayList<Float>();
  }
  boolean check(Gesture g) {
    Gesture gesture=this.list.get(this.num);
    if (gesture.check(g)) {
      println(++this.num);
      // osc.sendMessage("test", this.num);
      this.num%=this.list.size();
      return true;
    }
    return false;
  }
  boolean check(Gesture g, float b) {
    Gesture gesture=this.list.get(this.num);
    if (gesture.check(g)) {
      this.bpm.add(this.num==0?0:60/b);
      println(this.num+1, this.bpm.get(this.num));
      this.num++;
      this.num%=this.list.size();
      if (this.num==0) {
        println("=================="+"BPM:"+ this.getBpm()+"==================");
        osc.sendMessage("BPM",this.getBpm());
        this.bpm.clear();
      }
      return true;
    }
    return false;
  }
  int getBpm() {
    if (this.bpm.size()==0)return 0;
    int sum=0;
    for (float b : this.bpm)sum+=b;
    return sum/(this.bpm.size()-1);
  }
}
