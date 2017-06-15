#!groovy

def imageName = 'patrckbrs/ghost-rpi'

/* Only keep the 10 most recent builds. */
properties([[$class: 'BuildDiscarderProperty',
                strategy: [$class: 'LogRotator', numToKeepStr: '10']]])

node('RASP-004') {
    checkout scm

    // AnsiColor
    wrap([$class: 'AnsiColorBuildWrapper']) {
   	
    /* Using this hack right now to grab the appropriate abbreviated SHA1 of
     * our current build's commit. We must do this because right now I cannot
     * refer to `env.GIT_COMMIT` in Pipeline scripts
     */
    sh 'git rev-parse HEAD > GIT_COMMIT'
    shortCommit = readFile('GIT_COMMIT').take(6)
    def imageTag = "build${shortCommit}"

    stage ('Build Container') {
	    def whale = docker.build("${imageName}:${imageTag}", '--no-cache --rm .')
    }
    
    stage("Publish") { 
    // Only publish if this is a merge to master
    //stage ('Deploy') {
    //whale.push()
    //}
	    if (env.BRANCH_NAME == 'devel') {
		    docker.withRegistry('', 'DockerHub') {
			    image = docker.image(whale)
			    image.push()
		    }
	    }
    }                       
    
    stage('Prune') {
	    node('RASP-004') {
		    sh "docker image prune -f"
	    }
    }
    
    }
}
