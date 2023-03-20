def latest_fpr = ''

pipeline {
    agent any
    parameters {
        string(name: 'APP_NAME', defaultValue: 'App 1', description: 'Name of the application used for scanning')
        choice(name: 'APP_TYPE', choices: ['WEB', 'API', 'MS', 'BE'], description: 'Type of the application that was scanned')
        string(name: 'ARTIFACT_NAME', defaultValue: 'Artifact 1', description: 'Source alias of the artifact used for scanning. This value can be left empty if a CI pipeline is being used.')
        password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password')
    }

    environment {
        application_name = 'App1'
        application_type = 'AppType1'
        artifact_name = 'Artifact1'
        dev_project = 'DEV_1'
        dev_stage = 'STAGE_1'
        latest_project = 'Proj1'
        latest_stage = 'latest'
        map_id = '111'
        project_folder = 'some_folder' 
    }

    stages {
        stage ('Fortify merge') {
            steps {
                echo "In the fortify merge"

                script {                                
                    // Version of the DEV project
                    def dev_projectVersion = "${map_id}-${application_type}-${application_name}_${dev_stage}"

                    //Version of the UAT (latest/release) project
                    def latest_projectVersion = "${map_id}-${application_type}-${application_name}_${latest_stage}"

                    // Set location for the UAT (latest/release) FPR
                    latest_fpr = "${env.WORKSPACE}/${latest_projectVersion}.fpr"
                }
                echo "latest_fpr -> ${latest_fpr}"

                // Download FPR from DEV project and re-name it to Latest FPR
                echo 'In the download FPR block...'

                // Upload DEV FPR to UAT latest Project
                echo "### Starting DEV FPR upload to UAT (latest) Project ###"

                // Delete temporary merged FPR from the workspace
                // sh rm "${latest_fpr}"
            }
        }
    } 
}
