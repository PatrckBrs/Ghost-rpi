#!groovy

def imageName = 'patrckbrs/ghost-rpi'

/* Only keep the 10 most recent builds. */
properties([[$class: 'BuildDiscarderProperty',
                strategy: [$class: 'LogRotator', numToKeepStr: '10']]])

node('RASP-004') {
    checkout scm

    // AnsiColor
    wrap([$class: 'AnsiColorBuildWrapper']) {
    // Just some echoes to show the ANSI color.
    stage "\u001B[31mI'm Red\u001B[0m Now not"

    /* Using this hack right now to grab the appropriate abbreviated SHA1 of
     * our current build's commit. We must do this because right now I cannot
     * refer to `env.GIT_COMMIT` in Pipeline scripts
     */
    sh 'git rev-parse HEAD > GIT_COMMIT'
    shortCommit = readFile('GIT_COMMIT').take(6)
    def imageTag = "build${shortCommit}"

    stage 'Build Container'
    def whale = docker.build("${imageName}:${imageTag}", '--no-cache --rm .')
	
    stage 'Deploy'
    whale.push()
}
