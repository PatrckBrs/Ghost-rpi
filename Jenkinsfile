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
	    if (env.BRANCH_NAME == 'master') {
		    def ghost = docker.build "${imageName}:${imageTag}"
		    }
	    if (env.BRANCH_NAME == 'devel') {
		    def ghost = docker.build("${imageName}:${imageTag}", '--no-cache --rm .')
		    }    
    }
	    
    stage('Publish') { 
	    if (env.BRANCH_NAME == 'master') {
		    docker.withRegistry('', 'a5c2ed42-3bac-4c07-a024-e157f89c5600') {
			    ghost.push()
			    ghost.push("latest")
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
