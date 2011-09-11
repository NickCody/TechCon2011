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
#version 3.7;

// choose a number of cubes (has no effect unless WriteFile=True)
// large n values give long parsing time
#declare num=1;

#include "colors.inc"
#declare LN_Blue = rgb <29/256, 97/256, 168/256>;
#declare LN_Orange = rgb <255/255,178/256,67/256>;

// ------------------------------
// Set settings : radiosity only
// ------------------------------
global_settings{
    radiosity{
        pretrace_start 1
        pretrace_end 1
        count 1000
        recursion_limit 1 
        nearest_count 20 //5
        error_bound 0.005 // .05
    }
    assumed_gamma 2.2
}

#default {finish { ambient 0 diffuse 1 }}

#declare CamLoc=<-2.5,14,-24>; 
#declare CamEye=<0,3,-10>;
#declare CamSky=y;
#declare AspectRatio=4/3;
#declare CamZoom=1;

camera {
   location CamLoc
   direction z*CamZoom
   right x*AspectRatio
   look_at CamEye
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
#macro unitbox(COL)
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

#macro unitbox1(COL)
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
    #local N2=text { ttf Font "2" 1, 0 scale sFont}
    #local N0=text { ttf Font "0" 1, 0 scale sFont}
    #local N1=text { ttf Font "1" 1, 0 scale sFont}
    union{
        object{T centertext(T) translate -0.5*z rotate y*90 txtBox(COL)}
        object{E centertext(E) translate -0.5*z  txtBox(COL)}                        
        object{C centertext(C) translate -0.5*z rotate -90*y txtBox(COL)}   
        object{N2 centertext(N2) translate -0.5*z rotate 180*y txtBox(COL)}                   
        object{N0 centertext(N0) translate -0.5*z rotate 90*x txtBox(COL)}  
        object{N1 centertext(N1) translate -0.5*z rotate -90*x txtBox(COL)}  
    }
}
#end

#macro unitbox_big(COL)
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
    #declare sFont=<0.25,0.25,0.01>;
    #local T=text { ttf Font "The" 1, 0 scale sFont}
    #local B=text { ttf Font "Big" 1, 0 scale sFont}
    #local P=text { ttf Font "Picture" 1, 0 scale sFont}
    union{
        object{T centertext(T) translate -0.5*z rotate y*90 txtBox(COL)}
        object{B centertext(B) translate -0.5*z  txtBox(COL)}                        
        object{P centertext(P) translate -0.5*z rotate -90*y txtBox(COL)}   
        object{T centertext(T) translate -0.5*z rotate 180*y txtBox(COL)}                   
        object{B centertext(B) translate -0.5*z rotate 90*x txtBox(COL)}  
        object{P centertext(P) translate -0.5*z rotate -90*x txtBox(COL)}  
    }
}
#end

// ------------------------------
// cube texture
// ------------------------------
#macro txtBox(COL)
    texture{
       pigment { rgb <COL.x,COL.y,COL.z>}
       finish{ambient 0 diffuse 1.0}
    }                   
#end                                                    

// ------------------------------
// scene
// ------------------------------
#include "makestacks-bigpicture.inc" // calls the stacking routine
#include "stacks.inc"     // place the cubes


