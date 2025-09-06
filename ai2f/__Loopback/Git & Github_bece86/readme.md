//////////// fazendo pela gui do vs code :

// vai no icone do github na esquerda clica nela depois em initialize repository

// ai da cntrl + shift + p  e pesquisa git remote e adiciona o repositorio e o nome (geralmente origin)

// ai volta na aba do git, aperta nos tres pontinhos e dda o push

// ai depois quando agente soh for atulizar eh soh apertar no check(commit) depois nos tres pontinhos(push)

/////////////////////////////

// initialize a folder as a gitrepository:
>> git init

// configure
>> git config --global user.name 'BrunoScaglione'
>> git config --global user.email 'bruno.c.scaglione@gmail.com'

// add to the staging area 
>> git add [file or folder]

// see your current staging area
>> git status

// remove from staging area 
>> git rm --cached [file or folder]

// adds any html file 
>> git add *.html 

// add everything
>> git add .

//if we change a file/folder and then: run git status .It will appear to be modified
// we have to add again

// commit things in stage area to repository
>> git commit -m 'our comment'

// .gitignore is a file we can create.
// Every other file we put inside .gitignore git will ignore and not add 

//branches:
// we can commit things to branches to no affect the things in master branches
// so in different branches we can have different versions that different people can work on 
// without affecting each others works
>> git branch mybranchname
// and to enter the brach we just created
>> git checkout mybranchname
// go back to master
>> git checkout master


// create remote repository on github:
//go to github and create repository,
//for example i created testingre//pository:
then add to your remote repositories
>> git remote add [name(usually origin)] https://github.com/BrunoScaglione/testingrepository.git
// to see remote repositories:
>> git remote 
// to send all commits to github repository:
>>git push -u origin master
// pra fazer o login

// and then after we have it as a remote repository just:
>> git push

// to clone a project from github(cria pasta com todos os arquivos do repositorio no seu pc)
>> git clone [repository link]

//to change origin url  for another project:
>> git remote set-url origin [new url]


// discard uncommitted changes

// This will unstage all files you might have staged with git add:
>> git reset
// This will revert all local uncommitted changes (should be executed in repo root):
>> git checkout .

Yet another way to revert all uncommitted changes (longer to type, but works from any subdirectory):

>> git reset --hard HEAD


The purpose of gitignore files is to ensure that certain files not tracked by Git remain untracked.

To stop tracking a file that is currently tracked, use 
>> git rm --cached src/main_ws/install src/main_ws/log src/main_ws/build

Conficts:

when in conflicted sate already:
>> git checkout --ours/--theirs

to merge with preference
>> git merge master --ours/--theirs pra jah dar o merge com a preferencia

force push (force remote to be like your local)
>> git push -f origin master

get updates from remote (like new branches)
>> git fetch
