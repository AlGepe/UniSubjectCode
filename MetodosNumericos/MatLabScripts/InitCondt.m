%Molecular initializer for MolecularSimul.m

function material = InitCondt(rhoStar, TStar,bigSize, somethingStar)
%preMaterial reduced units impose that
sigma = 1;
epsilon = 1;

%Now we initialize the particle position matrix
material = zeros(3,bigSize);
%we convert from reduced density to lattice parameter
a = sigma*(4/rhoStar)^(1/3);
%and obtain the needed standard deviation from reduced Temperature
TkB = epsilon*TStar;
devstd = sqrt(TkB);
%with the latter value we store the values for the speed of the molecules
%we do that by using matlab's normally distributed pseudorandom numbers...
%...generator RANDN with the "width" we've computed
vX = devstd*randn(bigSize);
vY = devstd*randn(bigSize);
vZ = devstd*randn(bigSize);

%NOTE that as RANDN is "random" we are save to use the same function for...
%...the different components as we'll get differnt values.

%Now that constants are set-up we begin to initialized every molecule...
%...with it's corresponding initial condition values


%DO WE NEED TO RUN OVER ALL THE PARTICLES??

i = 1; %matrix indexer

while x<= Nc*a %going along the X coordinate
  y = 0;
  while y<=Nc*a
    z = 0;
    while z<=Nc*a
      

      %initialize 4 particles (1 unit cell)
      z += a;
    end
    y += a;
  end
  x += a;
end















%Outter loop for initializing X component
for i=1:Nc
    %Middle loop for initializing Y component
    for j=1:Nc
        %Inner loop for initializing Z component
        for k=1:Nc
           %Xcomponent
         
           %Ycomponent
           
           %Zcomponent
           
           %we also use this loop to set the initial velocities
           %Note that velocities follow a normal distribution
           material(i,j,k,);
           
        end %Z
    end %Y
end %X

           
        