package src;


public class R3{

    public double x;

    public double y;

    public double z;

    public R3 copy(){
        R3 copy = new R3();
        copy.x = this.x;
        copy.y = this.y;
        copy.z = this.z;
        return copy;   
    }
    //   public R3 (double x, double y, double z){
    //		super();
    //		this.x = x;
    //		this.y = y;
    //		this.z = z;
    //   }
    public R3 (){
        super();
        this.x = 0.0;
        this.y = 0.0;
        this.z = 0.0;

    }
}