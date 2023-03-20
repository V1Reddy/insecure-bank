pipeline {
    agent any
    parameters {
        base64File 'FORTIFY_FPR'
    }
    stages {
        stage ('Fortify merge') {
            environment {
                application.name = 'App1'
                application.type = 'AppType1'
                artifact.name = 'Artifact1'
                dev.project = 'DEV_1'
                dev.stage = 'STAGE_1'
                latest.project = 'Proj1'
                latest.stage = 'latest'
                map.id = '111'
                project.folder = 'some_folder' 
            }
            steps {
                echo "In the fortify merge"
                                
                // Version of the DEV project
                def dev_ProjectVersion = "${map.id}-${application.type}-${application.name}_${dev.stage}"

                //Version of the UAT (latest/release) project
                def latest_ProjectVersion = "${map.id}-${application.type}-${application.name}_${latest.stage}"

                // Set location for the UAT (latest/release) FPR
                def latest_FPR = "${env.WORKSPACE}/${latest_ProjectVersion}.fpr"

                echo "latest_FPR -> ${latest_FPR}"

                // Download FPR from DEV project and re-name it to Latest FPR
                echo 'In the download FPR block...'

                // Upload DEV FPR to UAT latest Project
                echo "### Starting DEV FPR upload to UAT (latest) Project ###"

                // Delete temporary merged FPR from the workspace
                sh rm "${latest_FPR}"
            }
        }
    } 
}
