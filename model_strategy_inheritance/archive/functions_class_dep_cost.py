# IMPORT ----
import numpy as np


def initialize_population(population, num_class):
    """generate a population with distributions of class/wealth and initial random strategies"""

    # agents get random classes/wealth
    population[:, 2] = np.random.randint(0, num_class, len(population))
    
    # agents' wealth equally distributed
    # population[:, 2] = np.repeat(np.arange(0, num_class, 1), 11)

    # print("population wealth", population[:, 2])
    return population


def choose_random_strategy(population):
    """agents (only ancestors) choose a random fertility strategy"""
    
    # agents choose a random proportion of wealth for fertility
    population[:, 3] = np.random.uniform(0, 1, len(population)).astype(float)

    # agents' strategies equally distributed
    # population[:, 3] = np.repeat([np.linspace(0, 1, 11)], 15, axis=0).flatten()

    return population


def allocate_wealth(population, max_num_offspring, starvation_threshold):
    """allocate wealth between fertility investment and bequests (based on agent strategies), and get real fertility"""

    # fertility allocation
    population[:, 4] = population[:, 2] * population[:, 3]
    population[:, 4] = np.round(population[:, 4]).astype(int)

    # bequests
    population[:, 5] = population[:, 2] - population[:, 4]

    # fertility
    population[:, 6] = realize_fertility(population[:, 4], population[:, 2], max_num_offspring, starvation_threshold)

    return population


def realize_fertility(fertility_allocation, parent_class, max_num_offspring, starvation_threshold):
    """class-dependent threshold"""

    reproduction = np.zeros((len(fertility_allocation), 4))
    reproduction[:, 0] = fertility_allocation
    reproduction[:, 1] = parent_class
    # print("fertility_allocation", reproduction[:, 0])

    # class-dependent threshold
    reproduction[:, 2] = starvation_threshold + np.log(reproduction[:, 1] + 1)

    # realized fertility
    reproduction[:, 3] = np.round(reproduction[:, 0] - reproduction[:, 2])
    reproduction[:, 3] = np.clip(reproduction[:, 3], 0, max_num_offspring)

    return reproduction[:, 3].astype(int)


# def realize_fertility(fertility_allocation, max_num_offspring, survival_birth):

#     fertility_realized = np.zeros((len(fertility_allocation), 1))
#     # print("fertility_allocation", fertility_allocation)
    
#     for i in range(len(fertility_allocation)):
#         fertility_realized[i, 0] = np.random.binomial(fertility_allocation[i], survival_birth, 1)

#     # print("fertility_realized", fertility_realized)
#     return fertility_realized[:, 0]


# def realize_fertility(fertility_allocation, max_num_offspring, starvation_threshold):
#     """transform fertility allocations to real fertilities, according to a law of diminishing return and starvation threshold"""

#     # fertility as a diminishing return function of allocation
#     max_fertility = max_num_offspring * (1 - np.exp(-(fertility_allocation - starvation_threshold)))

#     # interger fertility
#     max_fertility = np.round(max_fertility).astype(int)
    
#     # fertilities do not exceed the upper bound
#     max_fertility = np.clip(max_fertility, 0, max_num_offspring)
    
#     # transform allocation to real fertilities
#     fertility_realized = np.clip(fertility_allocation, 0, max_fertility)

#     return fertility_realized


def inherit_wealth(offspring, parents, index):
    """offspring inherits bequests from parents"""

    bequests = int(parents[index, 5])
    fertility = int(parents[index, 6])

    wealth_inherited = np.zeros((fertility, 1))

    wealth_inherited[:, 0] = [bequests // fertility] * fertility

    remainder = bequests % fertility

    wealth_inherited[0:remainder, 0] += 1
    # print("wealth_inherited", wealth_inherited)

    offspring[:, 0] = wealth_inherited[:, 0]
    
    return offspring


def earn_income(offspring, num_class):
    """offspring earn income based on a Poisson distribution after inheriting bequests from parents"""
    # offspring[:, 1] = np.random.poisson(lam=mean_income, size=len(offspring))
    offspring[:, 1] = np.random.uniform(low=0, high=num_class-1, size=len(offspring))

    return offspring