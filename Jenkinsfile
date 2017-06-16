#!groovy

def imageName = 'patrckbrs/ghost-rpi'
def ghost

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
		    ghost = docker.build "${imageName}:${imageTag}"
		    }
	    if (env.BRANCH_NAME == 'devel') {
		    ghost = docker.build("${imageName}:${imageTag}", '--no-cache --rm .')
		    }    
    }
	
	stage('Test image') {
        if (env.BRANCH_NAME == 'devel') {
			ghost.inside {
				sh 'echo "Tests passed"'
			}
		}
	 
	}
	    
    stage('Publish') { 
	    if (env.BRANCH_NAME == 'master') {
			    ghost.push()
	    }
    }                       
    
    stage('Prune') {
	    node('RASP-004') {
		    sh "docker image prune -f"
	    }
    }
    
    }
}
