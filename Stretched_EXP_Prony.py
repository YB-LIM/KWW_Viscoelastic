#
# A Python script to generate Prony series table for stretched exponential model
# 
# AUTHOR  : Youngbin LIM
# CONTACT : Youngbin.LIM@3ds.com
#
import numpy as np
from scipy.special import factorial, gamma

# Material parameter
g0 = 0.3
tau0 = 3.0
Beta = 0.5

# Time span
Tau_Lower = 0.001
Tau_Upper = 100.0

# Number of sampling points
N = 500

# Generate time points - Tau
Tau = np.linspace(Tau_Lower, Tau_Upper, num=N, endpoint=True, axis=0)

# Define function for f_tau calculation
def f_tau(Beta, tau_i, tau0, Number_of_Sum):
    i_values = np.arange(1, Number_of_Sum)[:, np.newaxis]  # Reshape i_values to (Number_of_Sum, 1) for broadcasting

    # Calculate each term in the series using scipy's factorial and gamma
    series_i = ((-1.)**(i_values + 1)) * ((tau0 / tau_i)**(-1 + i_values * Beta)) * \
               (1. / factorial(i_values, exact=False)) * \
               gamma(1. + i_values * Beta) * \
               np.sin(i_values * Beta * np.pi)

    # Sum along axis 0 for all values of tau_i
    series_sum = np.sum(series_i, axis=0)

    # Calculate f_tau for the entire array
    f_tau_val = series_sum * tau0 * (1. / np.pi) * (1. / (tau_i**2.))

    return f_tau_val

# Calculate gi
Number_of_Sum = 100
f = f_tau(Beta, Tau, tau0, Number_of_Sum)
f = f[f >= 0]
Norm_Factor = 1./np.sum(f)
g_i = g0 * Norm_Factor * f_tau(Beta, Tau, tau0, Number_of_Sum)

# Generate input file
Kappa = np.zeros(N, dtype=float)

# Reshape arrays to make sure they can be concatenated correctly
g_i = g_i.reshape(N, 1)
Kappa = Kappa.reshape(N, 1)
Tau = Tau.reshape(N, 1)

# Concatenate along the second axis
Visco_Table = np.concatenate((g_i, Kappa, Tau), axis=1)

# Filter rows where g_i is not in the range [0.0, 1.0]
mask = (g_i >= 0.0) & (g_i <= 1.0)  # Create a mask for valid g_i values
filtered_Visco_Table = Visco_Table[mask.flatten()]  # Apply mask to filter rows

# Write filtered_Visco_Table to a .txt file
np.savetxt('visco_table.inp', filtered_Visco_Table, delimiter=',', fmt='%.8E')