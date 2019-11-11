import java.util.Arrays;
import java.util.List;
public class Tempo {
  private List vector;//test=new ArrayList<Vector>(); 
  public Tempo(Vector... v) {
    this.vector=Arrays.asList(v);
  }
  public boolean check(ArrayList v) {
    if (v.size()>=this.vector.size()) {
      for (int i=0; i<v.size()-this.vector.size()+1; i++) {
        boolean[] t=new boolean[this.vector.size()]; 
        boolean te=true;
        for (int j=0; j<this.vector.size(); j++) {
          if (this.vector.get(j).equals(v.get(i+j))) {
            t[j]=true;
          }
        }
        for (boolean b : t) {
          if (!b)te=false;
        }
        return te;
      }
    }
    return false;
  }
}
public class TempoList {
  private int num;
  private List<Tempo> list;
  public TempoList(Tempo... tempo) {
    this.num=0;
    this.list=Arrays.asList(tempo);
  }
  public void check(ArrayList v) {
    Tempo tempo=this.list.get(this.num);
    if (tempo.check(v)) {
      
      println(this.num+1);
      
      this.num=(this.num+1>=this.list.size())?0:this.num+1;
    }
  }
}
