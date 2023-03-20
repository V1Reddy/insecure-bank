pipeline {
    agent any
    parameters {
        base64File 'FORTIFY_FPR'
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
                                
                // Version of the DEV project
                dev_projectVersion = "${map.id}-${application.type}-${application.name}_${dev.stage}"

                //Version of the UAT (latest/release) project
                latest_projectVersion = "${map.id}-${application.type}-${application.name}_${latest.stage}"

                // Set location for the UAT (latest/release) FPR
                latest_fpr = "${env.WORKSPACE}/${latest_projectVersion}.fpr"

                echo "latest_fpr -> ${latest_fpr}"

                // Download FPR from DEV project and re-name it to Latest FPR
                echo 'In the download FPR block...'

                // Upload DEV FPR to UAT latest Project
                echo "### Starting DEV FPR upload to UAT (latest) Project ###"

                // Delete temporary merged FPR from the workspace
                sh rm "${latest_fpr}"
            }
        }
    } 
}
