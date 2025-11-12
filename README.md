# Data_EQ_Spectra_Article_Kolozvari_et_al_2026

Integrated SSI Analysis of Tall Reinforced Concrete Core Wall Building – Supporting Data for Earthquake Spectra Submission

Authors

Kristijan Kolozvari 
Ryutaro Kadota 
Andres Reyes 
Satoru Ikeda 
Mahdi Taiebat 
Farzad Naeim 
Masayoshi Nakashima 

Description

This dataset contains the input data used in the numerical analyses reported in the paper “Integrated High-Fidelity Soil–Structure Interaction Analysis of a Tall Reinforced Concrete Core Wall Building,” submitted to Earthquake Spectra (2025).

A high-fidelity three-dimensional nonlinear finite element model was developed in OpenSees to capture nonlinear behaviors of both the soil and superstructure, and to explicitly simulate interaction between the structure, foundation, and surrounding soil. The dataset enables replication of the analyses comparing the fixed-base and SSI models, as well as verification of the presented engineering demand parameters (EDPs).

Folder Structure

1. Fixed_Base_Model/
Contains OpenSees input files for the fixed-base model of the 25-story reinforced concrete core wall building.

2. SSI_Model/
Includes OpenSees input files for the fully integrated soil–structure interaction (SSI) model of the same 25-story reinforced concrete core wall building.

3. Ground_Motions_Data/
Provides the input ground motion acceleration time histories used in both the fixed-base and SSI analyses.

Usage Notes

All input files are plain-text OpenSees scripts (*.tcl, *.txt).
Analyses were performed using OpenSees 3.7.0.
The dataset does not require proprietary software.
Users are encouraged to cite the dataset and associated publication when referencing these models or results.

Related Publication

Kolozvari, K., Kadota, R., Reyes, A., Ikeda, S., Taiebat, M., Naeim, F., & Nakashima, M.. Integrated High-Fidelity Soil–Structure Interaction Analysis of a Tall Reinforced Concrete Core Wall Building. Submitted to Earthquake Spectra in November 2025.
