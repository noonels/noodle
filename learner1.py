#! /usr/bin/python3
import sys
from random import random, randint, seed

ITERATIONS = 5000
ETA = 0.0005


class Example:
    def __init__(self, xs, y):
        self.x = xs + [1]
        self.y = y


def sum_of_squares(E, w):
    sum = 0
    for e in E:
        sum += (e.y - y_hat(w, e)) ** 2
    return sum


def y_hat(w, e):
    yh = 0
    for i in range(len(e.x)):
        yh += w[i] * e.x[i]
    return yh


def getExamples(input_file):
    examples = []
    with open(input_file, "r") as f:
        ns = f.readline().split()
        ns = [float(n) for n in ns]
        y = ns[-1]
        xs = ns[:-1]
        examples.append(Example(xs, y))
    return examples


def learn(w, E, eta):
    for i in range(ITERATIONS):
        for k in range(len(E)):
            yh = y_hat(w, E[k])
            delta = E[k].y - yh
            for j in range(len(w)):
                w[j] += eta * delta * E[k].x[j]
    return w


def main():
    if len(sys.argv) > 1:
        my_seed = int(sys.argv[1])
    else:
        my_seed = randint(0, 1000000)
    seed(my_seed)
    w = [randint(0, 100), randint(0, 100)]
    eta = ETA
    E = getExamples("trashdata.txt")
    Ev = getExamples("moretrashdata.txt")
    w = learn(w, E, eta)
    output = """\
CS-5001: HW#1
Programmer: Matthew Healy <mhrh3@mst.edu>

TRAINING
Using random seed = {}
Using learning rate eta = {}
After {} iterations:
Weights:
w0 = {}
w1 = {}

VALIDATION
Sum-of-Squares Error = {}""".format(
        my_seed, eta, ITERATIONS, w[0], w[1], sum_of_squares(Ev, w)
    )
    print(output)


if __name__ == "__main__":
    main()
