# Analysis of Algorithms

<hr/>

## Asymptotic Analysis

### Given two algoithms for a task, how do we find out which one is better?

One native way of soing this is - implwmwnt both the algorithms and run the two programs on your computer for different inputs and see which one takes less time. There are many problems with this approach for analysis of algorithms.

- It might be possible that for some inputs, first algorithm performs better than the second. And for some inputs second performs better.
- It might also be possible that for some inputs, first algorithm perform better on one machine and the second works better on other machine for some other inputs.

[Asymptotic Analysis](https://en.wikipedia.org/wiki/Asymptotic_analysis) is the big idea that handles above issues in analyzing algorithm in terms of input size(we don't measure the ectual running time). We calculate, how does the time (or space) taken by an algorithm increases with the input size.

### References:

[MIT's Video lecture 1 on Introduction to Algorithms.](http://www.youtube.com/watch?v=JPyuH4qXLZ0)

## Worst, Average and Bast Cases

### Worst Case Analysis(Usually Done)

In the worst case analysis, we calculate upper bound on running time of an algorithm. We must know the case that causes maximum number of operations to be executed.

### Average Case Analysis(Sometimes done)

In average case analysis, we take all possible inputs and calculate computing time for all of the inputs. Sum all the calculated values and devide the sum by total number of inputs. We must know (or predict) distribution of cases.

### Best Case Analysis(Bogus)

In the best case analysis, we calculate lower bound on running time of an algorithm. We must know the case that causes minimum number of operations to be executed.

Most of the times, we do worst case analysis to analyze algorithms. In the worse analysis, we guarantee an upper bound on the running time of an algorithm which is good information.

The average case analysis is not easy to do in most of the practical cases and it is rarely done. In the average case analysis, we must know (or predict) the mathematical distribution of all possible inputs.

The Best Case analysis is bogus. Guaranteeing a lower bound on an algorithm doesn't provide any information as in the worse case, an algorithm may take years to run.

## Asymptotic Notations

The main idea of asymptotic analysis is to have a measure of afficiency of algotithms that doesn't depend on machine specific constants, and doesn't require algorithms to be implemented and time taken by progrms to be compared. Asymptotic notations are mathematical tools to represent time complexity of algorihms for asymptotic analysis. 3 asymptotic notations are mostly used to represent time complexity of algorithms.

**_Θ Notation_**: The theta notation bounds a functions from above and below so it defines exact asymprotic behavior. A simple way to get Theta notation of an expression is to drop low order terms and ignore leading constants.
For a given function g(n), we denote Θ(g(n)) is following set of functions.

    Θ(g(n)) = {f(n): there exist positive constants c1, c2 and n0 such
                    that 0 <= c1*g(n) <= f(n) <= c2*g(n) for all n >= n0}

![theta](../../img-root/AlgoAnalysis-1.png)

**_Big O Notation_**: The Big O notation defines an upper bound of an algorithm, it bounds a function only from above.
The Bid O notation is useful when we only have upper bound on time complexity of an algorithm. Many times we easily find an upper bound by simply looking at the algorithm.

    O(g(n)) = { f(n): there exist positive constants c and
                    n0 such that 0 <= f(n) <= c*g(n) for
                    all n >= n0}

![Big O](../../img-root/AlgoAnalysis-2.png)
**_Ω Notation_**: Just as Big O notation provides an asymptotic upper bound on a function, Ω notation provides an asymptotic lower bound.
Ω Notation can be useful when we have lower bound on time complexity of an algorithm.

For a given function g(n), we denote by Ω(g(n)) the set of functions.

    Ω (g(n)) = {f(n): there exist positive constants c and
                    n0 such that 0 <= c*g(n) <= f(n) for
                    all n >= n0}.

![Omega](../../img-root/AlgoAnalysis-3.png)

**_Important Links_**:

- There are two more notations called **_[little o and little omega](https://www.geeksforgeeks.org/analysis-of-algorithems-little-o-and-little-omega-notations/)_**.
- [Analysis of Algorithm| Set 4 (Analysis of Loops)](https://www.geeksforgeeks.org/analysis-of-algorithms-set-4-analysis-of-loops/)
- [Recent Aritcles on analysis of algorithm](https://www.geeksforgeeks.org/category/algorithm/analysis/).

## Little o and little omega notations

The main idea of **_asymptotic analysis_** is to have a measure of efficiency of algorithms that doesn't depend on machine specific constants, mainly because this analysis doesn't require algorithms to be implemeneted nad time taken by programs to be compared.

### Little o asymptotic notation

**_Definition_**: Let f(n) and g(n) be functions that map positive integers to positive real numbers. we say that f(n) is o(g(n)) (of f(n) E o(g(n))) if for **_any real_** constant c>0, there exists an integer constant n0>= 1 such that 0 <= f(n) < c\*g(n).

In mathematical relation, f(n) = o(g(n)) means lim f(n)/g(n) = 0

### Little omega asymptotic notation

**_Definition_**: Let f(n) and g(n) ne functions that map positive integers to positive real numbers. We say that f(n) is ω(g(n)) (or f(n) ∈ ω(g(n))) if for any real constant c > 0, there exists an integer constant n0 >= 1 such that f(n) > c\*g(n) >= 0 for every integer n >= n0

f(n) has a higher growth rate than g(n) so main difference between Big Omega(Ω) and little omega (ω) lies in their definitions. In the case of Big Omega f(n)=Ω(g(n)) and the bound is 0<=cg(n)<=f(n), but in case of little omega, it is true for 0 <= c\*g(n) < f(n).

We use ω notation to denote a lower bound that is not asymptotically tight. and, f(n) ∈ ω(g(n)) if and only if g(n) ∈ ο((f(n))

In mathematical relation, if f(n) ∈ ω(g(n)) then lim **_f(n)/g(n) = ∞_**

![little o](../../img-root/Analysis-of-Algorithms-little-o-omega.png)

<hr/>

To be continued.

Get more information at [here](https://www.geeksforgeeks.org/fundamentals-of-algorithms/#AnalysisofAlgorithms).
