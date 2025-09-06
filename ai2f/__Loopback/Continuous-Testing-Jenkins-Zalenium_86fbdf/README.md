# DevOps Playground Edinburgh: Continuous Testing with Jenkins and Zalenium

![](images/zalenium.png)

## What is already installed on your VM?

In order to get the most out of this session we have pre-installed some components onto the VM. Here is how we created the VMs along with some further reading.

- These are Azure hosted. We created the first VM (with Ubuntu 16.04 OS) using Azure Portal and then used Azure CLI to clone the VM - https://docs.microsoft.com/en-us/azure/virtual-machines/linux/copy-vm
- We installed Java using these instructions - https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04
- We installed Jenkins using these instructions- https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-16-04

## Accessing Your Jenkins Instance

1. Jenkins has already been installed and is up and running on your VM. To access Jenkins use the following URL: [http://{yourVmIp}:8080](http://yourVmIp:8080)
2. To log in to Jenkins, use the following credentials:

Username: `DevOps`  
Password: `Playground`

## Creating a Jenkins Pipeline

1. Navigate back to the Jenkins Dashboard and click on the **Create New Jobs** link.
2. In the 'Enter an item name' at the top of the page name it something sensible, like: `zalenium-pipeline`.
3. Select the **Pipeline** option from the options below.
4. Click on the **OK** button at the bottom of the page.

![](images/creatingPipeline.png)

We are now presented with the Jenkins Pipeline configuration page.

## Editing Your Jenkins Pipeline to Checkout Code and Install Dependencies

For the purposes of this evening's Playground we will be editing our pipeline script in the Pipeline script editor in the Jenkins UI.  
**Please note** that better practice would be to have a 'Jenkinsfile' in a repository. This would put your Pipeline script under version control meaning you can track changes and revert to previous versions of the script.  
More information can be found here: https://jenkins.io/doc/book/pipeline/jenkinsfile/  

1. Select the **Pipeline** option in the toolbar at the top of the page.  
![](images/pipelineButton.png)  

2. In the Pipeline editor paste in the following code:

```
pipeline {
    agent any
    tools {nodejs 'node'}
    stages {
        stage('Code and Dependencies'){
            parallel{
            stage('Checkout Code'){
                steps{
                    git 'https://github.com/ecsdigital/devopsplayground-edi-9-zaleniumci.git'
                }
            }
            stage('Install Dependencies'){
                steps{
                    sh 'npm install'
                    sh 'npm install wdio-allure-reporter --save-dev'
                    sh 'npm install -g allure-commandline --save-dev'
                    sh 'docker pull elgalu/selenium'
                    sh 'docker pull dosel/zalenium'
                }
            }
        }
        }
    }
}
```

3. Once the code has been pased in then press the **Save** button at the bottom of the page.

![](images/pipelineEdit.png)

## Running Your Jenkins Pipeline

1. On the left hand menu, select **Open Blue Ocean**.

2. A pop-up will appear telling you that the job has not been run. Press the **Run** button.

![](images/run.png)

3. Refresh the page and you should see the first run of your Pipeline running.If you click on the job then you will see a visualisation of your Pipeline.

![](images/blueOcean1.png)

4. The first run will take a bit longer as NodeJS is unpacked on your Jenkins VM and the Zalenium and Selenium Docker images are pulled. After a few minutes, all stages of the Pipeline should be green indicating a success!

## Extending the Pipeline

We now have our Pipeline installing dependencies and checking out the test code from a Git repo in preparation for our tests being run. We now want to add Zalenium into the mix.

1. From **Blue Ocean** select the configure icon from the top right-hand side of the screen. This will take us back to the Pipeline editor view.

 ![](images/cog.png)

2. We want to add a Pipeline stage for starting Zalenium and running our tests. Paste the following code into the Pipeline editor:  

```
pipeline {
    agent any
    tools {nodejs 'node'}
    stages {
        stage('Code and Dependencies'){
            parallel{
            stage('Checkout Code'){
                steps{
                    git 'https://github.com/ecsdigital/devopsplayground-edi-9-zaleniumci.git'
                }
            }
            stage('Install Dependencies'){
                steps{
                    sh 'npm install'
                    sh 'npm install wdio-allure-reporter --save-dev'
                    sh 'npm install -g allure-commandline --save-dev'
                    sh 'docker pull elgalu/selenium'
                    sh 'docker pull dosel/zalenium'
                }
            }
            }
        }
            stage ('Start Zalenium'){
                steps{
                    sh 'docker run --rm -ti --name zalenium -d -p 4444:4444 -e PULL_SELENIUM_IMAGE=true -v /var/run/docker.sock:/var/run/docker.sock -v /tmp/videos:/home/seluser/videos --privileged dosel/zalenium start'
                }
            }
            stage ('Run Tests'){
                steps{
                    sh './node_modules/.bin/wdio wdio.conf.js'
                }
            }
            stage ('Stop Zalenium'){
                steps{
                    sh 'docker stop zalenium'
                }
            }
    }
}
```

You can see that two stages have been added to the pipeline.   

**Start Zalenium** which uses our Zalenium start command from the last Playground.  
**Run Tests** which will start our NodeJS tests.  
**Stop Zalenium** which will tear down the Zalenium container at the end of the test run.

3. After pasting in this script, press **Save**.

4. Select **Open Blue Ocean** from the left-hand side menu.

5. Press the **Run** button after opening **Blue Ocean**.

 ![](images/runBO.png)

You can view the Pipeline being run in Blue Ocean as before. At the end of the run your Blue Ocean should look similar to this:

 ![](images/stage2Run.png)

 You can also view your tests being run by accessing: [http://{yourVmIp}:4444/grid/console](http://yourVmIp:4444/grid/console)

## Reporting Using Allure

We now have tests running in Jenkins using Zalenium as our Grid. Now we want to add some test reports using Allure -  http://webdriver.io/guide/reporters/allure.html.

We have already completed the first part of adding Allure to our WebDriver.io config but now we need to add the Allure step into our Jenkins pipeline to display our reports within Jenkins.

1. From **Blue Ocean** select the configure icon from the top right-hand side of the screen. This will take us back to the Pipeline editor view.

2. Paste in the following Groovy script to your Pipeline Editor:

```
pipeline {
    agent any
    tools {nodejs 'node'}
    stages {
        stage('Code and Dependencies'){
            parallel{
            stage('Checkout Code'){
                steps{
                    git 'https://github.com/ecsdigital/devopsplayground-edi-9-zaleniumci.git'
                }
            }
            stage('Install Dependencies'){
                steps{
                    sh 'npm install'
                    sh 'npm install wdio-allure-reporter --save-dev'
                    sh 'npm install -g allure-commandline --save-dev'
                    sh 'docker pull elgalu/selenium'
                    sh 'docker pull dosel/zalenium'
                }
            }
            }
        }
            stage ('Start Zalenium'){
                steps{
                    sh 'docker run --rm -ti --name zalenium -d -p 4444:4444 -e PULL_SELENIUM_IMAGE=true -v /var/run/docker.sock:/var/run/docker.sock -v /tmp/videos:/home/seluser/videos --privileged dosel/zalenium start'
                }
            }
            stage ('Run Tests'){
                steps{
                    sh './node_modules/.bin/wdio wdio.conf.js'
                }
            }
            stage ('Generate Allure Reports'){
                steps{
                    allure([
                        includeProperties: false,
                        jdk: '',
                        properties: [],
                        reportBuildPolicy: 'ALWAYS',
                        results: [[path: 'allure-results']]
                    ])
                }
            }
            stage ('Stop Zalenium'){
                steps{
                    sh 'docker stop zalenium'
                }
            }
    }
}
```

3. After pasting in the script press **Save**.

4. Select **Open Blue Ocean** from the left-hand side menu.

5. Press the **Run** button after opening **Blue Ocean**.

6. Once the run is complete, your Pipeline should look like the following:

 ![](images/stage3Run.png)

7. To access the **Allure** reports, select the **Go To Classic** button at the top right-hand side of the screen.

 ![](images/classic.png)

 8. You are now presented with a list of the **Build Artifacts** in the classic Jenkins view. Select the Allure Report button.

 ![](images/allureReport.png)

 9. You can now see the HTML report that **Allure** has generated. This provides you with the results of each test in multiple different formats.
