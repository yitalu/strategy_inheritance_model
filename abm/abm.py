# README ----



# IMPORT ----
import numpy as np
import functions as func
import time as tm

start_time = tm.time()
current_time = tm.strftime("%Y/%m/%d %H:%M:%S", tm.localtime())
print('started at:', current_time)



# PARAMETERS
# Basic
num_class = 10 # just for initial
num_ancestor = 100
# num_ancestor = num_class * 11
num_generation = 50
# indefinite number actually because of the limit_population
limit_population = 200000
max_offspring = 15
mutation_rate = 0.005
num_column = 11
# [0] inheritance; [1] income; [2] total wealth (class); [3] strategy (fertility ratio); [4] fertility investment; [5] bequests; [6] fertility; [7] ancestor's class; [8] parent's class; [9] generation

# [0] inheritance; [1] income; [2] total wealth (class); [3] strategy (fertility ratio); [4] fertility investment; [5] bequests; [6] fertility; [7] survived offspring; [8] ancestor's class; [9] parent's class; [10] generation

# Environmental
hazard_env = 0.9
income_max = num_class
cost_base = 0

# Conditional (1 for true; 0 for false)
death_offspring = 1
cost_class = 0



# DATA ARRAYS ----
ancestors = np.zeros((num_ancestor, num_column))
# [0] inheritance; [1] income; [2] total wealth (class); [3] strategy (fertility ratio); [4] fertility investment; [5] bequests; [6] fertility; [7] ancestor's class; [8] parent's class; [9] generation

# [0] inheritance; [1] income; [2] total wealth (class); [3] strategy (fertility ratio); [4] fertility investment; [5] bequests; [6] fertility; [7] survived offspring; [8] ancestor's class; [9] parent's class; [10] generation


# INITIALIZATION ----
ancestors = func.initialize_population(ancestors, num_class)
ancestors = func.allocate_wealth(ancestors)
ancestors = func.give_birth(ancestors, max_offspring, cost_class, cost_base, death_offspring, hazard_env)
ancestors[:, 7] = ancestors[:, 2] # ancestor tag



# TIME LOOP ----
parents = ancestors
data = parents

for t in range(num_generation):
    print("generation", t)

    # offspring becomes parents
    if t > 0:
        parents = offspring
        parents = func.allocate_wealth(parents)
        parents = func.give_birth(parents, max_offspring, cost_class, cost_base, death_offspring, hazard_env)

        # record parent data
        data_new = parents
        data = np.concatenate((data, data_new), axis=0)
        
    fertility_total = sum(parents[:, 6])
    survived_offspring = sum(parents[:, 7])
    print("fertility", fertility_total)
    print("survived_offspring", survived_offspring)
    

    # break the loop when: 1) no survived offspring; 2) last gen
    if survived_offspring == 0 or survived_offspring > limit_population:
    # if fertility_total == 0 or t == num_generation - 1:
        print("broke the loop at generation", t)
        break
    if t == num_generation - 1:
        break


    # create offspring array
    offspring = np.zeros((int(survived_offspring), num_column))


    # offspring inherits strategies with mutation
    offspring[:, 3] = np.repeat(parents[:, 3], parents[:, 7].astype(int), axis=0)
    draw = np.random.uniform(0, 1, len(offspring))
    mutants = np.where(draw < mutation_rate)
    offspring[mutants, 3] = np.random.uniform(0, 1, len(mutants[0]))


    # offspring inherits bequests evenly
    bequest_even = parents[parents[:, 7] != 0, 5] // parents[parents[:, 7] != 0, 7]
    offspring[:, 0] = np.repeat(bequest_even, parents[parents[:, 7] != 0, 7].astype(int), axis=0)


    # some offspring gets the remainder
    bequest_remainder = parents[parents[:, 7] != 0, 5] % parents[parents[:, 7] != 0, 7]
    # print("bequest_remainder", bequest_remainder)
    # print("length bequest remainder", len(bequest_remainder)) # should be same as length of parents

    remainder = []
    for i in range(len(bequest_remainder)):

        remainder_by_family = [1] * int(bequest_remainder[i]) + [0] * int(parents[parents[:, 7] != 0, 7][i] - bequest_remainder[i])

        remainder = np.concatenate((remainder, remainder_by_family), axis=None)

    # print("remainder", remainder)
    # print("length of remainder", len(remainder))
    # print("offspring[:, 0]", offspring[:, 0])
    # print("length offspring", len(offspring[:, 0]))
    offspring[:, 0] = offspring[:, 0] + remainder


    # offspring earns their income
    offspring = func.earn_income(offspring, num_class)
    offspring[:, 2] = offspring[:, 0] + offspring[:, 1]
    # offspring[:, 2] = np.clip(offspring[:, 2], 0, num_class - 1)
    offspring[:, 2] = np.round(offspring[:, 2])


    # record ancestor class
    offspring[:, 8] = np.repeat(parents[:, 8], parents[:, 7].astype(int), axis=0)
    
    
    # record parent class
    offspring[:, 9] = np.repeat(parents[:, 2], parents[:, 7].astype(int), axis=0)

    
    # record generation
    offspring[:, 10] = t + 1


# OUTPUT DATA
column_name = 'inheritance, income, wealth, strategy, fertility investment, bequests, fertility, survived offspring, ancestor class, parent class, generation'

if death_offspring == 0 and cost_class == 0:
    np.savetxt('./data/data_d0c0.csv', data, delimiter=',', fmt='%.2f', header=column_name)
    print("death_offspring:", death_offspring)
    print("cost_class:", cost_class)
elif death_offspring == 1 and cost_class == 0:
    # np.savetxt('./data/data_d1c0.csv', data, delimiter=',', fmt='%.2f', header=column_name)
    np.savetxt('./data/data_d1c0_h09.csv', data, delimiter=',', fmt='%.2f', header=column_name)
    print("death_offspring:", death_offspring)
    print("cost_class:", cost_class)
elif death_offspring == 0 and cost_class == 1:
    np.savetxt('./data/data_d0c1.csv', data, delimiter=',', fmt='%.2f', header=column_name)
    print("death_offspring:", death_offspring)
    print("cost_class:", cost_class)
elif death_offspring == 1 and cost_class == 1:
    np.savetxt('./data/data_d1c1.csv', data, delimiter=',', fmt='%.2f', header=column_name)
    print("death_offspring:", death_offspring)
    print("cost_class:", cost_class)

print("population of ancestors", num_ancestor)
print("parents in last generation", len(offspring))

end_time = tm.time()
current_time = tm.strftime("%Y/%m/%d %H:%M:%S", tm.localtime())
print('run time in seconds:', "{0:.2f}".format(end_time - start_time))
print("time score", (end_time - start_time)*10000/len(offspring))
print('finished at:', current_time)