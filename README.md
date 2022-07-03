<!--Copyright Andrik Seeger 2022-->

# Combination and plotting of measurement files
This project was done within the MATLAB-lecture at the DHBW Stuttgart. It includes a MATLAB-App with an extensive GUI to automatically convert multiple measurement files from random points in time to **one time-continues measurement file**. As an extension the combined file can be plotted within the app. 

## Combination of measurement files
The combination process includes:
* unifying the singular files by resampling the data to a common sampling rate
* detecting data inconsistencies when multiple files are given for a time range
* detecting measurement interruptions
* removing compromised sections 
* automatically resorting the measurement data to one time-continues measurement

## Plotting of measurement files
The resulting measurement files can be displayed after the adaption and combination by plotting the measurement data over time. The required signals can be chosen within the GUI and plotted using either the left or the right y-axis. The resulting plot can be saved as a MATLAB figure or as Portable Network Graphics (PNG).

## Graphical User Interface (GUI)
The GUI with all functionalities is displayed in the following picture.
<p align="center">
<img src="https://github.com/AndrikSeeger/MATLAB_Measurement_File_Combination/blob/main/Ressources/GUI_Layout.png"/>
</p>

## Project definition
The project definition can be found <a href="https://github.com/AndrikSeeger/MATLAB_Measurement_File_Combination/blob/main/Ressources/Praxisprojekt_Appdesigner.pdf" target="_blank">here</a>.
