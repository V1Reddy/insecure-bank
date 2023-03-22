def latest_fpr = ''
def dev_projectVersion = ''
def latest_projectVersion = ''

pipeline {
    agent {  
        node {  
            label 'dummy'  
        }  
    } 
    parameters {
        string (name: 'APPLICATION_NAME', defaultValue: '', description: 'Name of the application used for scanning.', trim: true)
        choice (name: 'APPLICATION_TYPE', choices: ['WEB', 'API', 'MS', 'BE'], description: 'Type of the application that was scanned.')
        string (name: 'ARTIFACT_NAME', defaultValue: '', 
            description: 'Source alias of the artifact used for scanning. This value can be left empty if a CI pipeline is being used.',
            trim: true)
        string (name: 'DEV_PROJECT_NAME', defaultValue: '', description: 'Name of the DEV project as shown on Fortify.', trim: true)
        string (name: 'DEV_STAGE', defaultValue: '', description: 'Name of the development stage', trim: true)
        string (name: 'LATEST_PROJECT_NAME', defaultValue: '', description: 'Name of the UAT (latest) project as shown on Fortify.', trim: true)
        string (name: 'LATEST_STAGE', defaultValue: '', description: 'Name of the UAT (latest) stage', trim: true)
        string (name: 'MAP_ID', defaultValue: '', description: 'MAP ID of the application', trim: true)
    }

    stages {
        stage ('Fortify merge') {
            environment {
                FORTIFY_URL = "${env.FORTIFY_URL}"
                FORTIFY_PATH = "${env.FORTIFY_PATH}"
            }
            steps {
                echo "In the fortify merge"

                script {                                
                    // Version of the DEV project
                    dev_projectVersion = "${params.MAP_ID}-${params.APPLICATION_TYPE}-${params.APPLICATION_NAME}_${params.DEV_STAGE}"

                    // Version of the UAT (latest/release) project
                    latest_projectVersion = "${params.MAP_ID}-${params.APPLICATION_TYPE}-${params.APPLICATION_NAME}_${params.LATEST_STAGE}"

                    // UAT (latest/release) FPR file
                    latest_fpr = "${env.WORKSPACE}/${latest_projectVersion}.fpr"
                }
                echo "Latest fpr to be downloaded from Fortify SSC -> ${latest_fpr}"
                echo "FORTIFY SSC URL -> ${FORTIFY_URL}"

                // Download FPR from DEV project and re-name it to Latest FPR
                echo "### Starting DEV FPR download from Fortify SSC URL ###"
                withCredentials([string(credentialsId: 'FORTIFY_DOWNLOAD_TOKEN', variable: 'FORTIFY_DOWNLOAD_TOKEN')]) {
                    sh '''
                        ${FORTIFY_PATH}/fortifyclient -url ${FORTIFY_URL} -authtoken ${FORTIFY_DOWNLOAD_TOKEN} downloadFPR -file ${latest_FPR} 
                        -application ${DEV_PROJECT_NAME} -applicationVersion ${dev_ProjectVersion}
                    '''
                }

                // Upload DEV FPR to UAT latest Project
                echo "### Starting DEV FPR upload to UAT (latest) Project ###"
                withCredentials([string(credentialsId: 'FORTIFY_UPLOAD_TOKEN', variable: 'FORTIFY_UPLOAD_TOKEN')]) {
                    sh '''
                        ${FORTIFY_PATH}/fortifyclient -url ${FORTIFY_URL} -authtoken ${FORTIFY_UPLOAD_TOKEN} uploadFPR -file ${latest_FPR} 
                        -application ${LATEST_PROJECT_NAME} -applicationVersion ${latest_ProjectVersion}
                    '''
                }
                echo "FPR upload to Foritfy SSC is complete."

                // Delete temporary downloaded FPR from the workspace
                sh " rm ${latest_FPR} "
            }
        }
    } 
}
