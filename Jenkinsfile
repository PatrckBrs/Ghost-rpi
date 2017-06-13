node('RASP-004'){
    stage('Checkout') {
        git url: 'https://github.com/PatrckBrs/Ghost-rpi.git', branch: "devel"
    }

    stage('Build') {
            def app = docker.build "patrckbrs/ghost-rpi:${env.BUILD_NUMBER}"
    }

    stage('Clean workspace'){
        deleteDir()
    }
}
