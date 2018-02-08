# markov_chains.py
# Jaron Whittington

import numpy as np
from numpy import linalg as la


def random_chain(n):
    """Create and return a transition matrix for a random Markov chain with
    'n' states. This should be stored as an nxn NumPy array.
    """
    mark = np.random.rand(n,n)
    cSum = mark.sum(axis = 0)
    newmark = mark / cSum
    return newmark


def forecast(days):
    """Forecast tomorrow's weather given that today is hot."""
    transition = np.array([[0.7, 0.6], [0.3, 0.4]])

    # Sample from a binomial distribution to choose a new state.
    forecast = []
    curr = 0
    for n in range(days):
        curr = np.random.binomial(1, transition[1, curr])
        forecast.append(curr)
    return forecast

# Problem 3
def four_state_forecast(days):
    """Run a simulation for the weather over the specified number of days,
    with mild as the starting state, using the four-state Markov chain.
    Return a list containing the day-by-day results, not including the
    starting day.

    Examples:
        >>> four_state_forecast(3)
        [0, 1, 3]
        >>> four_state_forecast(5)
        [2, 1, 2, 1, 1]
    """
    transition = np.array([[.5,.3,.1,0],[.3,.3,.3,.3],[.2,.3,.4,.5],[0.,.1,.2,.2]])
    forecast = []
    curr = 1
    for n in range(days):
        curr = np.argmax(np.random.multinomial(1,transition[:,curr]))
        forecast.append(curr)
    return forecast



def steady_state(A, tol=1e-12, N=40):
    """Compute the steady state of the transition matrix A.

    Inputs:
        A ((n,n) ndarray): A column-stochastic transition matrix.
        tol (float): The convergence tolerance.
        N (int): The maximum number of iterations to compute.

    Raises:
        ValueError: if the iteration does not converge within N steps.

    Returns:
        x ((n,) ndarray): The steady state distribution vector of A.
    """
    n = A.shape[0]
    x = np.random.rand(n,1)
    curr = x / x.sum(axis = 0)
    count = 0
    while count < N:
        next = A@curr
        if la.norm(next - curr) < tol: return next
        curr = next
        count += 1
    raise ValueError("A does not converge")



class SentenceGenerator(object):
    """Markov chain creator for simulating bad English.

    Example:
        >>> yoda = SentenceGenerator("Yoda.txt")
        >>> print(yoda.babble())
        The dark side of loss is a path as one with you.
    """
    def __init__(self, filename):
        """Read the specified file and build a transition matrix from its
        contents. You may assume that the file has one complete sentence
        written on each line.
        """
        with open(filename, 'r') as myfile:
            contents = myfile.readlines()
            self.states = ["$tart"]
            for line in contents:
                for word in line.strip().split(" "):
                    if word not in self.states: self.states.append(word)
            self.states.append("$top")
            n = len(self.states)
            transition = np.zeros((n,n))
            for line in contents:
                words = line.strip().split(" ")
                transition[self.states.index(words[0])][0] += 1
                for k in range(len(words)):
                    x = self.states.index(words[k])
                    try:
                        y = self.states.index(words[k+1])
                        transition[y][x] += 1
                    except: transition[n-1][x] += 1
            transition[n-1][n-1] = 1
            transition = transition / transition.sum(axis=0)
            self.transition = transition

            
                    
                
                

    def babble(self):
        """Begin at the start sate and use the strategy from
        four_state_forecast() to transition through the Markov chain.
        Keep track of the path through the chain and the corresponding words.
        When the stop state is reached, stop transitioning and terminate the
        sentence. Return the resulting sentence as a single string.
        """
        babble = ""
        curr = 0
        while curr != self.states.index("$top"):
            curr = np.argmax(np.random.multinomial(1,self.transition[:,curr]))
            if curr != self.states.index("$top"):
                babble += self.states[curr]+ " "
            else: break
        return babble
