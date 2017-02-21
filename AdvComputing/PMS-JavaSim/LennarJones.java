package src;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;  
import java.util.Comparator; 

public class LennarJones {

	private class R2{
		double x;
		double y;
		public R2(double xx,double yy){
			this.x=xx; this.y=yy;
		}
	}
	private List <R2> data;
	public LennarJones(){
		this.data = new ArrayList<R2>();
	}
	
	public void register(double distance, double potential){
		this.data.add(new R2(distance,potential));
	}
	public void print(String filename){
		PrintWriter out_file = null;
		
		Collections.sort(data, new Comparator() {
			@Override
			public int compare(Object i1, Object i2) {  
			   return (((R2)i1).x > ((R2)i2).x) ? 1 : -1;
			}  
		});  

		try{
			out_file = new PrintWriter (new FileWriter( filename ));
			for(R2 pair: data){
				out_file.println(pair.x+"\t"+pair.y);
			}
		}catch (IOException ex) {
            
        } 
	}
}
