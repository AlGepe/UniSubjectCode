package src;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.ArrayList;

public class PMS {
    public static String configFile = "ConfigurationFile.txt";
    public static String dataFile;
    public static int nSteps;
    public static int step;
    /**
     * <pre>
     *           0..1     0..*
     * PMS ------------------------> EnergyValue
     *           pMS        &gt;       energyValue
     * </pre>
     */
    private static List<EnergyValue> energyValue;

    public static List<EnergyValue> getEnergyValue() {
        if (energyValue == null) {
            energyValue = new ArrayList<EnergyValue>();
        }
        return energyValue;
    }

    /**
     * <pre>
     *           0..1     1..1
     * PMS ------------------------> State
     *           pMS        &gt;       currentState
     * </pre>
     */
    private static State currentState;

    public void setCurrentState(State value) {
        currentState = value;
    }

    public State getCurrentState() {
        return currentState;
    }

    /**
     * <pre>
     *           0..*     0..*
     * PMS ------------------------> State
     *           pMS        &gt;       sample
     * </pre>
     */
    private static List<State> sample;

    public List<State> getSample() {
        if (sample == null) {
            sample = new ArrayList<State>();
        }
        return  sample;
    }

    static LennarJones f = new LennarJones();

    public static void main(String[] args) {
        //Set the input data file name and the number and length of the time steps
        //J     dataFile=fileName;
        dataFile=args[0];

        //Read the files and check that the reading is correct.
        if (read()){  // If the reading is correct, we continue with the simulation
            //We create the current state
            currentState = new State();
            //Initialize the positions and velocities of particles (and accelerations)
            currentState.Init();

            if (State.getL()<6*InputData.sigma) {
                System.out.println("The program stopped because the system size was too small. \n The system size must be equal or larger than 6 times sigma. \n Please increase the number of cells.");
                System.exit(1);
            }

            //and we calculatea all neighbour lists
            currentState.calculateNeighbourList();

            //We proceed with the simulation
            nSteps= (int) (Math.floor(InputData.totalTime/InputData.deltaT))+1;
            step=0;
            energyValue = new ArrayList<EnergyValue>(nSteps);  // <--initialize the list of energy values
            sample = new ArrayList<State>(ConfigData.sampleDuration);
            simulate();

            //Finally we write the results in the output file
            writeOut();

            System.out.println("The program was run correctly.");

        } else {
            //Otherwise we write that an error ocurred
            System.out.println("The input file "+dataFile+" could not be read, so the program stopped.");
        }
    }

    public static boolean read () 
    {
        //First we read the input data and check that everything went right.
        boolean input=InputData.readFile(dataFile);
        if (input==false){
            System.out.println("The input data was not writen and/or read correctly, so the program stopped.");
            System.exit(1);
        }

        //Then we read the configuration data and check that everything went right.
        boolean config=ConfigData.readFile(configFile);
        if (config==false){
            System.out.println("The configuration data was not writen and/or read correctly, so the program stopped.");
            System.exit(1);
        }

        //If everything went righ, we return true for the main program to leep running.
        return true;
    }

    public static void simulate () 
    {
        double displacement=0.0; //We fix the current largest displacement at 0.
        int sampleStartIndex=(int) Math.floor(InputData.sampleStart*nSteps);
        int sampleEndIndex=ConfigData.sampleDuration+sampleStartIndex;
        //sampleEndIndex=(sampleEndIndex>nSteps)?nSteps:sampleEndIndex;
        if (sampleEndIndex>nSteps) {
            sampleEndIndex=nSteps;
        }

        for(int i=0; i<nSteps-1; i++) {
            //We simulate a time step for the current state.
            currentState.nextStep(f);
            //System.out.println(" " + (i+1) +"   "+ currentState.getEnergy().K + "   " +currentState.getEnergy().U  );

            //Check if a sample for the movie needs to be taken and, if so, take the sample
            if (i>=sampleStartIndex && i<=sampleEndIndex) {
                //get the sample of particles in the visualization scope
                currentState.getSampleScope();
                //We add the state to the list of samples
                sample.add(currentState.takeSample());
            }

            //Add the energy values to the energy values list
            EnergyValue energy=new EnergyValue();
            energy.K=currentState.getEnergy().K;
            energy.U=currentState.getEnergy().U;
            energyValue.add(energy);

            displacement=displacement+currentState.getMax_displacement();
            //Check if a recalculation of neighbours needs to be done and, if so, recalculate the neighbour list
            if (displacement>= ConfigData.rd*InputData.sigma) {
                currentState.calculateNeighbourList();
                displacement=0;
            }
        }
    }

