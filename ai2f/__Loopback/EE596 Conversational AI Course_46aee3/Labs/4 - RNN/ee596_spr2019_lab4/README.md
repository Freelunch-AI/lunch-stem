# EE596 Lab 4 -- Recurrent Neural Network

Course Webpage: [EE596 -- Conversational Artificial Intelligence](https://hao-cheng.github.io/ee596_spr2019/)

The recurrent neural network (RNN) has lots of applications in natural language processing, such as language modeling, part-of-speech tagging, and named entity recognition.
It is also the core part of many recent neural conversation models.
In this lab, you will learn the basic math behind the RNN and use it in two toy tasks, i.e., sorting numbers and language generation.

## Requirements
* Python >= 3.6
* Numpy >= 1.16.2

## Task 1: RNN basics
Please follow instructions in the python notebook `rnn_basics.ipynb` to implement an RNN unit.

## Task 2: RNN sequence modeling
In this task, we will build an RNN sequence model using the math you learned from Task 1.

### Steps
* Complete the `forward_function` and `backward_function` methods for the RNN hidden unit `src/rnn_unit.py`.
To test your implementation, run the following command in the root folder.
    ```
    $ python3 -m src.rnn_unit
    ```
    You should see the following messages with slightly different values (but should be less than 1e-4).
    ```
    dWhh test passed! abs(expected - actual) = 1.908198006229586e-07
    dWhx test passed! abs(expected - actual) = 1.5540405274422613e-07
    ```
* Complete the `forward_propagate` and `backward_propagate` methods for the RNN model `src/rnn_model.py`
by calling `forward_function` and `backward_function` in `RnnUnit`, respectively.
To test your implementation, run the following command in the root folder.
    ```
    python3 -m src.rnn_model
    ``` 
    Similarly, you should see the following messages with slightly different values (but should be less than 1e-4).
    ```
    dWoh test passed! abs(expected - actual) = 1.2363443602114721e-05
    dbo test passed! abs(expected - actual) = 2.131628207502345e-06
    dWhx test passed! abs(expected - actual) = 1.2524729501056653e-05
    dWhh test passed! abs(expected - actual) = 5.419197099473371e-05
    ```

## Task 3: RNN model for sorting numbers
In Task 2, you've finished essential parts for an RNN sequence model. 
Here let's use the model in the toy task of sorting numbers.

### Steps
* Take a look at the data under `data/sorting_numbers`. For this problem, a training sample could be
	```
	4 1 2 5 6 <sort> 1 2 4 5 6
	```
    * The numbers before `<sort>` are unsorted, and numbers after `<sort>` are sorted in ascending order. 
    * In this task, we only consider number sequences of length 5 containing integer numbers from 0 to 9.
* To train an RNN model for sorting numbers, run the following command
    ```bash
    python3 -m src.train_rnn_model \
      --trainfile data/sorting_numbers/train \
      --validfile data/sorting_numbers/valid \
      --vocabfile data/sorting_numbers/vocab \
      --separator \<sort\> \
      --init-alpha 0.01 \
      --batchsize 1 \
      --nhidden 64 \
      --outmodel sorting_numbers_model.pkl \
      --tol 0.5 \
      --bptt 12 \
      --validate
    ```
    * During the training, you will see messages such as log-likelihood and [perplexity](https://en.wikipedia.org/wiki/Perplexity).
    If the model is correct, the model perplexity should be decreasing and the log-likelihood should be increasing.
    * When the model converges, your `log-likelihood` on the validation data should be larger than `-250`.
* To sort a number sequence, the trained RNN model first reads the number sequence and the special token `<sort>`.
Then it greedily searches for the most likely number (from 0 to 9) one by one until the 5 numbers are generated.
    * Complete the `sort_number_sequence` in the `src/run_rnn_model_for_sorting_numbers` to implement this greedy search algorithm.
* Run the following command to test the model and the greedy search
    ```bash
    python3 -m src.run_rnn_model_for_sorting_numbers \
      --inmodel sorting_numbers_model.pkl \
      --vocabfile data/sorting_numbers/vocab
    ```
    * Enter `5 4 3 1 2` and `9 8 7 6 5`. The trained model should be able to correctly sort these two sequences.
    * Try some other number sequences of length 5. Even if the model converges to a relatively low perplexity, it may still fail soring the number properly.
     Discuss what kind of errors the model usually makes.

## Task 4: Character-level RNN model for language generation
In this task, we will train a character-level RNN language model and use it to generate character sequences.
The trained language model can predict next characters given the previous characters.

### Steps
* Take a look at the data under `data/tinyshkespeare`. For this problem, a training sample looks like
    ```bash
    r a t c l i f f : <sep> m y <sep> l o r d ?
    ```
    * Each word is split into characters with space between neighboring characters.
    * Words are separated by the special token `<sep>`.
* To train an character-level RNN language model, run the following command
    ```bash
    python3 -m src.train_rnn_model \
      --trainfile data/tinyshakespeare/train.txt \
      --validfile data/tinyshakespeare/valid.txt \
      --vocabfile data/tinyshakespeare/voc.txt \
      --init-alpha 0.01 \
      --init-range 0.05 \
      --batchsize 20 \
      --nhidden 64 \
      --outmodel character_lm_model.pkl \
      --tol 0.5 \
      --bptt 10 \
      --validate
    ```
    * When the model converges, `perplexity` on the validation data should be less than `6.15`.
* In Task 3, we generate the sorted number sequence by searching for the "most" likely number at each time step.
Here, we use another approach to generate sequences using the trained RNN model, i.e., sampling from the 
probability distribution over characters estimated by the RNN model.
    * Complete the `generate_sentence` in the `src/run_rnn_model_for_character_lm` to implement this sampling algorithm.
* Run the following command to test the model and the sampling algorithm
    ```bash
    python3 -m src.run_rnn_model_for_character_lm \
      --inmodel character_lm_model.pkl \
      --vocabfile data/tinyshakespeare/voc.txt
    ```
    * It is harder to predict a character than a number in Task 2 as suggested by the higher perplexity.
    Nevertheless, you should still be able to see some meaningful word and phrases in the generated sentence.

## Lab Checkoff
* Task 1: Show the output of your Python codes.
* Task 2: Show your test output by running `rnn_unit.py` and `rnn_model.py`.
* Task 3: Using your trained model, show 5 correctly sorted examples and 5 wrongly sorted examples.
* Task 4: Show some generated sentences using your trained model.

## Lab Report
* Upload `rnn_unit.py`, `rnn_model.py`, `run_rnn_model_for_sorting_number.py` and `run_rnn_model_for_character_lm.py`.
* Report the final log-likelihood and perplexity on the validation set for Task 3 and Task 4. 
* Discuss what kind of errors the model usually makes in Task 3.
