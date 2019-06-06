# Why DevOps Is Useful

<hr/>

## What is DevOps

DevOps is a way of handline the lifecycle of an application. It stics with the project from the minute the code base is created all the way through the to tenth release of production code. It combines two teams that are kept separate traditionally. The development team and the operations team combine into one.

## Why DevOps exists

DevOps makes the server-side part of the application a little more friendly to work with. Once you've built your build and deploy piplines, your code will go through the tests and deploy to the develop or production environment automatically and you don't have to do anything or talk to anyone. Having that kind of access changes the way companies handle their software. It takes some time to get used to, but it's worth the investment.

## How DevOps works

Just like with everything else in web development, there are best practices for working DevOps. They outline the things you need to implement to be fully into DevOps.

- **_Continuous integration:_** This means that every time you commit code and it gets merged into a main branch, it will go through the automated tests you set up. Any unit tests you have written will be run here. If the commit passes testing then it will merged with the main branch. If it doesn't then you'll get an email telling you it failded. After you get past the tests, a build will automatically be run for you.
- **_Continuous delivery:_** Once you have a build ready, this part will take that build and automatically deploy it. It's usually the next step after conitnuous integration. You can set it to deploy the build directly to the development or production enviroment. This part mainly automates the deploys for you.
- **_Monitoring_**: After your application has been deployed automatically, you might have certain statistics you need to watch. Memory usage is a big one and so is the number of users accessing the application. Monitoring makes sure that you can get to the cause of server problems and unexpected behavior.

<hr/>

Get more information at [here](https://dev.to/flippedcoding/why-devops-is-useful-4d5k).
