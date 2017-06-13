node('RASP-004'){
    stage('Checkout') {
        git 'https://github.com/PatrckBrs/Ghost-rpi.git', branch: "master"
    }

    stage('Build') {
            sh 'docker build -t Ghost .'
    }

    stage('Clean workspace'){
        deleteDir()
    }
}
