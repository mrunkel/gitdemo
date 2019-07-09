# Docker Image Shell Project

Use this project to create a docker project @ plusForta.  

1. Check out this repo.
1. run ```mknew <project>```
1. ```cd ../<project>```
1. edit the Dockerfile for your project needs
1. edit the Jenkinsfile to remove the line ```error('BUILD NOT CONFIGURED') // remove this line```
1. update this readme (remove this section, update What's included below)

## What's included

*update this section for your Image*

## Additional files

You can use ./checkJenkins.sh to lint your Jenkinsfile before commit.

You need to create a .env file with the following variables:

## How this works..

In a nutshell, when you commit any changes to this repo, the jenkins server
is notified via webhook from the bitbucket server.

The jenkins server:
* checks out the repository
* Executes the Jenkinsfile
  * starts a docker container with docker tools
  * inside the docker container
    * starts a docker build of ./Dockerfile
      * Pulls the official docker PHP library
      * adds the specified changes
      * tags the new image and sends it to dock.pfdev.de
* Reports the build status back to bitbucket
