import java.util.Arrays;

public class Function {
  public int[] edges;

  @Override
  public boolean equals(Object o) {
    if (this == o) return true;
    if (o == null || getClass() != o.getClass()) return false;
    Function function = (Function) o;
    return Arrays.equals(edges, function.edges);
  }

  @Override
  public int hashCode() {
    return Arrays.hashCode(edges);
  }

  public Function inc() {
    edges[edges.length-1]++;
    if(edges[edges.length-1] == edges.length) for(int i=edges.length-1; i>0 && (edges[i]==edges.length); i--) {
      edges[i-1]++;
      edges[i] = 0;
    }
    if(edges[0] == edges.length) {
      edges[0] = 0;
    }
    return this;
  }

  public Function compose() {

  }
}
