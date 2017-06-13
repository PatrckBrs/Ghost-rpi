node('RASP-004'){
    stage('Checkout') {
        git url: 'https://github.com/PatrckBrs/Ghost-rpi.git', branch: "master"
    }

    stage('Build') {
            def app = docker.build "patrckbrs/ghost-rpi:${env.BUILD_NUMBER}"
    }

    stage('Clean workspace'){
        deleteDir()
    }
}
