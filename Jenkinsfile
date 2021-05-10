 
 pipeline {
    agent {
        label 'terraform'
    }

    environment {
        TF_VERSION = '0.15.1'
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

        
    } 
}
