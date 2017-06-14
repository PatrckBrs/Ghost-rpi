#!groovy

def imageName = 'patrckbrs/ghost-rpi'
def swarmMaster = '192.168.0.181'
def swarmUser = 'pirate'

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
	   // def whale = docker.build("${imageName}:${imageTag}", '--no-cache --rm .')
	    def whale = docker.build "${imageName}:${imageTag}"
    }
    
    stage('Publish') { 
    // Only publish if this is a merge to master
    //stage ('Deploy') {
    //whale.push()
    //}
	if (env.BRANCH_NAME == 'master') {
	    whale.push()
	    }
    }
	   
    stage('Prune') {
		    sh "docker image prune -f"
    }

	stage('UpdateService') { 
		if (env.BRANCH_NAME == 'master') {
			sshagent(['33db902e-b5fc-4b78-bd46-dc6f10ef4f42']) {
				sh "ssh -o StrictHostKeyChecking=no -l ${swarmUser} ${swarmMaster} docker service update ghost --image ${imageName}:${imageTag}"
			}	
		}
	}
	   
    
    
    }
}
