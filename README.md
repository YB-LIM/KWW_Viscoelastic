# KWW_Viscoelastic
UCREEPNETWORK subroutine and equivalent Python script to model KWW viscoelasticity <br><br>
Written on Pyhton 3 <br> 
Written on Intel® Fortran Version 19.0.5 (Abaqus 2023) <br><br>

AUTHOR: Youngbin LIM<br>
CONTACT: lyb0684@naver.com

# File description
Relaxation_Prony.inp   : Input file for stress relaxation test. Run this input after generating visco_table.inp with Python script<br>
Relaxation_User.inp    : Input file for stress relaxation test. Run this input with user subroutine<br>
Stretched_EXP.for      : UCREEPNETWORK subroutine
Stretched_EXP_Prony.py : Python script to generate visco_table.inp that contains Prony parameter table

# Validation
![Fig4](https://github.com/user-attachments/assets/7272372e-b645-4264-9370-16db8f86dda9)

# References
[1] Abaqus Documentation, 2024, Dassault Systèmes Simulia Corp., Providence, RI, USA. <br>
[2] Berberan-Santos MN, Bodunov EN, Valeur B, 2005, Mathematical functions for the analysis of luminescence decays with underlying distributions 1. Kohlrausch decay function, Chemical Physics 315, 171-182. <br>
​[3] Mauro JC, Mauro YZ, 2018, On the prony series representation of stretched exponential relaxation, Physica A 506, 1181-1190.
