 
 pipeline {
    agent {
        label 'terraform'
    }

    environment {
        TF_VERSION = '0.15.1'
        TF_STATE_RG = 'rg-terra'
        TF_STATE_STORAGE = 'tfstate'
        TF_STATE_CONTAINER = 'storageterraformbackend'
        TF_SERVICE = 'devops'
        TF_ENV = 'jenkins'
        ARM_CLIENT_ID = credentials('terraform-client-id')
        ARM_SUBSCRIPTION_ID = credentials('terraform-subscription-id')
        ARM_CLIENT_SECRET = credentials('terraform-secret-id')
        ARM_TENANT_ID = credentials('terraform-tenent-id')

    }


    stages {
        stage ("Checkout code") {
            steps {
                checkout scm
            }
        }

        stage('keyvault-test') {
            steps {
                echo '$ARM_SUBSCRIPTION_ID'
            }
        }

        /* stage ("Install dependencies") {
            steps {
                sh '''
                curl -SL "https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip" --output terraform.zip
                sudo apt install unzip
                unzip "terraform.zip"
                sudo mv terraform /usr/local/bin
                terraform --version
                rm terraform.zip
                curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
                '''
            }
        }

        stage('Terraform Init & Plan'){
            steps {  
                
                
                sh 'az login --service-principal -u f376fa70-b546-4055-9f41-01f88328ac58 -p OaFapvY0R3SM~610ZrO_rofUxtXnwjU7eU -t d048add3-ed4d-4009-87b7-65d931ca19fc'
                sh 'az account set -s 7be9aa2e-26d1-4011-a86e-0308a6962022'
                sh '''
                terraform init -input=false
                '''
                sh 'terraform plan'
                
            }
        } */

        
    } 
}
