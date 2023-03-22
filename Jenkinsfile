def latest_fpr = ''
def source_projectVersion = ''
def dest_projectVersion = ''

pipeline {
    agent {  
        node {  
            label 'fortify'  
        }  
    } 
    parameters {
        string (name: 'APPLICATION_NAME', defaultValue: '', description: 'Name of the application used for scanning.', trim: true)
        choice (name: 'APPLICATION_TYPE', choices: ['WEB', 'API', 'MS', 'BE'], description: 'Type of the application that was scanned.')
        string (name: 'SOURCE_PROJECT_NAME', defaultValue: '', description: 'Name of the source project (as shown in Fortify SSC) from where the FPR file is downloaded.', trim: true)
        string (name: 'SOURCE_STAGE', defaultValue: '', description: 'Name of the source project stage (as shown in Fortify SSC) from where the FPR file is downloaded.', trim: true)
        string (name: 'DEST_PROJECT_NAME', defaultValue: '', description: 'Name of the destination project (as shown in Fortify SSC) where the FPR file is uploaded to.', trim: true)
        string (name: 'DEST_STAGE', defaultValue: '', description: 'Name of the destination stage (as shown in Fortify SSC) where the FPR file is uploaded to.', trim: true)
        string (name: 'MAP_ID', defaultValue: '', description: 'MAP ID of the application.', trim: true)
    }

    stages {
        stage ('Fortify merge') {
            environment {
                FORTIFY_URL = "${env.FORTIFY_URL}"
                FORTIFY_PATH = "${env.FORTIFY_PATH}"
            }
            steps {
                echo "In the fortify merge."

                script {                                
                    // Version of the source project
                    source_projectVersion = "${params.MAP_ID}-${params.APPLICATION_TYPE}-${params.APPLICATION_NAME}_${params.SOURCE_STAGE}"

                    // Version of the destination project
                    dest_projectVersion = "${params.MAP_ID}-${params.APPLICATION_TYPE}-${params.APPLICATION_NAME}_${params.DEST_STAGE}"

                    // Latest FPR file name
                    latest_fpr = "${env.WORKSPACE}/${dest_projectVersion}.fpr"
                }
                echo "Latest fpr to be downloaded from Fortify SSC -> ${latest_fpr}"
                echo "FORTIFY SSC URL -> ${FORTIFY_URL}"

                // Download FPR from Source project and re-name it to latest FPR
                echo "### Starting FPR download from Source from Fortify SSC URL ###"
                withCredentials([string(credentialsId: 'FORTIFY_DOWNLOAD_TOKEN', variable: 'FORTIFY_DOWNLOAD_TOKEN')]) {
                    sh '''
                        ${FORTIFY_PATH}/fortifyclient -url ${FORTIFY_URL} -authtoken ${FORTIFY_DOWNLOAD_TOKEN} downloadFPR -file ${latest_fpr} 
                        -application ${SOURCE_PROJECT_NAME} -applicationVersion ${source_ProjectVersion}
                    '''
                }

                // Upload downloaded FPR to the Destination Project
                echo "### Starting FPR upload to Destination Project ###"
                withCredentials([string(credentialsId: 'FORTIFY_UPLOAD_TOKEN', variable: 'FORTIFY_UPLOAD_TOKEN')]) {
                    sh '''
                        ${FORTIFY_PATH}/fortifyclient -url ${FORTIFY_URL} -authtoken ${FORTIFY_UPLOAD_TOKEN} uploadFPR -file ${latest_fpr} 
                        -application ${DEST_PROJECT_NAME} -applicationVersion ${dest_ProjectVersion}
                    '''
                }
                echo "FPR upload to Fortify SSC is complete."

                // Delete temporary downloaded FPR from the workspace
                sh " rm ${latest_fpr} "
            }
        }
    } 
}
