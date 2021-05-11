 
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

        stage ("Install dependencies") {
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

        stage('Terraform Init'){
            
            steps {
                    ansiColor('xterm') {
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'azdo-terraform-service-principal',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID'
                ), string(credentialsId: 'access_key', variable: 'ARM_ACCESS_KEY')]) {
                        
                        sh """
                                
                        echo "Initialising Terraform"
                        terraform init -backend-config="access_key=$ARM_ACCESS_KEY"
                        """
                           }
                    }
             }
        }

        
    } 
}
