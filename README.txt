All of the below instructions can be made as a simple script by placing all the commands listed here.

---------------------
Prerequisites
---------------------

1) Install Terraform binary from the following website, and place the terraform binary at /usr/bin directory 
   https://www.terraform.io/downloads.html

2) Install Ansible 
   % pip install ansible

3) Get AWS security keys from your account
   - access key
   - secret key
   - ssh key name 


----------------------
Installation
----------------------

1) Go to ec2_launch directory
   % cd ec2_launch

2) update the required variables in vars.tf file according to your environment
   % vi vars.tf

3) Verify the integrty of terraform configuration
   % terraform plan

4) Launch the EC2 instance
   % terraform apply

5) make the changes in root .ssh/authorized_keys to allow root to interact directly
   % cd /root/.ssh
   % erase the line until 'ssh-rsa'

5) Note down the output of previous step for assigned public_ip of launched EC2 instance
   % export output=`terraform output`
   % export ${output//[[:space:]]/}

6) Go to deploy_service directory
   % cd ../deploy_service

7) Update the ansible host configuration
   % sed -i 's/XX.XX.XX.XX/${public_ip}/' hosts/awscloud.hosts
   
8) Run the ansible playbook to deploy all required software components on the target
   % ansible-playbook -vv --private-key YOURSSHPRIVKEY.pem -i hosts/awscloud.hosts  nosto_playbook.yml

9) Opent he web browser and check deployed web service or verify return code 200 Ok from the below command
   % curl -I http://${public_ip}


-----------------------
Uninstallation
-----------------------

1) Go to ec2_launch directory
   % cd ec2_launch

2) Destory the launched EC2 instance
   % terraform destroy

