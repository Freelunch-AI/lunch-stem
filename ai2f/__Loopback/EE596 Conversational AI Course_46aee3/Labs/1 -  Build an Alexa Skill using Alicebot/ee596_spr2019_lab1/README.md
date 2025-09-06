# EE596 Lab 1 -- Building an Alexa Skill using Alicebot

Course Webpage: [EE596 Spring 2019-- Conversational Artificial Intelligence](https://hao-cheng.github.io/ee596_spr2019/)

In this lab, you're going to have a general overview of the front-end, middle-end and back-end of a conversational AI system.
For Task 1, you're going to set up your local back-end database.
For Task 2, you're going to set up the middle-end which is the core part responsible for language understanding, dialog management and language generation.
Also, you could use a text-based front-end to talk with the bot server which would only echo back your inputs.
For Task 3, you're going to replace the echobot with Alicebot.
For Task 4, you're going to set up the voice-based front-end through the Amazon Alexa skill.

## Task 1: Set up an local DynamoDB sever 
- Follow the instruction [here](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.DownloadingAndRunning.html) to set up a local DynamoDB server.
DynamoBD is basically a scalable database which can be used for storing either conversation history or content.
For Lab 1, only the conversation history is stored in DynamoDB.


## Task 2: Set up an Echobot server
### Requirements
* Python >= 3.6
* virtualenv

### Steps
* Create a virtual environment and install required libraries.
```
$ virtualenv virtenv --python=python3
$ source virtenv/bin/activate
$ pip install -r requirements.txt
```

* First, adds two files `~/.aws/config`
```
[default]
region=us-west-2
```
and `~/.aws/credentials`
```
[default]
aws_secret_access_key = fakeSecretAccessKey
aws_access_key_id = fakeMyKeyId

```

* Launch the Echobot server.
```
$ source virtenv/bin/activate
$ cd src
$ python echobot_server.py
```

* Talk to the Echobot through the console. Enter "stop" to end the conversation.
```
$ source virtenv/bin/activate
$ cd clients
$ python console_client.py --logdir $LOGDIR
```
Notice the echobot simply echoes back whatever you input.

## Task 3: Replace the Echobot with an Alicebot.
In this task, you need to use Alicebot for generating bot responses.
You can directly edit the file `src/bots/echobot/bot.py`. 
Alternative, you can create a new folder `src/bots/alicebot` for the Alicebot and create a new `src/alicebot_server.py` file to
launch the server.

Please install [Python-AIML](https://github.com/paulovn/python-aiml) and read the documents for creating an Alicebot.
Specifically, make sure you take a look at
```python-aiml/aiml/script/bot.py```
and see whether you can talk with Alicebot interactively use that file.

For this lab, please try to bootstrap the AIML kernel using a brain file (This
is a binarized file which can be read quickly from the disk). In other words, you
could dump the bootstrapped conversations in binary file.

Here are a few rounds of interactions with the Alicebot through the console.
If you want, you can also replace the `Bot Reprompt`.
```
======== Round Index: 1 ========
Bot Utterance:  Hi there!
Bot Reprompt:  TBD
User Utterance: how are you
======== Round Index: 2 ========
Bot Utterance:  My logic and cognitive functions are normal.
Bot Reprompt:  TBD
User Utterance: what's your name
======== Round Index: 3 ========
Bot Utterance:  My name is Nameless.
Bot Reprompt:  TBD
User Utterance: do you like to chat
======== Round Index: 4 ========
Bot Utterance:  Talking is my primary function.
Bot Reprompt:  TBD
User Utterance: 
```

## Task 4: Create an Alexa Skill
In this task, you will create an Alexa Skill that uses the Alicebot server on your laptop as the endpoint.
In this way, you enable voice-based interactions for the Alicebot.

### Requirements
* [ngrok](https://ngrok.com/)
* [Amazon Skill Kit](https://developer.amazon.com/alexa-skills-kit)

### Steps
- Register an account for [ngrok](https://ngrok.com) and install ngrok on your laptop.
- Expose your local server (port 8080) to the internet using ngrok
```
$ ngrok http 8080
```
- Create an Amazon developer account [here](https://developer.amazon.com/) and follow the [walkthrough](https://hao-cheng.github.io/ee596_spr2019/slides/lab_1-walkthrough.pdf).

## Lab Checkoff
* Chat with the Alicebot using both the Console and the Echo dot.

## Lab Report
* Upload your codes in `src/` as a zip file.
* Paste some sample dialogues you had with the Alicebot.
* Discuss the strength and weakness of the Alicebot.

