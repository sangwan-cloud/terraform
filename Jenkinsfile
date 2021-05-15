pipeline{
    agent {
        label 'terraform'
    }
    tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform"
    }
    environment {
        TF_HOME = tool('terraform')
        TF_IN_AUTOMATION = "true"
        PATH = "$TF_HOME:$PATH"
    }
    stages {
    
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

        stage('Terraform Validate'){
            
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
                                
                        terraform validate
                        """
                           }
                    }
             }
        }

        stage('Terraform Plan'){
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
                        
                        echo "Creating Terraform Plan"
                        terraform plan
                        """
                        }
                }
            }
        }

        stage('Waiting for Approval'){
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    input (message: "Deploy the infrastructure?")
                }
            }
        
        }
    

        stage('Terraform Apply'){
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
                        echo "Applying the plan"
                        terraform apply -auto-approve
                        """
                                }
                }
            }
        }

    }
}
/*
pipeline{
    agent {
        label 'terraform'
    }
    environment {
        TF_IN_AUTOMATION = 'TERRAFORM_IN_AUTOMATION'
        TF_VERSION = '0.15.3'
        TF_STATE_RG = 'dt-rg-uks-it-azdo-01'
        TF_STATE_STORAGE = 'dtstuksitazdo01'
        TF_STATE_CONTAINER = 'terraform'
        TF_SERVICE = 'ramp'
        TF_ENV = 'dte'

    }
    stages {
              
        stage('Checkout code') {
            steps {
            checkout scm
        }
    }     

        stage ("Install dependencies") {
            steps {
                sh '''
               if [ `terraform version -json | grep terraform_version  | awk -F'"' '{print $4}'` = "$TF_VERSION" ] ; then
                echo terraform $TF_VERSION already installed, skipping installation
                else
                echo terraform $TF_VERSION version not found. Downloading and installing terraform
                wget "https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip" -O terraform.zip
                unzip "terraform.zip"
                sudo mv -f terraform /usr/local/bin
                terraform --version
                rm terraform.zip
              fi
                '''
            }
        }   
               
        stage('Terraform Init'){
            
            steps {
                    
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'spa_lgi_fte_terraform_01',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID')]) {
                        
                        sh """        
                        echo "Initialising Terraform"
                        terraform init -input=false -backend-config="resource_group_name=$TF_STATE_RG" -backend-config="storage_account_name=$TF_STATE_STORAGE" -backend-config="container_name=$TF_STATE_CONTAINER" -backend-config="key=${TF_SERVICE}.${TF_ENV}.terraform.tfstate" -no-color
                        """
                           }
                    
             }
        }

        stage('Terraform Validate'){
            
            steps {
                   
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'spa_lgi_fte_terraform_01',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID')]) {
                        
                        sh """
                                
                        terraform validate -no-color
                        """
                           }
                    
             }
        }

        
        stage('Terraform Plan'){
            steps {

                    
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'spa_lgi_fte_terraform_01',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID')]) {
                        
                        sh """
                        
                        echo "Creating Terraform Plan"
                        terraform plan -input=false -no-color
                        """
                        }
                
            }
        }  
        

       
       stage('Waiting for Approval'){

             when { 
                    branch "master"
                 }

            steps {
                timeout(time: 250, unit: 'MINUTES') {
                    input (message: "Deploy the infrastructure?")
                }
            }
        
        }

        stage('Terraform Apply'){

                when { 
                    branch "master"
                 }

            steps {
                    
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'spa_lgi_fte_terraform_01',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID')]) {

                        sh """
                        echo "Applying the plan"
                        terraform apply -input=false -no-color -auto-approve
                        """
                                }
                
            }
        } 

    }
}

terraform {
  backend "azurerm" {
   }
}

#configure azurerm provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.58.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

#create resource group
resource "azurerm_resource_group" "rg" {
    name     = "jenkins-terraform-test"
    location = "uksouth"
}

*/
