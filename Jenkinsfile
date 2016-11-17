#!groovy

node {
       stage "Preparation du Container"
       checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/PatrckBrs/Ghost-rpi.git']]])
       dockerNode(image: 'patrckbrs/rpi-jenkins-docker-image-slave:latest', sideContainers: ['']) {
            stage 'Checkout'
            checkout scm
                // TEST 
            stage 'Test'
            sh ls -l
        } 
}
