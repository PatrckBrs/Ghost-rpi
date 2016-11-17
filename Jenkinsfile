#!groovy

node {
       stage "Preparation du Container"
       docker.image('patrckbrs/rpi-jenkins-docker-image-slave:latest').inside {
            stage 'Checkout'
            checkout scm
                // TEST 
            stage 'Test'
            sh ls -l
        } 
}
