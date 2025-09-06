This is an exercise I performed to learn Test-Driven Development and unit testing in Python.

## Tennis kata

The first exercise is related to choosing the winner of a tennis game (in particular of a single set).

The Set and Scores classes are developed test-first, and Scores is included in the same source file as Set to document its status as an internal member of the module that should not be used from the outside.

Run with:

```
python -m unittest test_tennis
```

## Randomness

The `random` module is tested through the properties of the output it generates (it's not test-driven as it is a standard module provided by the runtime.) For example, sampled elements from a list must belong to the list while shuffling a list should not lose any contained element.

Run with:

```
python -m unittest test_random
```