    public static void writeOut (){

        List<EnergyValue> energyV = energyValue;
        //int Z = InputData.atomicNum;
        List<State> lista = sample;

        PrintWriter out_sim = null;
        PrintWriter outScope = null;
        PrintWriter out_file = null;

        try {

            out_sim  = new PrintWriter( new FileWriter( "OutPut.xsf" ));
            outScope = new PrintWriter( new FileWriter( "OutScope.xsf" ));
            out_file = new PrintWriter (new FileWriter( "Output.txt" ));

            //Escribimos el fichero para Xcrysden
            out_sim.println( "ANIMSTEPS" +" "+ nSteps );
            int k=1;
            for (State s: lista) {

                out_sim.println("ATOMS "+ k);//1 =i
                k++;
                for (Particle p: s.getSampleParticle()){
                    // out_sim.printf ( "    %d %f %f %f %n", 0, p.x.x, p.x.y, p.x.z );
                    out_sim.println ( " 0 \t" + p.x.x + "\t"+ p.x.y + "\t"+ p.x.z +
                        "\t" + p.v.x + "\t"+ p.v.y + "\t"+ p.v.z);
                }

            }
            //Escribimos el fichero para Xcrysden(Scope)
            outScope.println( "ANIMSTEPS" +" "+ nSteps );
            int j=1;
            for (State s: lista) {

                outScope.println("ATOMS "+ j);//1 =i
                j++;
                for (Particle p: s.getSampleScope()){
                    //                    	 outScope.printf ( "    %d %f %f %f %n", 0, p.x.x, p.x.y, p.x.z );
                    outScope.println ( " 0 \t" + p.x.x + "\t"+ p.x.y + "\t"+ p.x.z );
                }

            }

            	
            	
            /*
            double a = Math.pow((4*InputData.mass/InputData.ro), (1.0/3.0));
                
            //Escribimos el fichero para Xcrysden
            out_sim.println( "ANIMSTEPS" + nSteps );
            out_sim.println("CRYSTAL"); 
            out_sim.println("PRIMVEC");
            out_sim.printf("    %10.8f %10.8f %10.8f %n", 0.0,a/2.0,a/2.0); // Las unidades tienen que ser Angstroms en el caso de posiciones
            out_sim.printf("    %10.8f %10.8f %10.8f %n", a/2.0,a/2.0,0.0); 
            out_sim.printf("    %10.8f %10.8f %10.8f %n", a/2.0,0.0,a/2.0);
            for (State s: lista) {

            out_sim.println("PRIMCORD "+ 1);//1 =i
            out_sim.println( 2 +" "+ 1);///Numero de atomos en la celda //nat
            for (Particle p: s.getSampleParticle()){
            out_sim.printf ( "    %d %f %f %f %n", Z, p.x.x, p.x.y, p.x.z );
            }

            }
            //Escribimos el fichero para Xcrysden (Scope)
            outScope.println( "ANIMSTEPS" + nSteps );
            outScope.println("CRYSTAL"); 
            outScope.println("PRIMVEC");
            outScope.printf("    %10.8f %10.8f %10.8f %n", 0.0,a/2.0,a/2.0); // Las unidades tienen que ser Angstroms en el caso de posiciones
            outScope.printf("    %10.8f %10.8f %10.8f %n", a/2.0,a/2.0,0.0); 
            outScope.printf("    %10.8f %10.8f %10.8f %n", a/2.0,0.0,a/2.0);
            for (State s: lista) {

            outScope.println("PRIMCORD "+ 1);//1 =i
            outScope.println( 2 +" "+ 1);///Numero de atomos en la celda //nat
            for (Particle p: s.getSampleScope()){
            outScope.printf ( "    %d %f %f %f %n", Z, p.x.x, p.x.y, p.x.z );
            }

            }*/
            ////////////////////////////////////////////////////////////////////

            //Fichero con las energias 
            //out_file.println("Atomic Number "+ Z);
            //out_file.println(" i  \t K  \t U  \t  T " );
            for (int i = 0; i < energyV.size(); i++) {
                //                    out_file.println("Step: " +i);
                //                    out_file.println("Kinetic Energy: "+ energyV.get(i).K);
                //                    out_file.println("Potential Energy: "+ energyV.get(i).U);
                //                    out_file.println("Total Energy: "+ energyV.get(i).K + energyV.get(i).U );   
                System.out.println(" " + (i+1) +"   "+ energyV.get(i).K + "   " +energyV.get(i).U + "    " + (energyV.get(i).K + energyV.get(i).U) );
                //out_file.println(" " + (i+1) +"  \t "+ energyV.get(i).K + "  \t " +energyV.get(i).U + "  \t  " + (energyV.get(i).K + energyV.get(i).U) );

                	
            }
            for (int i = 0; i < energyV.size(); i++) {
                //                  out_file.println("Step: " +i);
                //                  out_file.println("Kinetic Energy: "+ energyV.get(i).K);
                //                  out_file.println("Potential Energy: "+ energyV.get(i).U);
                //                  out_file.println("Total Energy: "+ energyV.get(i).K + energyV.get(i).U );   
                //System.out.println(" " + (i+1) +"   "+ energyV.get(i).K + "   " +energyV.get(i).U + "    " + (energyV.get(i).K + energyV.get(i).U) );
                out_file.println(" " + (i+1) +"  \t "+ energyV.get(i).K + "  \t " +energyV.get(i).U + "  \t  " + (energyV.get(i).K + energyV.get(i).U) );

            }
            out_file.close();

            f.print("lennarJones.txt");
        } catch (IOException ex) {

        } 
    }
}


