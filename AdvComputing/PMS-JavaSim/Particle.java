package src;

import java.util.Set;
import java.util.HashSet;

public class Particle{
   public R3 x;
   public R3 v;
   public R3 a;
   /**
    * <pre>
    *           0..1     0..*
    * Particle ------------------------> Particle
    *           particle        &gt;       vecinity
    * </pre>
    */
   private Set<Particle> vecinity;
   
   public Set<Particle> getVecinity() {
      if (this.vecinity == null) {
         this.vecinity = new HashSet<Particle>();
      }
      return this.vecinity;
   }
//   public void setVecinity(Set<Particle> neighbours){
//	   this.vecinity = neighbours;
//   }
   public Particle sampleCopy(){
	   Particle copy = new Particle();
	   copy.x = this.x.copy();
	   copy.v = this.v.copy();
	   copy.a = this.a.copy();
	   
	   return copy;
   }
   public Particle initialize () {
	   x = new R3();
	   v = new R3();
	   a = new R3();
       
       //this.getVecinity();
       return this;
   }
   
//   public Particle(){
//	   x = new R3();
//	   v = new R3();
//	   a = new R3();
//   }
}