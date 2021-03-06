// Features pseudo-Gaussian distribution and use of trace function
// Scene concept and collision algorithm by Greg M. Johnson 2001
// Textures by Gilles Tran
// ------------------------------
// This file creates piles of cubes
// The cubes are generated using a collision detection algorithm
// and the cubes rotations and positions are written to a file called "stacks.inc"
// If you want to run the script a second time without re-generating this file (and thus save on parsing time)
// just uncomment the #declare WriteFile=false line below
// ------------------------------
// THIS SCENE USES RADIOSITY
// ------------------------------
// Stats on a PIII 733 @ 640*480, default antialiasing
// Parsing time with WriteFile=true : 1 min
// Tracing time : > 1 hour
// Peak memory : > 100 Mb
// ------------------------------
//
// -w320 -h240
// -w800 -h600 +a0.3

#declare WriteFile=true;  // turns on the generation of the stacks and write them to a file
// ------------------------------
// choose a number of cubes (has no effect unless WriteFile=True)
// large n values give long parsing time
#declare num=100;
//#declare num=100; 
//#declare num=10; 
//#declare num=5;     
// ------------------------------

// ------------------------------
#include "colors.inc"

// ------------------------------
// Set settings : radiosity only
// ------------------------------
global_settings{
    radiosity{
        pretrace_start 1
        pretrace_end 1
        count 1000
        recursion_limit 1
        nearest_count 5
        error_bound 0.05
    }
}

#default {finish { ambient 0 diffuse 1 }}

#declare CamLoc=<-0.5,3.5,-18>; 
#declare CamEye=<-1.5,0.3,-10>;
#declare CamSky=y;
#declare AspectRatio=4/3;
#declare CamZoom=1;

camera {
   location CamLoc
   direction z*CamZoom
   right x*AspectRatio
   look_at CamEye
   focal_point < -1.5, 0.3, -11>
   aperture 0.2
   blur_samples 200
   confidence 0.9
   variance 0.0001
}

sky_sphere{  // white sky sphere with a blue far end
    pigment{
        gradient z
        poly_wave 2
        color_map{
            [0  White*1.5]            
            [1 rgb <116,138,176>/255]            
        }
        scale 2
        translate -z
    }
}                         


plane{y,0 texture{pigment{White} finish{ambient 0 diffuse 1}}} 
plane{y,0 rotate x*-20 texture{pigment{White} finish{ambient 0 diffuse 1}} translate z*10000} 

// ------------------------------
// centers the text
// ------------------------------
#macro centertext(Text)
        #local MinText=min_extent(Text);
        #local MaxText=max_extent(Text);
        translate -(MinText+(MaxText-MinText)/2)
#end

// ------------------------------
// creates the cube
// ------------------------------
#macro unitbox()
#local COL=<rand(rd),rand(rd),rand(rd)>;
union{
    difference{
        box{<-0.5,-0.5,-0.5>,<0.5,0.5,0.5>}
        box{<-0.45,-0.45,-1>,<0.45,0.45,1>}
        box{<-1,-0.45,-0.45>,<1,0.45,0.45>}
        box{<-0.45,-1,-0.45>,<0.45,1,0.45>}
        txtBox(COL)
    }                
    box{-0.45,0.45 texture{pigment{White*1.4}}}                                
    #declare Font="cyrvetic"
    #declare sFont=<0.76,0.76,0.05>;
    #local T=text { ttf Font "T" 1, 0 scale sFont}
    #local E=text { ttf Font "E" 1, 0 scale sFont}
    #local C=text { ttf Font "C" 1, 0 scale sFont}
    #local H=text { ttf Font "H" 1, 0 scale sFont}
    #local O=text { ttf Font "O" 1, 0 scale sFont}
    #local N=text { ttf Font "N" 1, 0 scale sFont}
    union{
        object{T centertext(T) translate -0.5*z rotate y*90 txtBox(COL)}
        object{E centertext(E) translate -0.5*z  txtBox(COL)}                        
        object{C centertext(C) translate -0.5*z rotate -90*y txtBox(COL)}   
        object{H centertext(H) translate -0.5*z rotate 180*y txtBox(COL)}                   
        object{O centertext(O) translate -0.5*z rotate 90*x txtBox(COL)}  
        object{N centertext(N) translate -0.5*z rotate -90*x txtBox(COL)}  
    }
}
#end

// ------------------------------
// cube texture
// ------------------------------
#declare rd=seed(0); // color random stream
#declare sc1=0.5;
#declare sc2=1;
#macro txtBox(COL)
    texture{
       pigment { rgb <COL.x+rand(rd)*sc1,COL.y+rand(rd)*sc1,COL.z+rand(rd)*sc1>*sc2}
       finish{ambient 0 diffuse 1.0}
    }                   
#end                                                    


// ------------------------------
// scene
// ------------------------------
#if (WriteFile) 
    #include "makestacks.inc" // calls the stacking routine
#end    
#include "stacks.inc"     // place the cubes


