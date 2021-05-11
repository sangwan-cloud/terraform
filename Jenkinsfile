 
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
        ARM_CLIENT_ID = credentials('ARM_CLIENT_ID')
        ARM_SUBSCRIPTION_ID = credentials('ARM_SUBSCRIPTION_ID')
        ARM_CLIENT_SECRET = credentials('ARM_CLIENT_SECRET')
        ARM_TENANT_ID = credentials('ARM_TENANT_ID')
    }


    stages {
        stage ("Checkout code") {
            steps {
                git url: "https://github.com/ajay-sangwan/terraform.git",
                    // Set your credentials id value here.
                    // See https://jenkins.io/doc/book/using/using-credentials/#adding-new-global-credentials
                    // credentialsId: "yourCredentialsId",
                    // You could define a new stage that specifically runs for, say, feature/* branches
                    // and run only "pulumi preview" for those.
                    branch: "main"
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

        stage('Terraform Init & Plan'){
            steps {  
                
                
                sh 'az login --service-principal -u f376fa70-b546-4055-9f41-01f88328ac58 -p OaFapvY0R3SM~610ZrO_rofUxtXnwjU7eU -t d048add3-ed4d-4009-87b7-65d931ca19fc'
                sh 'az account set -s 7be9aa2e-26d1-4011-a86e-0308a6962022'
                sh '''
                terraform init -input=false -backend-config="resource_group_name=$TF_STATE_RG" -backend-config="storage_account_name=$TF_STATE_STORAGE" -backend-config="container_name=$TF_STATE_CONTAINER" -backend-config="key=$TF_SERVICE.$TF_ENV.terraform.tfstate
                '''
                sh 'terraform plan'
                
            }
        }

        
    } 
}
