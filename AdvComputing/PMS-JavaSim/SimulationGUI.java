package src;


import java.io.*;
public class SimulationGUI {

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
    public static double sampleDuration;
    public static double rC;
    public static double rd;
    public static double sampleCells;

    public static void main (String[] args) {

        InputData data = new InputData();
        boolean buleano = data.readFile("InputDataTesting.txt");
        sampleStart = data.sampleStart;
        simId = data.simId;
        epsilon = data.epsilon;
        sigma = data.sigma;
        ro = data.ro;
        mass = data.mass;
        atomicNum =  data.atomicNum;
        T = data.T;
        Nc = data.Nc;
        deltaT = data.deltaT;
        totalTime = data.totalTime;
        boolean configOK = false;
        boolean todoOk = false;
        ConfigData config = new ConfigData();

        while (!todoOk){
            sampleDuration = 0;
            rC = 0.0;
            rd = 0.0;
            sampleCells = 0;
            configOK = false;
            config = new ConfigData();
            configOK = config.readFile("ConfigurationFile.txt");
            sampleDuration = config.sampleDuration;
            rC = config.rC;
            rd = config.rd;
            sampleCells = config.sampleCells;

            Menu menu = new Menu("Particle Motion Simulator Menu");
            int op;
            if (configOK){ // Only allows to run the simulation if configData was read OK
                menu.insertaOpcion("Input new values for the Simulation",1);
                if (buleano){
                    menu.insertaOpcion("Use previous values for the simulation",2);
                    // Option only visible if data file is rises no errors
                }
                menu.insertaOpcion("See configuration values(empty)",3);
            }
            menu.insertaOpcion("Change configuration values(empty)",4); // Always visible
            op = menu.leeOpcion("Elige una opcion");

            menu.cierra();

            if (op == 1){ //Change input values

                Lectura lee = new Lectura ("PMS - Input Data");

                // Read values
                lee.creaEntrada("Sample Start (percentage of total simulation time)",sampleStart);
                lee.creaEntrada("Simulation Name/Identifier",simId);
                lee.creaEntrada("Epsilon value (use 1 for reduced units)",epsilon);
                lee.creaEntrada("Sigma value (use 1 for reduced units)",sigma);
                lee.creaEntrada("Density of the material (in XXXXX per XXXXXXX)",ro);
                lee.creaEntrada("Mass of the particles (in XXXXXXXXXX)",mass);
                lee.creaEntrada("Atomic number of the particles to simulate",atomicNum);
                lee.creaEntrada("Temperature of the material (in Kelvin)",T);
                lee.creaEntrada("Number of units cells to simulate along each axis",Nc);
                lee.creaEntrada("Time elapsed between iterations (in XXXXXXXX)",deltaT);
                lee.creaEntrada("Total time to simulate (in XXXXXXX)",totalTime);
                lee.esperaYCierra("Input the values and press Aceptar");

                // Store read values
                sampleStart = lee.leeDouble("Sample Start (percentage of total simulation time)");
                simId = lee.leeString("Simulation Name/Identifier");
                epsilon = lee.leeDouble("Epsilon value (use 1 for reduced units)");
                sigma = lee.leeDouble("Sigma value (use 1 for reduced units)");
                ro = lee.leeDouble("Density of the material (in XXXXX per XXXXXXX)");
                mass = lee.leeDouble("Mass of the particles (in XXXXXXXXXX)");
                atomicNum = lee.leeInt("Atomic number of the particles to simulate");
                T = lee.leeDouble("Temperature of the material (in Kelvin)");
                Nc = lee.leeInt("Number of units cells to simulate along each axis");
                deltaT = lee.leeDouble("Time elapsed between iterations (in XXXXXXXX)");
                totalTime = lee.leeDouble("Total time to simulate (in XXXXXXX)");

                try{ // writes to input data file
                    PrintWriter writer = new PrintWriter("InputDataTesting.txt", "UTF-8");
                    writer.println("Data-> Sample Start: "+sampleStart+" % Percentage of the total simulation where the sample starts");
                    writer.println("Data-> Simulation Identificator: "+simId+" % Simulation name/identifier");
                    writer.println("Data-> Epsilon: "+epsilon+" % Value of the epsilon parameter");
                    writer.println("Data-> Sigma: "+sigma+" % Value of the sigma parameter");
                    writer.println("Data-> Density: "+ro+" % Density of the material");
                    writer.println("Data-> Mass: "+mass+" % Mass of each particle in the material");
                    writer.println("Data-> Atomic number: "+atomicNum+" % Atomic number of the particles in the material");
                    writer.println("Data-> Temperature: "+T+" % Temperature of the material (in Kelvin)");
                    writer.println("Data-> Number of unit cells: "+Nc+" % Number of unit cells to simulate along each axis");
                    writer.println("Data-> Time Step: "+deltaT+" % Time elapsed in each iteration");
                    writer.println("Data-> Total Time: "+totalTime+" % Total time that will be simulated");            
                    writer.close();

                    todoOk = true;
                }catch(FileNotFoundException a){
                    //report
                }catch(UnsupportedEncodingException b){
                    //report
                } // reads and stores new values

            }else if(op == 2){ // Goes on to PMS

                todoOk = true;

            }else if(op == 3){ // See configuration values

                Escritura esc = new Escritura("Configuration Data for PMS");

                esc.insertaValor("Sample Duration (iterations)",config.sampleDuration);
                esc.insertaValor("Cutoff radius (in sigmas)",config.rC);
                esc.insertaValor("Neighbour skin (in sigmas)",config.rd);
                esc.insertaValor("sampleCells (integer)",config.sampleCells);
                esc.espera();

            }else if(op ==  4){ // Change configuration values
                Lectura lee = new Lectura ("PMS - Configuration Data");
                // Read values
                lee.creaEntrada("Sample Duration (in number of iterations)",sampleDuration);
                lee.creaEntrada("Cutoff radius (in units of sigma)",rC);
                lee.creaEntrada("Difference between neighbour radius and cutoff radius (positive)",rd);
                lee.creaEntrada("Number of cells to sample along each axis",sampleCells);
                lee.esperaYCierra("Input the configuration values and press Aceptar");

                // Store read values
                sampleDuration = lee.leeDouble("Sample Duration (in number of iterations)");
                rC = lee.leeDouble("Cutoff radius (in units of sigma)");
                rd = lee.leeDouble("Difference between neighbour radius and cutoff radius (positive)");
                sampleCells = (int) lee.leeDouble("Number of cells to sample along each axis");

                try{ // writes to configuration data file
                    PrintWriter writer = new PrintWriter("ConfigurationFile.txt", "UTF-8");
                    writer.println("Data-> Sample Duration: "+sampleDuration+" % Duration is introduced in number of iterations/time steps");
                    writer.println("Data-> Cutoff radius: "+rC+" % Distance at which the Leonnard-Jonnes potential vanishes");
                    writer.println("Data-> Neighbour Skin: "+rd+" % Size of the Neighbouring ring to be add to the cut off radius");
                    writer.println("Data-> Sample Cells: "+sampleCells+" % Number of cells to be sample along each axis for XCrysDen 'movie'");
                    writer.close();
                }catch(FileNotFoundException a){
                    //report
                }catch(UnsupportedEncodingException b){
                    //report
                } // reads and stores new values
            }
        }
        String[] anyThing = new String[] {"InputDataTesting.txt"};
        PMS pms = new PMS();
        pms.main(anyThing);
    }
}
