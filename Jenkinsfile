pipeline {
  agent {
    docker {
      image 'docker'
    }
  }
  options {
    timeout(time: 10, unit: 'MINUTES')
    buildDiscarder(logRotator(numToKeepStr:'4'))
  }
  environment {
    containerRegistry='dock.pfdev.de'
    serviceName='plusforta'
    optionalImageName='test'
  }
  stages {
    stage('Build and Push Docker Image'){
      steps{
        error('BUILD NOT CONFIGURED') // remove this line
        script {
          def imageName = "${containerRegistry}/${serviceName}/${optionalImageName}"
          docker.withRegistry("https://${containerRegistry}/${serviceName}", "cec23a25-eb2e-4331-bb78-940508d74d39") {
              def customImage = docker.build(imageName)
              customImage.push("${BUILD_NUMBER}")
              customImage.push("latest")
              sh "docker rmi --force \$(docker images -q ${customImage.id} | uniq)"
          }
        }
      }
    }
  }
}
