package src;

//import java.util.Iterator;
import java.util.Set;
import java.util.HashSet;
import java.util.List;
import java.util.ArrayList;

/**
 * PG */public class State{

	 // Attributes
	 private static int seed=0;
	 private EnergyValue energy;
	 private static int numberReCalculateNeighbourList;
	 private static double cell;
	 static int numParticles ;
	 private double max_displacement;
	 private static double L;
	 private Set<Particle> sampleScope;
	 private List<Particle> particle;
	 private Set<Particle> sampleParticle;

	 // Method
	 public void setEnergy(EnergyValue value) {
		 this.energy = value;
	 }

	 public EnergyValue getEnergy() {
		 return this.energy;
	 }

	 public void setMax_displacement(double value) {
		 this.max_displacement = value;
	 }

	 public double getMax_displacement() {
		 return this.max_displacement;
	 }


	 public static void setL(double value) {
		 State.L = value;
	 }

	 public static double getL() {
		 return State.L;
	 }

	 public Set<Particle> getSampleScope() {
		 if (this.sampleScope == null) {
			 this.sampleScope = new HashSet<Particle>();
		 }
		 return this.sampleScope;
	 }

	 /*
		* This method creates the sampleScope List for a state before copying it into the sample
		* AD 
		*/
	 public void takeSampleInScope() {
		 // TODO implement this operation
		 //throw new UnsupportedOperationException("not implemented");
		 //to do it correctly it should select the particles of interest and copy them inside the set

		 //calculus of the borders of the cube of interest
		 double posBorder = cell*ConfigData.sampleCells/2.0;
		 double negBorder = posBorder * (-1);

		 //initializes the set sampleScope
		 this.getSampleScope().clear();;

		 //take the particles of interest from the complete list into the sampleScope  
		 for (Particle p: particle){
			 if ( (p.x.x > negBorder && p.x.x < posBorder) && 
					 (p.x.y > negBorder && p.x.y < posBorder) &&
					 (p.x.z > negBorder && p.x.z < posBorder)    ) { //  <--- if its position is in the scope
				 this.sampleScope.add(p.sampleCopy());
					 }
		 }
	 }

	 public List<Particle> getParticle() {
		 if (this.particle == null) {
			 this.particle = new ArrayList<Particle>();
		 }
		 return this.particle;
	 }

	 /**
		* This set is a subset of the whole list. Its particles for the current state are initially part of the complete list and will be clonned for each state in the sample.
		*
		*/

	 public Set<Particle> getSampleParticle() {
		 if (this.sampleParticle == null) {
			 this.sampleParticle = new HashSet<Particle>();
		 }
		 return this.sampleParticle;
	 }

	 public void Init(){
		 // Rename GLOBAL variables
		 int    Nc   = InputData.Nc;
		 double mass = InputData.mass;
		 double ro   = InputData.ro;
		 //L = Nc * (4*mass/ro)^(1/3);
		 L = Nc* InputData.sigma * Math.pow((4*mass/ro), (1.0/3.0));
		 //total number of particles to create
		 numParticles = 4 * Nc * Nc * Nc;
		 Particle[] p = new Particle[numParticles];
		 //initialize the energy values
		 energy = new EnergyValue();
		 // Calculate the side of the unit cell (cell vector of unity size)
		 cell = L / Nc;  // L = 1
		 // Build the Unit Cell
		 // Sublattice A
		 p[0] = new Particle().initialize();
		 p[0].x.x = 0.0;
		 p[0].x.y = 0.0;
		 p[0].x.z = 0.0;
			 // Sublattice B
			 p[1] = new Particle().initialize();
		 p[1].x.x = cell/2;
		 p[1].x.y = cell/2;
		 p[1].x.z = 0.0;
			 // Sublattice C
			 p[2] = new Particle().initialize();
		 p[2].x.x = 0.0;
		 p[2].x.y = cell/2;
		 p[2].x.z = cell/2;
		 // Sublattice D
		 p[3] = new Particle().initialize();
		 p[3].x.x = cell/2;;
		 p[3].x.y = 0.0;
		 p[3].x.z = cell/2;;
		 // Construct de lattice from the unit cell
		 int m = 0;
		 for (int iz = 0; iz < Nc; iz++)
		 {
			 for (int iy = 0; iy < Nc; iy++)
			 {
				 for (int ix = 0; ix < Nc; ix++)
				 {
					 if (m > 0)
					 {
						 for (int iref = 0; iref < 4; iref++)
						 {
							 p[iref+m] = new Particle().initialize();
							 p[iref+m].x.x = p[iref].x.x + cell * ix;
							 p[iref+m].x.y = p[iref].x.y + cell * iy;
							 p[iref+m].x.z = p[iref].x.z + cell * iz;
						 }
					 }
					 m += 4;
				 }
			 }
		 }
		 // Shift centre of box to the origin 
		 for (int i = 0; i < numParticles; i++)
		 {
			 p[i].x.x -= 0.5*L;
			 p[i].x.y -= 0.5*L;
			 p[i].x.z -= 0.5*L;
			 System.out.println("(" + p[i].x.x + "," + p[i].x.y + "," + p[i].x.z + ")");
		 }
		 /*Calculamos las velocidades iniciales que siguen una distribución normal */
		 double rtemp=Math.sqrt(InputData.T); //la T es la reducida, mirar cómo nos la pasan en InputData
		 for (int i=0; i<numParticles; i++){
			 p[i].v.x=rtemp*gauss();
			 p[i].v.y=rtemp*gauss();
			 p[i].v.z=rtemp*gauss();
		 }
		 // Se divide el momento neto entre N y se resta a cada particula (La supercell no se mueve)     
		 double sumx=0.0, sumy=0.0, sumz=0.0;
		 for (int i=0; i<numParticles; i++) { //momento neto en cada eje
			 sumx += p[i].v.x;
			 sumy += p[i].v.y;
			 sumz += p[i].v.z;
		 }
		 //se divide el momento neto entre N
		 sumx /= numParticles;
		 sumy /= numParticles;
		 sumz /= numParticles;
		 for (int i=0; i<numParticles; i++) { //se resta a cada momento de cada particula el valor calculado antes para que el momento neto sea 0
			 p[i].v.x -= sumx;
			 p[i].v.y -= sumy;
			 p[i].v.z -= sumz;
		 }

		 //Verification of calculus resolution
		 sumx = sumy = sumz = 0.0;
		 for (int i=0; i<numParticles; i++) { //momento neto en cada eje
			 sumx += p[i].v.x;
			 sumy += p[i].v.y;
			 sumz += p[i].v.z;
			 System.out.println("(v.x= " + p[i].v.x + " , v.y= " + p[i].v.y + " , v.z= " + p[i].v.z + " )");
		 }
		 System.out.println("(sumx= " + sumx + " , sumy= " + sumy + " , sumz= " + sumz + " )");
		 // Save the particles created in the array into the particles list
		 this.getParticle();   // <-- this creates the list of particles
		 for (int i = 0; i < numParticles; i++)
		 {
			 this.particle.add(p[i]);
		 }
		 //get the sample of particle for the video
		 //initialize sampleParticle
		 this.getSampleParticle();
		 //The index of a cell in terms of its coordinates follows the formula: 
		 //     index = x + Nc*y + (Nc*Nc)*z
		 //int centralCellIndex = ((Nc+1)*Nc+1)*Nc/2;  // equivalent to: Nc/2 + Nc*Nc/2 + Nc*Nc*Nc/2 
		 //the cells for the sample movie are those in the cube half of ConfigData.sampleCells around the centralCell 
		 //lets calculate the indexes range for those cells and then include their corresponding cell particles
		 int start = Nc/2 - ConfigData.sampleCells/2;
		 start = (start<0)?0:start;
		 int end  = start + ConfigData.sampleCells;
		 end = (end>Nc)?Nc:end;
		 for (int z = start; z < end; z++){
			 for (int y = start; y < end; y++){
				 for (int x = start; x < end; x++){
					 int index = x + Nc*y + (Nc*Nc)*z;
					 //System.out.println(index);
					 for (int i=0; i<4; i++){
						 this.sampleParticle.add(this.particle.get(index+i));
					 }
				 }
			 }
		 }
		 //initialize sampleScope
		 this.getSampleScope();
	 }

	 static private double ranf() { //devuelve un valor aleatorio entre 0 y 1
		 int l, c, m;
		 l=1029; //a lo mejor hay que cambiarlos para java
		 c=221591;
		 m=1048576;
		 seed = (seed*l+c)%m;
		 return (double)seed/m;
	 }

	 static private double gauss() {
		 double a1, a3, a5, a7, a9;
		 a1=3.949846138;
		 a3=0.252408784;
		 a5=0.076542912;
		 a7=0.008355968;
		 a9=0.029899776;
		 double sum, r, r2;
		 sum=0;
		 for (int i=0; i<12; i++) {
			 sum+=ranf();
		 }
		 r=(sum-6.0)/4.0;
		 r2=r*r;
		 return ((((a9*r2+a7)*r2+a5)*r2+a3)*r2+a1)*r;
	 }

		 //static boolean doitonce= true;
		 public void calculateNeighbourList(){
			 Particle par_i;
			 double rxi=0; //the coordinates for particle i
			 double ryi=0;
			 double rzi=0;
			 double rxij=0; //difference in position between particle i and j
			 double ryij=0;
			 double rzij=0;
			 double rijsq=0; //square of the difference in positions
			 double rcsqr=InputData.sigma*InputData.sigma*(ConfigData.rd+ConfigData.rC)*(ConfigData.rd+ConfigData.rC);    
			 //System.out.println("neighbour list calculation...."+ ++numberReCalculateNeighbourList);
			 //reset displacement
			 max_displacement = 0.0;
			 for (int i=0;i<this.particle.size()-1;i++) { //size-1 because the last particle has no vicinity
				 par_i = this.particle.get(i);
				 // remove elements from former neighbour lists (and creates the set if not created)
				 par_i.getVecinity().clear();

				 rxi=par_i.x.x;
				 ryi=par_i.x.y;
				 rzi=par_i.x.z;

				 //it'll go through all particles except those already checked (starts in i+1)
				 for (int j=i+1; j<this.particle.size(); j++) {  

					 //it gets the differences between the coordinates of i particle and j particle
					 rxij=rxi-particle.get(j).x.x;
					 ryij=ryi-particle.get(j).x.y; 
					 rzij=rzi-particle.get(j).x.z;

					 //boundary conditions, it will substract round quantity times the box length.
					 rxij=rxij-L*(double)Math.round(rxij/L);
					 ryij=ryij-L*(double)Math.round(ryij/L);
					 rzij=rzij-L*(double)Math.round(rzij/L);

					 rijsq=rxij*rxij + ryij*ryij + rzij*rzij; //square of the distance

					 if (rijsq < rcsqr) { //it does not include itself
						 //it adds the particle j to the vecinity list of particle i.
						 par_i.getVecinity().add(particle.get(j)); 
					 }
				 }
				 //if (doitonce){System.out.println("number of neighbours for particle ("+i+") is: "+ this.particle.get(i).getVecinity().size());}

			 }
			 //doitonce=false;
		 }


		 public State takeSample (){
			 State copy =  new State(); 
			 copy.sampleScope    = null;
			 copy.particle       = null;
			 copy.sampleParticle = null;

			 //initializes the set sampleParticle
			 copy.getSampleParticle();
			 //copy all the particles in the sample
			 for (Particle p: sampleParticle){
				 copy.sampleParticle.add(p.sampleCopy());
			 }

			 //this.takeSampleInScope();   //   <-- this should be called from the simulate function before calling this method

			 if (!this.getSampleScope().isEmpty()){

				 //initializes the set sampleScope
				 copy.getSampleScope();
				 //copy all the particles in the sampleScope set (some may be repeated in the sampleParticle list)
				 for (Particle p: sampleScope){
					 copy.sampleScope.add(p.sampleCopy());
				 } 
			 }

			 return copy;        
		 }

		 private double bind (double x){
			 double L_2=L/2;
			 if (x>L_2) {
				 x=x-L;
			 } else if (x<-L_2) {
				 x=x+L;
			 }
			 return x;
		 }

		 public void nextStep(LennarJones f) {
			 double dT=InputData.deltaT;
			 double tx;
			 double ty;
			 double tz;
			 double k=0.0;

			 //Here we calculate the new positions and the velocities in a half step
			 for (Particle p:particle) {
				 //Temporal variable
				 tx=p.v.x*dT+(1.0/2.0)*p.a.x*dT*dT;
				 ty=p.v.y*dT+(1.0/2.0)*p.a.y*dT*dT;
				 tz=p.v.z*dT+(1.0/2.0)*p.a.z*dT*dT;

				 //We calculate the displacement
				 double displacement=Math.sqrt(tx*tx+ty*ty+tz*tz);
				 if(max_displacement<displacement) {
					 max_displacement=displacement;
				 }
				 //Update the positions of the particle
				 p.x.x=p.x.x+tx;
				 p.x.y=p.x.y+ty;
				 p.x.z=p.x.z+tz;

				 //We calculate the velocities in a half step
				 p.v.x=p.v.x+(1.0/2.0)*p.a.x*dT;
				 p.v.y=p.v.y+(1.0/2.0)*p.a.y*dT;
				 p.v.z=p.v.z+(1.0/2.0)*p.a.z*dT;
			 }
			 //Invoque the method to update the acceleration
			 lennarJonesForcesAndU(f);
			 //Now we calculate the velocities in the complete step and the kinetic energy
			 for (Particle p:particle) {
				 p.v.x=p.v.x+(1.0/2.0)*p.a.x*dT;
				 p.v.y=p.v.y+(1.0/2.0)*p.a.y*dT;
				 p.v.z=p.v.z+(1.0/2.0)*p.a.z*dT;

				 //Make the sum of the kinetic energy
				 k=k+(InputData.mass/2.0)*(p.v.x*p.v.x+p.v.y*p.v.y+p.v.z*p.v.z);
			 }
			 //Store the value of the energy
			 energy.K=k/numParticles;
		 }



		 /* This method calculates the acelerations and the potential energy. It is used at the beginning for the initializtion of accelerations and later in each step. */
		 public void lennarJonesForcesAndU(LennarJones f) {
			 double u=0;
			 double sigma=InputData.sigma;
			 double fourepsilon=4.0*InputData.epsilon;
			 double rc=sigma*ConfigData.rC;
			 double m=InputData.mass;
			 double src=sigma/rc;
			 double src2=src*src;
			 double src6=src2*src2*src2;
			 //Potential at the cut off radious
			 double vc=fourepsilon*(src6*src6-src6);
			 //Derivative of the potential at the cut off radious
			 double vr_discontinuity=6.0*fourepsilon/rc*(2.0*src6*src6-src6);
			 double distx;
			 double disty;
			 double distz;
			 double distx2;
			 double disty2;
			 double distz2;
			 double distr;
			 double distr2;
			 double sr2;
			 double sr6;
			 double fr=0.0;
			 double frij=0.0;
			 double v=0.0; //
			 double vij;
			 double fx;
			 double fy;
			 double fz;
			 double counts=0;
			 for (Particle p:particle)p.a.x=p.a.y=p.a.z=0.0;
			 boolean onlyfirstparticle = true;
			 for (Particle p:particle) {
				 for (Particle q:p.getVecinity()) {
					 //We calculate the components of the distance between a pair of particles and the square of the values
					 distx=p.x.x-q.x.x;
					 disty=p.x.y-q.x.y;
					 distz=p.x.z-q.x.z;

					 //boundary conditions, it will substract round quantity times the box length.
					 distx=distx-L*(double)Math.round(distx/L);
					 disty=disty-L*(double)Math.round(disty/L);
					 distz=distz-L*(double)Math.round(distz/L);

					 distx2=distx*distx;
					 disty2=disty*disty;
					 distz2=distz*distz;

					 //We calculate the distance and the square of it
					 distr2=distx2+disty2+distz2;
					 distr=Math.sqrt(distr2);

					 //Not all of the particles in the vecinity list are in a distance less or iqual to rc but, if I do the condition, most of the U values are zero.
					 //if(distr<=rc) {
					 sr2=sigma*sigma/distr2;
					 sr6=sr2*sr2*sr2;

					 vij=fourepsilon*(sr6*sr6-sr6);

					 if (onlyfirstparticle) f.register(distr, vij);

					 v+=vij; //cumulative potential
					 //System.out.print(vij+"  ");
					 //frij = 6.0*fourepsilon*(2.0*sr6*sr6-sr6)-vr_discontinuity/distr2;
					 frij = 6.0*fourepsilon*(2.0*sr6*sr6-sr6);
					 fr=frij/distr2;
					 fx=fr*distx;
					 fy=fr*disty;
					 fz=fr*distz;
					 p.a.x+=fx/m;
					 p.a.y+=fy/m;
					 p.a.z+=fz/m;
					 q.a.x-=fx/m;
					 q.a.y-=fy/m;
					 q.a.z-=fz/m;
					 counts++;
					 u = v + vr_discontinuity*(distr-rc);
					 //}  //end-if(distr<=rc)
				 }
				 onlyfirstparticle = false;
			 }
			 energy.U = (v - vc*counts)/numParticles;
		 }
	 }
