#!/usr/bin/env groovy

node {
    timestamps {
        // First stage is actually checking out the source. Since we're using Multibranch
        // currently, we can use "checkout scm".
        stage('Checkout') {
            checkout scm
            git url: 'https://github.com/PatrckBrs/Ghost-rpi.git'
        }
