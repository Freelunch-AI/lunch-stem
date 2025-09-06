# EE596 [Spring 2019] Lab 3 -- MTurk Data Collection (Crowdsourcing)

Course Webpage: [EE596 Spring 2019-- Conversational Artificial Intelligence](https://hao-cheng.github.io/ee596_spr2019/)

## Task 0: Mid-quarter course evaluation (required)
Please fill out the [mid-quarter evaluation form](https://forms.gle/gQiMgMo7yKoZVmHq8). The responses are anonymous, but we count how many responses we get. Everyone will get credit for this part once we see that we've had enough responses.

__________________

An important step in nowadays data-driven systems is data collection.
In this lab, we will go through basic data collection steps on [Amazon Mechanical Turk](https://www.mturk.com/).

## Task 1: Create a toy Human Intelligence Task (HIT)
In this task, we will create a toy HIT.

* Sign up for an MTurk Sandbox account [here](https://requestersandbox.mturk.com).
The "Sandbox" mode is a test version of the MTurk marketplace.
You can use it to test publishing and completing tasks without paying any money.
* Create a toy project using the customizable template `Intent Detection`
  following this [walkthrough](https://hao-cheng.github.io/ee596_spr2019/slides/lab_3-walkthrough.pdf).

## Task 2: Create a HIT for response selection
In this task, we create a new HIT for selecting the best response given a conversation history.
This HIT is an example of data collection setup for training response retrieval/ranking models.
We use data from [DSTC7 -- Noetic End-to-End Response Selection Challenge](https://ibm.github.io/dstc7-noesis/public/index.html).
These conversations simulate discussions between a student and an academic advisor who guides the student to pick
courses that fit not only their curriculum, but also personal preferences about time, difficulty, areas of interest, etc.

* Create a new HIT using the project name `Response Selection`. 
* In `Edit Properties`, set the `Number of assignemnts per task` to the number
  of members in your team.
  For simplicity, you can use the default values for other fields.
  For a real task, you need to carefully write the descriptions and configure
  the HIT.
* In `Design Layout`, edit the `crowd-classifier` element.
```
    <!-- The crowd-classifier element will create a tool for the Worker to select the
           correct answer to your question -->
    <crowd-classifier 
        categories="['${candidate0}', '${candidate1}', '${candidate2}', 'None of the above']"
        header="Which one is the best response for the advisor?"
        name="response">

        <!-- Your conversations will be substituted for the "conversation" variable when 
               you publish a batch with an input file containing multiple HTML-formatted conversations. -->
        <classification-target> ${conversation} </classification-target>

        <!-- Use the short-instructions section for quick instructions that the Worker
              will see while working on the task. Including some basic examples of 
              good and bad answers here can help get good results. You can include 
              any HTML here. -->
        <short-instructions> Which response is the best for the advisor? </short-instructions>

        <!-- Use the full-instructions section for more detailed instructions that the 
              Worker can open while working on the task. Including more detailed 
              instructions and additional examples of good and bad answers here can
              help get good results. You can include any HTML here. -->
        <full-instructions header="Response Selection Instructions">
            <h2>Select the best response for the advisor based on the conversation history.</h2>
        </full-instructions>

    </crowd-classifier>
```
* When publishing a new batch, use the data file `lab3_data.csv` in this repository. There are 20 entries in this file.
* Find the published HIT in [Workers Sandbox](https://workersandbox.mturk.com) and annotate the task.
* Everyone in the team should annotate all 20 entries. Make sure you have
  correctly set the `number of assignemnts per task`.
* Compute [Cohen's kappa](https://en.wikipedia.org/wiki/Cohen%27s_kappa) for
  collected annotations. You can use annotations from two selected members in
  your team. 
* (Optional) You can also compuate [Fleiss' kappa](https://en.wikipedia.org/wiki/Fleiss%27_kappa).
* Question: Is there any issue you noticed in the data collection? How will you
  improve?

## Task 3: Create a HIT for your project
In this task, you need to design and create a HIT for your project.
You can use existing templates and modify them based on your need.
For example, you can modify the `Collect utterance` template to get some
initial conversation data for your project.

## Optional: [ParlAI](https://parl.ai/)
As you probably notice, the data annotation so far is pretty restricted or
simple. Specifically, all the tasks so far focus on collecting one turn
information either intent or selection of a subsequent turn.  In some cases, you might want to
collect multi-turn dialogs. It actually requires some work to adjust the
interface to accomondate this. One particular tool might be useful for
facilating this is [ParlAI](https://parl.ai/).  If you need more complex data
collection for your project, please explore how to leverage this toolkit for
data collection. For instance, you can look into how to collect a [persona-based conversation](https://github.com/facebookresearch/ParlAI/tree/master/parlai/mturk/tasks/personachat).


## Lab Checkoff
* Task 0: fill out the [mid-quarter evaluation](https://forms.gle/gQiMgMo7yKoZVmHq8) (anonymous, but we can count the number of responses)
* Task 2 & 3: Show the HITs your created.
* Explain how the Kappa Coefficient is computed in Page 24 of [walkthrough](https://hao-cheng.github.io/ee596_spr2019/slides/lab_3-walkthrough.pdf).


## Lab Report
* Task 2: 1) upload collected annotations, 2) report inter-annotator agreement, 3) discuss HIT design issues in this task.
* Task 3: describe the HIT you designed for your course project
