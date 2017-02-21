package src;

//import java.util.*;
import java.io.*;
import java.nio.file.*;

public class ConfigData{
    public static int sampleDuration = 100;
    public static double rC = 2.5;
    public static double rd = 0.5;
    public static int sampleCells = 2;

    public static boolean readFile (String fileName) 
    {
        //starting value for now, will have to set it to false when the rest is up and running
        boolean hasBeenRead = false;
        //now we read the file and see if the values have to be changed
        try{
            File file = new File(fileName);

            String fullPath = file.getAbsolutePath();

            InputStream in = Files.newInputStream(Paths.get(fullPath));

            BufferedReader reader = new BufferedReader(new InputStreamReader(in));

            String line = null;

            boolean enterWhile = true; //this will keep the while as short as needed

                            int  i = 0;

            
            while (enterWhile && (line = reader.readLine()) != null) {
                //System.out.println(line.substring(0,6));
                try{
                    if (line.substring(0,6).equals("Data->")){

                        // find position of separators. We used : and %
                        // the +- 1 will become clear later
                        int initialPos = line.indexOf(':')+1; 
                        int finalPos = line.indexOf('%')-1;
                        // now we store a substring containing only the value
                        // the +-1 helps us get rid of the separators straight away
                        String value = line.substring(initialPos,finalPos);
                        // now we remove the unnecessary white spaces to avoid problems when converting to numbers
                        value = value.trim();
                        // now we convert one by one our read Strings to Integer or Double as
                        // needed depending on the variable they represent. This part requires ordering concordance
                        // to work properly; in particular we require that the ordering matches between this code 
                        // and the ConfigurationFile.
                        if (i == 0){

                            sampleDuration = (int) Double.parseDouble(value);
                            //System.out.println("Sample read: "+sampleDuration);
                            // checking sampleDuration is reasonably initialized
                            if(sampleDuration < 0 ){
                                System.out.println("Duration of the sample was input as negative. Please avoid negative sample duration ('sampleDuration')");
                                return false;
                            }

                        }else if(i == 1){

                            rC = Double.parseDouble(value);
                            //System.out.println("rC read: "+rC);
                            // checking rC is reasonably initialized
                            if(rC < 0 ){
                                System.out.println("Cut off radius was input as negative. Please avoid negative cut off radius ('rC')");
                                return false;
                            }

                        }else if(i == 2){

                            rd = Double.parseDouble(value);
                            //System.out.println("rd read: "+rd);

                            // checking rd is reasonably initialized
                            if(rd < 0 ){
                                System.out.println("Neighbours ring radius was input as negative. Please avoid negative neighbour radius ('rd')");
                                return false;
                            } 

                        }else if(i == 3){

                            sampleCells = (int) Double.parseDouble(value);
                            //System.out.println("Sample Cell read: "+sampleCells);

                            // checking sampleCells is reasonably initialized
                            if(sampleCells < 0 ){
                                System.out.println("Number of cells to sample was input as negative. Please avoid negative number of cells to sample ('sampleCells')");
                                return false;
                            }

                            // checking sampleCells is consistent with the rest of the values
                            if(sampleCells > InputData.Nc){

                                System.out.println("Sample cells exceeds the total number of cells. Sample of all the particles will be done in stead ('Nc')");
                                sampleCells = InputData.Nc;

                            }

                            //this boolean prevents the while to run longer than needed even if someone added a 
                            //lot of blank lines or very long comments afterwards
                            enterWhile = false;

                        }else{
                            System.out.println("Configuration data failed, wrong index for value set up");
                            hasBeenRead = false;
                            return hasBeenRead;
                        }
                        i++;
                    }
                }catch(StringIndexOutOfBoundsException a){

                }   
            }
            //After completing the value initialization we confirm that everything went OK
            hasBeenRead = true;
            return hasBeenRead;

        }catch(IOException e){
            System.out.println("Not read");
            hasBeenRead = false; //for ensuring the right value of the boolean
            return hasBeenRead;

        }
    }
}   