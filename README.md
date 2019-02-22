# AR-mask
A program to add augmented reality face filters to a physical mask.  Made with Processing.

## Augmented Reality Mask project
Provides an interface for getting a video feed from a webcam, detecting fiducials and selecting manually points to track + augmenting the image with 2D and 3D graphics filters.
It is designed to draw filters over and around a face mask worn by the user, on which the necessary markers and/or fiducials have been added.
see screenshots of the project here: https://noemiepierrejean.wordpress.com/2019/01/30/171/

## Note
This is a work in progress.
For the moment, only a spherical 3D filter (for testing fiducial tracking and detection), and a 2D filter (for object tracking) are used. More to be added later.

## Prerequisites
Install the Processing environment to run this program: https://processing.org/download/
Then install boofcv for Processing, you can do this from the Processing interface (tools > add > libraries > boofcv).
The fiducial marker recognition works with BoofCV square binary fiducials:
https://boofcv.org/index.php?title=File:Fiducial_squre_binary.png

## Additional information
The AR mask project was originally made as a final project for Prof. Yen-Ting Cho's Computational Media course (Fall 2018) at National Cheng Kung University.
