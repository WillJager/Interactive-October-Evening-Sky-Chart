Uses Flixel, a free, open source game programming library: http://flixel.org/

Requires OpenNI and AirKinect.

AirKinect: http://as3nui.github.io/airkinect-2-core/
OpenNI: https://code.google.com/p/simple-openni/wiki/Installation#OSX

I recommend following the instructions on the AirKinect website first, and trying to get the demo project running.

I used Adobe Flash Builder 4.7 on a Mac. In Flash Builder, had to do the following:
-Set the following in compiler argument: -frame appFrame ScienceHackDay
-Set Preloader.as as the default runnable application file


NOTES:

Modified since Science Hack Day 2014 to fix some bugs and add some improvements.
Code is still hacky, but I've added some comments which I hope are helpful.
 
When starting up, the stars should rotate to display the correct view
Shortly after, the kinect stuff should finish loading

Once you see the video feed, you can press 1,2, or 3 for different player masks. 
Press T to toggle background on/off