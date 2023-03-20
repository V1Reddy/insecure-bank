def latest_fpr = ''

pipeline {
    agent any
    parameters {
        string(name: 'APPLICATION_NAME', defaultValue: '', description: 'Name of the application used for scanning.')
        choice(name: 'APPLICATION_TYPE', choices: ['WEB', 'API', 'MS', 'BE'], description: 'Type of the application that was scanned.')
        string(name: 'ARTIFACT_NAME', defaultValue: '', description: 'Source alias of the artifact used for scanning. \
        This value can be left empty if a CI pipeline is being used.')
        string(name: 'DEV_PROJECT_NAME', defaultValue: '', description: 'Name of the DEV project as shown on Fortify.')
        string(name: 'DEV_STAGE', defaultValue: '', description: 'Name of the development stage')
        string(name: 'LATEST_PROJECT_NAME', defaultValue: '', description: 'Name of the UAT (latest) project as shown on Fortify.')
        string(name: 'LATEST_STAGE', defaultValue: '', description: 'Name of the UAT (latest) stage')
        string(name: 'MAP_ID', defaultValue: '', description: 'MAP ID of the application')
    }

    stages {
        stage ('Fortify merge') {
            steps {
                echo "In the fortify merge"

                script {                                
                    // Version of the DEV project
                    def dev_projectVersion = "${params.MAP_ID}-${params.APPLICATION_TYPE}-${params.APPLICATION_NAME}_${params.DEV_STAGE}"

                    //Version of the UAT (latest/release) project
                    def latest_projectVersion = "${params.MAP_ID}-${params.PPLICATION_TYPE}-${params.APPLICATION_NAME}_${params.LATEST_STAGE}"

                    // Set location for the UAT (latest/release) FPR
                    latest_fpr = "${env.WORKSPACE}/${latest_projectVersion}.fpr"
                }
                echo "latest_fpr -> ${latest_fpr}"

                // Download FPR from DEV project and re-name it to Latest FPR
                echo 'In the download FPR block...'

                // Upload DEV FPR to UAT latest Project
                echo "### Starting DEV FPR upload to UAT (latest) Project ###"

                // Delete temporary merged FPR from the workspace
                sh "rm '${latest_fpr}' "
            }
        }
    } 
}
