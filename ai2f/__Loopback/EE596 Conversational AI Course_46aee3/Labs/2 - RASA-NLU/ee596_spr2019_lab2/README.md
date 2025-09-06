# EE596 [Spring 2019] Lab 2 -- Spoken Language Understanding

Course Webpage: [EE596 Spring 2019-- Conversational Artificial Intelligence](https://hao-cheng.github.io/ee596_spr2019/)


## Task 1: Train and evaluate a RASA-NLU model
In this task, we will train and evaluate a RASA-NLU model for intent detection and slot filling. 
For this task, we use the ATIS dataset, which is a widely used dataset in spoken language understanding research.
The specific setup used here comes from this [repository](https://github.com/MiuLab/SlotGated-SLU), which is used in
the paper ["Slot-Gated Modeling for Joint Slot Filling and Intent Prediction"](https://aclweb.org/anthology/N18-2118).

* First, we need to install the RASA-NLU library in a virtual environment.
You can either create a new `virtenv` folder using Python2 or reuse the Python3.6 `virtenv` from [Lab 1](https://github.com/hao-cheng/ee596_spr2019_lab1).
```
source virtenv/bin/activate
pip install rasa_nlu
```

If you get an error about "Failed building wheel for Twisted", please make sure
you have installed `python3.6-dev` package by running the following commands on
Ubuntu.
```
sudo apt-get update
sudo apt-get install python3.6-dev
```

* RASA-NLU has different components for recognizing intents and entities.
Specifically, we use the `spacy_sklearn` pipeline.
```
pip install rasa_nlu[spacy]
python -m spacy download en_core_web_md
python -m spacy link en_core_web_md en
```

Specific to Mac + Python 3: If you get an error about failed certificate verification (ssl.SSLError), you can update it by running:
```
/Applications/Python\ 3.6/Install\ Certificates.command
```

* Read the [Training Data Format](https://rasa.com/docs/nlu/dataformat/) to understand different data formats you can use for training RASA-NLU models.
For your convenience, we have converted the ATIS dataset into `json` files in the folder `atis_json`.

* Train a RASA-NLU model. In the folder `ee596_spr2019_lab2`, run
```
python -m rasa_nlu.train \
  -c ./rasa_nlu_config.yml \
  --data ./atis_json/train.json \
  -o models \
  --project current \
  --verbose
```
  
* Q1: How many distinct intents and slots (entities) are there in the training set? You should see the numbers reported from the output. 
* Q2: In Section 3.1 of the [paper](https://aclweb.org/anthology/N18-2118), it says there are 120 slot labels in the training data. Why it is not the same as the number of distinct entities?

* Evaluate the RASA-NLU model. (`${MODEL_NAME}` is the model produced from the training step above.) 
```
echo "backend: Agg" > ./matplotlibrc
python -m rasa_nlu.evaluate \
  --mode evaluation \
  --data atis_json/test.json \
  --model models/current/${MODEL_NAME} \
  --report report/ \
  --successes report/succcess.json \
  --errors report/errors.json \
  --histogram report/hist.png \
  --confmat report/confmat.png
```

Check the `report/intent_report.json` intent detection results and `report/ner_crf_report.json` for slot filling results. 


* Q3: Report and discuss the model performance on intent detection and slot filling. You should also examine the confusion matrix `confmat.png` for analysis. For this lab, you do not need to compare your restuls with those in the
  [paper](https://aclweb.org/anthology/N18-2118).
  See [Entity Scoring](https://rasa.com/docs/nlu/evaluation/#entity-scoring)
  to understand how scores are computed for slot filling.


## Task 2: Compare different RASA-NLU pipelines
* Follow the instructions in [Choosing a RASA-NLU Pipline](https://rasa.com/docs/nlu/choosing_pipeline/) to try several different configurations.
Please try at least two different pipelines in addition the `spacy_sklearn` in Task 1.
* Report and discuss results for different configurations.

## Task 3: Set up a RASA-NLU server to host the model
To allow a bot to use the trained RASA-NLU models, we can run a HTTP server to host the RASA-NLU model. The server acts as an API and the bot can send user utterances to to the server to obtain NLU results.
* See [Server Configuration](https://rasa.com/docs/nlu/config/) for advanced configuration. For this lab, you can simply use the following command in the `ee596_spr2019_lab2` directory.
```
python -m rasa_nlu.server --path models --pre_load current
```
This command launches a server that listens to the port 5000.

* To test your server, you can send a POST request and see the returned results.
```
curl -XPOST localhost:5000/parse -d '{"q":"i want to fly from seattle to dallas round trip", "project":"current"}'
```

## Task 4: Integrate the best NLU model in an IntentBot
In this task, you will create a bot that is similar to the Echobot in Lab 1. This new bot, called "IntentBot", tells the recognized intent and the number of recognized entities. The goal of this task is to let you understand how to query the RASA-NLU server in Python and parse the returned JSON object.

* First, review the codes in `src/bots/intentbot/bot.py` (Line 106 -- 120) to understand how the bot response is constructed.
* Then, complete the missing codes in `src/bots/intentbot/rasa_nlu_annotate.py` for querying the RASA-NLU server. You can use [requests](http://docs.python-requests.org/en/master/user/quickstart/) library for querying RASA-NLU server through HTTP.
* Follow the instructions in Lab 1 Task 1--2 to talk with the IntentBot.



## Lab Checkoff 
* Chat with the IntentBot for several rounds. You can use utterances in the ATIS dataset.

## Lab Report
* Task 1: Answer Q1--Q3.
* Task 2: Report and discuss your results for the configurations you tried.
* Task 4: Upload your `src/bots/intentbot/rasa_nlu_annotate.py`.
