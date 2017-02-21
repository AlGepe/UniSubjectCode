package src;

import java.util.*;
import java.io.*;
import java.nio.file.*;

public class InputData{
    
    public static double sampleStart;
    public static String simId;
    public static double epsilon;
    public static double sigma;
    public static double ro;
    public static double mass;
    public static int atomicNum;
    public static double T;
    public static int Nc;
    public static double deltaT;
    public static double totalTime;
    public static boolean readFile (String fileName) 
    {
        //Dummy values appear only for testing purposes. Will be removed in the final version
        sampleStart = 0.5;
        simId = "PMS-testRun";
        epsilon = 1;
        sigma = 1;
        ro = -1;
        mass = -1;
        atomicNum = -1;
        T = 0;
        Nc = 1;
        deltaT = 0.2;
        totalTime = 10;

        //Actual code:

        //dummy value for now, will have to set it to false when the rest is up and running
        boolean hasBeenRead = false;
        //now we read the file and see if the values have to be changed
        try{

            File file = new File(fileName);

            String fullPath = file.getAbsolutePath();

            InputStream in = Files.newInputStream(Paths.get(fullPath));

            BufferedReader reader = new BufferedReader(new InputStreamReader(in));

            String line = null;

            boolean enterWhile = true;

            int i = 0;

            while (enterWhile && (line = reader.readLine()) != null) {
                try{
                    //System.out.println("Read: "+line.substring(0,6));
                    if (line.substring(0,6).equals("Data->")) {

                        // find position of separators. We used : and %
                        // the +- 1 will become clear later
                        int initialPos = (line.indexOf(':'))+1; 
                        int finalPos = (line.indexOf('%'))-1;
                        // now we store a substring containing only the value
                        // the +-1 helps us get rid of the separators straight away
                        String value = line.substring(initialPos,finalPos);
                        // now we remove the unnecessary white spaces to avoid problems when converting to numbers
                        value = value.trim();
                        // now we convert to numerical values and store in an array of numbers
                        // we opt to convert everything to double to have just one list because we can easily
                        // go from double to integer but not the other way arround
                        if (i == 0){

                            sampleStart = Double.parseDouble(value);

                            // checking sampleStart is reasonably initialized
                            if(sampleStart < 0 ){
                                System.out.println("Start of sample was input as negative. Please avoid negative sample start ('sampleStart')");
                                return false;
                            }

                        }else if(i == 1){

                            simId = value;

                        }else if(i == 2){

                            epsilon = Double.parseDouble(value);

                        }else if(i == 3){

                            sigma = Double.parseDouble(value);

                        }else if(i == 4){

                            ro = Double.parseDouble(value);

                            // checking ro is reasonably initialized
                            if(ro < 0 ){
                                System.out.println("Density was input as negative. Please avoid negative density ('ro')");
                                return false;
                            }

                        }else if(i == 5){

                            mass = Double.parseDouble(value);

                            // checking mass is reasonably initialized
                            if(mass < 0 ){
                                System.out.println("Mass was input as negative. Please avoid negative mass ('mass')");
                                return false;
                            }

                        }else if(i == 6){

                            atomicNum = Integer.parseInt(value);

                            // checking mass is reasonably initialized
                            if(atomicNum < 0 ){
                                System.out.println("Atomic Number was input as negative. Please avoid negative atomic number");
                                return false;
                            }

                        }else if(i == 7){

                            T = Double.parseDouble(value);

                            // cheking T is reasonably initialized
                            if(T < 0){
                                System.out.println("Negative temperatures are not allowed. Please input temperature ('T') in Kelvin");
                                return false;
                            }

                        }else if(i == 8){

                            Nc = Integer.parseInt(value);

                            // checking Nc is reasonably initialized
                            if(Nc < 0 ){
                                System.out.println("'Nc' was input as negative. Please avoid negative number of cells ('Nc')");
                                return false;
                            }

                        }else if(i == 9){

                            deltaT = Double.parseDouble(value);

                            // checking deltaT is reasonably initialized
                            if(deltaT < 0 ){
                                System.out.println("Time step was input as negative. Please avoid negative time step ('deltaT')");
                                return false;
                            }

                        }else if(i == 10){

                            totalTime = Double.parseDouble(value);

                            // we check that totalTime is reasonable consistent with the rest of the values.
                            if(totalTime < 0){
                                System.out.println("Simulation time was input as negative. Please avoid negative simulation times ('totalTime')");
                                return false;
                            }
                            if(deltaT > totalTime){
                                System.out.println("Time step is bigger than total time of simulation. Simulation will not run.");
                                return false;
                            }
                            enterWhile = false;

                        }else{

                            System.out.println("Input data failed, wrong index for value set up");
                            return false;

                        }
                    }
                }catch(StringIndexOutOfBoundsException a){

                }
                i++;
            }

            //After completing the value initializartion we confirm that everything went OK
            hasBeenRead = true;

            return hasBeenRead;

        }catch(IOException e){

            return false;

        }
    }
}
