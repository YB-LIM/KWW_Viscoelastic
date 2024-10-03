# KWW_Viscoelastic
UCREEPNETWORK subroutine and equivalent Python script to model KWW viscoelasticity <br><br>
Written on Python 3 <br> 
Written on Intel® Fortran Version 19.0.5 (Abaqus 2023) <br><br>

AUTHOR: Youngbin LIM<br>
CONTACT: lyb0684@naver.com

# Model description
Please refer to the Linkedin post: https://www.linkedin.com/pulse/stop-using-prony-series-try-kww-model-youngbin-lim-xqudc/?trackingId=VSjepEgSQvi7Q0JqFpF4IQ%3D%3D

** UCREEPNETWORK is applicable for small strain only

# File description
Relaxation_Prony.inp   : Input file for stress relaxation test. Run this input after generating visco_table.inp with Python script<br>
Relaxation_User.inp    : Input file for stress relaxation test. Run this input with user subroutine<br>
Stretched_EXP.for      : UCREEPNETWORK subroutine <br>
Stretched_EXP_Prony.py : Python script to generate visco_table.inp that contains Prony parameter table

# Validation
![Fig4](https://github.com/user-attachments/assets/65f06437-bf54-4b8b-b5fa-9e9e77fa82b7)


# References
[1] Abaqus Documentation, 2024, Dassault Systèmes Simulia Corp., Providence, RI, USA. <br>
[2] Berberan-Santos MN, Bodunov EN, Valeur B, 2005, Mathematical functions for the analysis of luminescence decays with underlying distributions 1. Kohlrausch decay function, Chemical Physics 315, 171-182. <br>
​[3] Mauro JC, Mauro YZ, 2018, On the prony series representation of stretched exponential relaxation, Physica A 506, 1181-1190.
