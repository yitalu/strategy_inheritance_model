# README ----



# IMPORT ----
import numpy as np
import functions_base as func
import time as tm

start_time = tm.time()
current_time = tm.strftime("%Y/%m/%d %H:%M:%S", tm.localtime())
print('started at:', current_time)



# PARAMETERS ----
# Basic
num_class = 10 # just for initial
num_ancestor = 100
# num_ancestor = num_class * 11
num_generation = 10
max_offspring = 14
mutation_rate = 0.005
num_column = 10
# [0] inheritance; [1] income; [2] total wealth (class); [3] strategy (fertility ratio); [4] fertility investment; [5] bequests; [6] fertility; [7] ancestor's class; [8] parent's class; [9] generation

# Environmental
hazard_env = 0.5
income_max = num_class
cost_base = 1

# Conditional
death_offspring = 0
cost_class = 0



# DATA ARRAYS ----
ancestors = np.zeros((num_ancestor, num_column))
# [0] inheritance; [1] income; [2] total wealth (class); [3] strategy (fertility ratio); [4] fertility investment; [5] bequests; [6] fertility; [7] ancestor's class; [8] parent's class; [9] generation



# INITIALIZATION ----
ancestors = func.initialize_population(ancestors, num_class)
ancestors = func.allocate_wealth(ancestors, max_offspring)
ancestors = func.give_birth(ancestors, max_offspring, death_offspring, hazard_env, cost_class, cost_base)
ancestors[:, 7] = ancestors[:, 2] # ancestor tag



# TIME LOOP ----
parents = ancestors
data = parents

for t in range(num_generation):
    print("generation", t)

    # offspring becomes parents
    # break the loop if no fertility
    # create offspring array
    # offspring inherits strategies with mutation
    # offspring inherits bequests evenly
    