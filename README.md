<!--Copyright Andrik Seeger 2022-->

# 📊 Combination and Plotting of Measurement Files

This project was developed as part of the **MATLAB lecture at DHBW Stuttgart**.
It features a self-contained **MATLAB App Designer application** with a user-friendly GUI for:

* 📁 Combining multiple time-discrete measurement files
* 🔁 Resampling and cleaning data
* 📈 Visualizing signals over time

The core goal is to convert individual, asynchronously recorded measurement files into **one time-continuous, consistent dataset** for analysis or export.

---

## 🧠 Motivation & Application

Measurement data often comes from different test runs, systems, or hardware setups — resulting in **inconsistent sampling rates, interruptions, and overlaps**.
This tool enables engineers and researchers to:

* Automate data unification
* Detect and clean invalid data sections
* Merge fragmented logs into a **coherent timeline**

It's ideal for use cases in automotive measurement, sensor logging, or signal processing.

---

## 🔧 Combination of Measurement Files

The app performs an intelligent preprocessing pipeline:

* 🔄 **Resampling** all files to a common sampling rate
* 🕵️ **Detecting overlapping time ranges** and resolving data conflicts
* ⚠️ **Flagging interruptions or incomplete recordings**
* 🧹 **Removing corrupted or redundant sections**
* 🧩 **Sorting data chronologically** into a smooth, time-aligned file

The final output is a cleaned `.mat` structure with synchronized time and signal vectors.

---

## 📈 Plotting Functionality

After processing, you can visualize the cleaned dataset directly inside the app:

* Select one or more signal variables
* Assign curves to the **left or right Y-axis**
* Plot the data over absolute time
* 🖼️ Export the result as:

  * A `.fig` MATLAB figure
  * A `.png` image (Portable Network Graphics)

---

## 🖥️ Graphical User Interface (GUI)

The GUI was built using **MATLAB App Designer** and provides:

* File input dialog for loading multiple `.mat` files
* Signal selection panel
* Sampling rate and tolerance settings
* Error and status messages
* Live plot preview
* Export options

<p align="center">
<img src="https://github.com/AndrikSeeger/MATLAB_Measurement_File_Combination/blob/main/Ressources/GUI_Layout.png"/>
</p>

---

## 📄 Project Definition

A detailed description of the project objectives and implementation can be found in the official documentation:

👉 [Project Definition PDF (Praxisprojekt Appdesigner)](https://github.com/AndrikSeeger/MATLAB_Measurement_File_Combination/blob/main/Ressources/Praxisprojekt_Appdesigner.pdf)

---

## 💡 Future Ideas (Optional)

While not part of the original scope, potential improvements could include:

* CSV/Excel support
* Signal unit normalization
* Interactive zoom & cursors
* Export to Simulink-compatible formats
