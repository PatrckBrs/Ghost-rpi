#!groovy

def imageName = 'patrckbrs/ghost-rpi'
def swarmMaster = '192.168.0.181'
def swarmUser = 'pirate'

/* Only keep the 10 most recent builds. */
properties([[$class: 'BuildDiscarderProperty',
                strategy: [$class: 'LogRotator', numToKeepStr: '10']]])

node('RASP-004') {
	checkout scm
	sh 'echo $BRANCH_NAME'
	
	// AnsiColor
	wrap([$class: 'AnsiColorBuildWrapper']) {
   
	sh 'git rev-parse HEAD > GIT_COMMIT'
    	shortCommit = readFile('GIT_COMMIT').take(6)
    	def imageTag = "build${shortCommit}"

    	stage 'Build Container'
		// def whale = docker.build("${imageName}:${imageTag}", '--no-cache --rm .')
	    	def whale = docker.build "${imageName}:${imageTag}"
		
	stage 'Publish'
    	// Only publish if this is a merge to master
    	//stage ('Deploy') {
    	//whale.push()
    	//}
		if (env.BRANCH_NAME == 'master') {
			whale.push()
		}	
		
	stage 'Prune'
		sh "docker image prune -f"
	
	}
}
