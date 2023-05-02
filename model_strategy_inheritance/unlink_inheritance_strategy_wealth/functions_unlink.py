# IMPORT ----
from math import exp
import numpy as np


def initialize_population(population, num_class):
    """generate wealth and strategy distributions in population"""

    # agents get random classes/wealth
    # population[:, 2] = np.random.randint(0, num_class, len(population))
    
    # agents' wealth equally distributed
    population[:, 2] = np.repeat(np.arange(0, num_class, 1), 11)

    # agents choose a random fertility strategy
    # population[:, 3] = np.random.uniform(0, 1, len(population)).astype(float)

    # agents' strategies equally distributed
    population[:, 3] = np.repeat([np.linspace(0, 1, 11)], num_class, axis=0).flatten()

    return population


def allocate_wealth(population):
    """allocate wealth between fertility investment and bequests (based on agent strategies), and get real fertility"""

    # fertility allocation
    population[:, 4] = population[:, 2] * population[:, 3]
    population[:, 4] = np.round(population[:, 4]).astype(int)

    # bequests
    population[:, 5] = population[:, 2] - population[:, 4]

    return population


def give_birth(population, max_num_offspring, cost_class, cost_base, death_offspring, hazard_env):

    # fertility allocation: population[:, 4]
    # parent class: population[:, 2]

    reproduction = np.zeros((len(population), 4))
    # [0] cost; [1] fertility; [2] survival rate; [3] survived offspring

    # if there is a class-dependent cost
    if cost_class == 1:
        reproduction[:, 0] = cost_base + np.log(population[:, 2] + 1)
    elif cost_class == 0:
        reproduction[:, 0] = cost_base

    # give birth
    reproduction[:, 1] = np.round(population[:, 4] - reproduction[:, 0])
    reproduction[:, 1] = np.clip(reproduction[:, 1], 0, max_num_offspring)

    # if death of offspring is true
    if death_offspring == 1:
        reproduction[:, 2] = np.exp(hazard_env * (- reproduction[:, 1] / max_num_offspring))

        for i in range(len(reproduction[:, 1])):
            reproduction[i, 3] = np.random.binomial(reproduction[i, 1].astype(int), reproduction[i, 2], 1)
            # print("survived offspring", reproduction[i, 3])
        
    elif death_offspring == 0:
        reproduction[:, 3] = reproduction[:, 1]

    population[:, 6] = reproduction[:, 1].astype(int)
    population[:, 7] = reproduction[:, 3].astype(int)

    return population



# def inherit_wealth(offspring, parents, index):
#     """offspring inherits bequests from parents"""

#     bequests = int(parents[index, 5])
#     fertility = int(parents[index, 6])

#     wealth_inherited = np.zeros((fertility, 1))

#     wealth_inherited[:, 0] = [bequests // fertility] * fertility

#     remainder = bequests % fertility

#     wealth_inherited[0:remainder, 0] += 1
#     # print("wealth_inherited", wealth_inherited)

#     offspring[:, 0] = wealth_inherited[:, 0]
    
#     return offspring


def earn_income(offspring, num_class, income_distribution, income_dependency, mobility):
    """offspring earn income based on a Uniform/Normal/Poisson distribution after inheriting bequests from parents"""
    
    # Uniform Income
    if income_distribution == "uniform":

        # income depends on society average
        if income_dependency == "society":
            # offspring[:, 1] = np.random.uniform(low=0, high=num_class-1, size=len(offspring))
            offspring[:, 1] = np.random.uniform(low = (num_class-1)/2 - mobility, high = (num_class-1)/2 + mobility, size = len(offspring))

        # income depends on offspring inheritance
        elif income_dependency == "self":
            for i in range(len(offspring[:, 1])):
                offspring[i, 1] = np.random.uniform(low = offspring[i, 0] - mobility, high = offspring[i, 0] + mobility, size = 1)

        # income depends on parent class
        elif income_dependency == "parent":
            for i in range(len(offspring[:, 1])):
                offspring[i, 1] = np.random.uniform(low = offspring[i, 9] - mobility, high = offspring[i, 9] + mobility, size = 1)


    # Normal Income
    elif income_distribution == "normal":
    
        # income depend on society average
        if income_dependency == "society":
            offspring[:, 1] = np.random.normal(loc = (num_class-1)/2, scale = mobility, size=len(offspring))

        # income depends on offspring inheritance
        elif income_dependency == "self":
            for i in range(len(offspring[:, 1])):
                offspring[i, 1] = np.random.normal(loc = offspring[i, 0], scale = mobility, size = 1)

        # income depends on parent class
        elif income_dependency == "parent":
            for i in range(len(offspring[:, 1])):
                offspring[i, 1] = np.random.normal(loc = offspring[i, 9], scale = mobility, size = 1)
    

    # Poisson income
    elif income_distribution == "poisson":
    
        # income depends on society average
        if income_dependency == "society":
            offspring[:, 1] = np.random.poisson(lam=(num_class-1)/2, size=len(offspring))
    
        # income depends on offspring inheritance
        elif income_dependency == "self":
            for i in range(len(offspring[:, 1])):
                offspring[i, 1] = np.random.poisson(lam=offspring[i, 0], size=1)

        # income depends on parent class
        elif income_dependency == "parent":
            for i in range(len(offspring[:, 1])):
                offspring[i, 1] = np.random.poisson(lam=offspring[i, 9], size=1)


    # no negative income
    # offspring[offspring[:, 1] < 0, 1] = 0
    
    # print("income", offspring[:, 1])

    return offspring