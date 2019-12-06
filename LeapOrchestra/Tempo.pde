import java.util.Arrays;
import java.util.List;
class Tempo {
  List<Vector> vector=new ArrayList<Vector>(); 
  Tempo() {
  }
  Tempo(Vector... v) {
    this.vector=Arrays.asList(v);
  }  
  void add(Vector v) {
    this.add(v);
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
  boolean check(Tempo t) {
    if (t.size()>=this.vector.size()) {
      for (int i=0; i<t.size()-this.vector.size()+1; i++) {
        boolean[] checkTempo=new boolean[this.vector.size()]; 
        boolean check=true;
        for (int j=0; j<this.vector.size(); j++) {
          if (this.vector.get(j).equals(t.get(i+j))) {
            checkTempo[j]=true;
          }
        }
        for (boolean b : checkTempo) {
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
  boolean equals(Tempo tempo) {
    if (this.size()!=tempo.size())return false;
    for (int i=0; i<this.size(); i++) {
      if (!this.get(i).equals(tempo.get(i)))return false;
    }
    return true;
  }
  void copy(Tempo tempo) {
    List<Vector> v=new ArrayList<Vector>(); 
    for (int i=0; i<tempo.size(); i++) {
      v.add(tempo.get(i));
    }
    this.vector=v;
  }
}
class TempoList {

  int num;
  List<Tempo> list;
  List<Float> bpm;
  TempoList(Tempo... tempo) {
    this.num=0;
    this.list=Arrays.asList(tempo);
    this.bpm=new ArrayList<Float>();
  }
  boolean check(Tempo t) {
    Tempo tempo=this.list.get(this.num);
    if (tempo.check(t)) {
      println(++this.num);
      // osc.sendMessage("test", this.num);
      this.num%=this.list.size();
      return true;
    }
    return false;
  }
  boolean check(Tempo t, float b) {
    Tempo tempo=this.list.get(this.num);
    if (tempo.check(t)) {
      //this.bpm.add(this.num==0?0:60/b);
      this.bpm.add(60/b);
      println(this.num+1, this.bpm.get(this.num));
      this.num++;
      this.num%=this.list.size();
      if (this.num==0) {
        println("=================="+"BPM:"+ this.getBpm()+"==================");
        //osc.sendMessage("TEMPO"+this.list.size(), this.getBpm());
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
    //return sum/(this.bpm.size()-1);
    return sum/this.bpm.size();
  }
}
