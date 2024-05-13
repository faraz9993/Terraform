# Terraform
- Terraform is free and open source tool developed by HashiCorp.
- Terrafrom is an Infrastructure as a Code (IAAC).
- Terraform uses HashiCorp Configuration Language (HCL).
- In the course we will manage AWS services using Terraform.
## - Objective of the course is to learn:
1. Remote state
2. State locking
3. Remote backend with S3
4. State commands
5. Introduction to EC2
6. AWS EC2 with terraform
7. Provisioners

- In large organizations with elastic and highly scalable cloud environment with immutable infrastructure, this approach is not feasible. Once provisioned, the systems still have to go through different teams with a lot of process overhead that increases the delivery time.
-------------------
[Immutable means whenever code is updated, terraform will delete the old resources and create new one.]
---------------
- The chances of human error are still at large, resulting in inconsistent environments. Different organizations started solving these challenges within themselves by developing their own scripts and tools.
- While some use simple shell scripts, others used programming languages such as Python, Ruby, Perl or PowerShell.
- Everyone was solving the same problems, trying to automate infrastructure provisioning to deploy environments faster and in a consistent fashion by leveraging the API functionalities of the various cloud environments.
- These evolved into a set of tools that came to be known as Infrastructure as Code.
## Types of IaaC Tool 

IaaC tool can be defined into three catagories:
1. Configuratoin Management Tool
2. Server Templation Tool
3. Provisioning Tool

### - Configuration management tool:
1. Ansible
2. Puppet
3. Saltstack

### - Server Templation Tool:
1. Docker
2. HashiCorp Packer
3. HashiCorp Vagrant

### - Provisioning Tool
1. HashiCorp Terraform
2. CloudFormation
- Configuration management tools are used to design, insatll and manage softwares.
- Server Templating Tools are used for pre installed software and dependencies.
- Provisioning tools are used to deploy immutable infrastructure resources such as servers, databases, network components and so on using code.
- Terraform installs as a single binary which can be setup very quickly, allowing us to build, manage and destroy infrastructure in a metter of minutes.
- One of the biggest advantages of Terraform is its ability to deploy infrastructure across multiple platforms including private and public clouds such as on-premises vSphere cluster or cloud solutions such as AWS, Azure, GCP, VMware to name a few.
- Terraform file extension is .tf
- Terraform code is declarative and can be maintained in a version control system, allowing it to be distributed to other teams.

## - What do you mean by declarative?
- The code we defined is the state that we want our infrastructure to be in. That's the desired state.
 Declarative means you don’t need to write the entire process in correct order. You just have to write what you want terraform to do, it will automatically arrange all the tasks in order itself.


### Terraform works in three phases:
--------------
1. init
2. plan
3. apply

- During the init phase, Terraform initializes the project and identifies the providers to be used for the target environment.
- During the plan phase, Terraform drafts a plan to get to the target state.
- Then in the apply phase, Terraform makes the necessary changes required on the target environment to bring it to the desired state.
- If for some reason the environment was to shift from the desired state, then a subsequent Terraform apply will bring it back to the desired state, by only fixing the missing component.
#### - Every object that Terraform manages is called a resources.
- Terraform can ensure that the entire infrastructure is always in the defined state at all times.

## Installing Terraform
- Terraform can be downloaded as a single binary or an executable file from the Terraform download section in www.terraform.io.
- Steps of installing Terraform:
1. sudo wget https://releases.hashicorp.com/terraform/0.13.0/terraform_0.13.0_linux_amd64.zip 
2. unzip terraform_0.13.0_linux_amd64.zip 
3. sudo mv terraform /usr/local/bin
4. terraform --version

## HashiCorp Configuration Language (HCL) Basics

- A simple Terraform workflow consists of four steps. First, write the configuration file. 
- Next, run the terraform init command. And after that, review the execution plan using the terraform plan command.
- Finally, once we are ready, apply the changes using the terraform apply command.

Terraform init command:
## Terraform init: 
- When you run the terraform init command, terraform initializes a working directory and downloads the necessary provider plugins and modules and setting up the backend for storing your infrastructure's state. 

## Terraform plan: 
- When you run the terraform plan command, terraform drafts and displays the execution plan that will be carried out by Terraform, we can use the command terraform plan. This command will show the actions that will be carried out by Terraform to create the resources.
In the plan, you'll also notice that some default or optional arguments which we did not specifically declare in the configuration file is also displayed on the screen. The plus symbol implies that the resource will be created.

## Terrafrom apply:
- When you run the terraform apply command, terraform again displays the execution plan once again, and it will then ask the user to confirm by typing yes to proceed. Once we confirm, it will proceed with the creation of the resource.

## Terraform show:
To see the details of the resources we just created.


Update and destroy Infrastructure using terraform

1. cd ~
2. mkdir terraform
3. cd terraform
4. vim local.tf
5. write the below code in it:
-----------------------
resource "local_file" "pet" {

filename = "/home/pets.txt"
   
   content = "We love pets!"
}
-----------------------
6. wq!
7. terraform init
8. terraform plan
9. sudo terraform apply
10. A file will be created at /home with the name of pets.txt in which We love pets will be written.
11. vim local.tf
12.
------------------
resource "local_file" "pet" {

   filename = "/home/pets.txt"

   content = "We love pets!"

   file_permission = 0700
}
-------------------------
[Here,
resource type is local_file
resource name is pet
provider is local]
13. terraform init
14. terraform plan
[If you will run terraform plan command, without running terraform init command, it won’t even work.]
15. terraform apply

## What is Immutable infrastructure?
- Suppose, there was a file local.tf already existed, we just added a file_permission in it. However, even though the change we made was minor, Terraform will delete the old file and then create a new file with the updated permissions. This type of infrastructure is called an Immutable Infrastructure.

To delete the infrastructure completely run the terraform destroy command.

## Terraform Workspace

### - To create a new workspace in terraform
terraform workspace new ProjectA

### - To list all the workspaces in terraform
terraform workspace list

### - To select a particular terraform workspace
terraform workspace select default

### - To see your current workspace
terraform workspace show



## Terraform Modules
Terraform modules are basically the collection of all the configuration files in a particular directory that can help organize configuration into logical components.


### Using Terraform Providers
- We know that when we run terraform init command, it initialize the directory and then download and installs required plugins of resources that will be mentioned in the .tf file.
- These plugins are downloded from registry.terraform.io

### Configuration Directory
- Configuration directory is the directory where your .tf files are.
- Right now, you are working in ~/terraform directory. There you created a file named local.tf and it has a terraform code as below:
------------------
resource "local_file" "pet" {
   
   filename = "/home/pets.txt"
   
   content = "We love pet!"
   
   file_permission = "0700"

}
-----------------------
Now, suppose, you created another file named vocal.tf in the same directory and gave the below code:

----------------------
resource "local_file" "cat" {

   filename = "/home/cats.txt"
   
   content = "We love cats!"
   
   file_permission = "0700"

}

--------------------------
Now, if you will run three commands, the terraform will create another file name cats.txt with above given configuration.

Now, you can create n number of such files and create as many resources. 

Another thing you can do is create a single main.tf file and write the content of those n number of files in that file as below:

--------------------------------

resource "local_file" "pet" {

   filename = "/home/pets.txt"

   content = "We love pet!"

   file_permission = "0700"

}
----------------------------------

resource "local_file" "cat" {

   filename = "/home/cats.txt"

   content = "We love cats!"

   file_permission = "0700"

}
-------------------------------------
- Making main.tf file and writing code in it for all the resources in it is the best practice.
- In main.tf there are two piece of codes but the provider is only one which is local.


## Multiple Providers
- Terrafrom also supports multiple providers in the same configuration.



- As we discussed earlier that if we will make any changes in .tf file and run terraform resources which are init, plan and apply it will destroy the older resources and create new ones.
- However, an important point to be emphasised here is that we haven’t made any changes in first piece of code we have added a second piece of code. So, the file named pets.txt won’t be re-created, only resources mentioned in the second piece of code will be created.
Can we use multiple providers in the same configuration?
Yes



Define Input Variables


		Arguments				      Value
	     filename				“/root/pets.txt”
		 content				“We love pets”
		  prefix					“Mrs”
		 seperator			    	“.”
		 length						“1”


- For the random pet resource, we have used the prefix, separator, and length as the arguments. Since their values are directly defined within the main configuration files, they are considered to be hardcoded values.
- One of the disadvatages of hardcoded value is that they limit the reusability of the code which defeats the purpose of using IAC and that’s when input variables come into the picture.

- The variables.tf file, just like the main.tf file, consists of blocks and arguments.


- Now, to create these resources you can use terraform resources like terraform init, terraform plan and terraform apply.


## Understanding the variable block

variable “filename” {
   
     default = “/root/pets.txt”
   
     type = string
   
     description = “the path of local file”

}

----------------------

variable “content” {

     default = “I love pets!”

     type = string

     description = “the content of the file”

}

-------------------------------------

variable “prefix” {

     default = “Mrs”

     type = string

     description = “the prefix to be set”

}

----------------------------------

variable “length” {

     default = 2

     type = number

     description = “length of the pet name”

}

--------------------------------------

variable “password_change” {

     default = true

     type = bool

}

--------------------------------------

## Map:
A map is a data represented in a key:value pair.


## Set
The difference between a set and a list is that a set cannot have duplicate elements.

## Objects
- With objects, we can create complex data structures by combining all the variable types that we have seen so far.

## Resource Dependencies

- When Terraform creates these resources, it knows about the dependency since the local file resource depends on the output of the random_pet resource.
[ The resource random_pet generates random pet names that are intended to be used as unique identifiers for other resources. This resource can be used in conjunction with resources that have the create_before_destroy lifecycle flag set, to avoid conflicts with unique names during the brief period where both the old and new resources exist concurrently.]
[We already know that the random pet resource will generate the random pet name]

- Use the attribute called ID when we apply the configuration. As a result, it uses the following order to provision them.
- First Terraform crazy random_pet resource, and then it creates a local file resource.

## How terraform delete resources.
- When resources are deleted, Terraform deletes it in the reverse order, the local file first and then the random bid.


## What is explicit dependency?
When Resource A relies on Resource B but doesn't access any of its attributes.

## How do we make use of implicit dependency?
Ans Reference expression

Introduction to Terraform State
### Syntax:
[terraform-local-files]$ ls

main.tf variables.tf terraform.tfstate 

- We often see that there is an additional file called terraform.tfstate created in the directory.
- This file is called the terraform state file, which was created as a consequence of the terraform apply command that created the resource in the first place.
- This file is not created until the terraform apply command is ran at least once.	
- The state file is a JSON data structure that maps the real-world infrastructure resources to the resource definition in the configuration files.
- If we inspect the contents of this state file, we can see that it has the complete record of the infrastructure created by Terraform.
- The details such as the resource ID, provider information and all the resource attributes are stored within this file.
- If we make a change to the configuration file now, and rerun the terraform plan or apply command, Terraform by default refreshes the state again.
- As a result, Terraform knows that the resource must be recreated and when we run terraform apply.

Purpose of state
- Hence, a state file can be considered to be a blueprint of all the resources that are for managers out there in the real world.
- Each resource created and managed by Terraform would have a unique ID which is used to identify the resources in the real world.




- Earlier, we learnt that Terraform supports two types of dependencies, the implicit and the explicit.
- If we inspect the example configuration file in the above image, we can see that we have three resources to provision here.
- The local file resource called pet depends on the random pet resource.
- This means when we apply this configuration, the random pet resource called my-pet and the local file called cat can be created first at the same time, but the local file resource called pet can only be created after the random pet resource is created. 
- If we were to apply the terraform destroy command, Terraform knows that it has to delete the resources.
- However, in which order does it delete it? Should it delete the random pet resource first or the local file?
- This is where Terraform relies on the state and the fact that it tracks metadata.
- The Terraform state file is stored in the same configuration directory in a file called terraform.tfstate.

- When you run the terraform destroy command, Terraform destroys the resources in the reverse order of their creation.
- This ensures that resources that depend on other resources are deleted last.
- For example, if you have a resource A that depends on resource B, Terraform will destroy resource B first, and then resource A.


### Which location is the terraform state file stored by default?
#### Ans:  Inside the configuration directory

-----------------------

#### Which option should we use to disable state?
#### Ans we can not disable state

-----------------------


#### Which format is the state file stored in by default?
#### Ans JSON

-------------------------


#### Which of the following commands does NOT refresh the state?
#### Ans terraform init

---------------------------

#### What is the name of the state file that is created by default?
#### Ans terraform.tfstate

---------------------------

- When working as a team, it is considered a best practice to store Terraform configuration files in distributed version control systems, such as GitHub, GitLab, or Bitbucket.
- However, owing to the sensitive nature of the state file, Instead, store the state in remote backend systems such as AWS S3, Google Cloud Storage,Azure Storage, Terraform Cloud, et cetera.

## Terraform commands
### terraform validate:
- Once we write our configuration file, it's not necessary to run terraform plan or apply to check if the syntax used is correct.
- Instead, we can make use of the terraform validate command and if everything is correct with the file, we will see a successful validation message:
--------------
#### Success! The configuration is valid.
--------------
- If there's an error in the configuration file, the validate command will show you the line in the file that is causing the error with hints to fix it.	

### terraform fmt:
- This command scans the configuration files in the current working directory.
-  This is a useful command to improve the readability of the Terraform configuration file.

### terraform show:
- The terraform show command prints out the current state of the infrastructure.

### terraform show -json:
command to see the content in the json format.

### terraform providers:
- To see a list of all the providers used in the configuration directory, use the terraform providers command.

### terraform output:
- To see all the output variables in the configuration directory.

### terraform refresh:
- To sync the terraform with the real world infrastructure.
- For example, if there are any changes made to a resource created by Terraform outside its control, such as a manual update, the terraform refresh command will pick it up and update the state file.


### terraform graph:
- The terraform graph command is used to create a visual representation of the dependencies and a Terraform configuration or an execution plan.
- This command can be run as soon as you have the configuration file ready.
- For the graphical view you need to install a 3rd party software called graphviz.
terrafrom graph | dot -Tsvg > graph.svg


- The terraform apply command might get failed even if terraform validation command is working! This is because the validate command only carries out a general verification of the configuration.
- It validated the resource block and the argument syntax but not the values the arguments expect for a specific resource!
Providers are basically plugins

## Mutable vs Immutable Infrastructure
- Suppose, you have the pool of webservers on which nginx 1.18 is running.
- Now, a new version of nginx is released so you update the webserver vesion from nginx 1.18 to nginx 1.19.
- You haven’t made any changes to hardware configuration. All the changes that are made were in the software.
- This is called Mutable Infrastructure.

- However, while upgrading the software, there are high chances that out of the pool of suppose 100 webservers because of human error or any dependency issue 5 to 10 webserver couldn’t be upgraded to nginx version 1.19.
- This issue is known as 	Configuration drift.

- To overcome this isuue means, in order to upgrade the webserver, from nginx 1.18 to 1.19 you bring new physical webservers one by one that has nginx version 1.19 and same way keep removing physical webservers that has nginx version 1.18.
- Here, you have changed the entire physical hardware. This is known as Immutable Infrastructure.
- Immuable means unchanged or something that can not be changed.

As the Immutable infrastructure reduces the chances of configuration drift, Terrafrom uses the approach that if the change has been made in the configuration file, it first destroys the resources and then creates the new ones.


## Lifecycle Rules
- Previously, we saw that when Terraform updates a resource it frees the infrastructure to be immutable and first deletes a resource before creating a new one with the updated configuration.
- Means, you would see that the older file is deleted first and then the new file is created.
- Now, this may not be the desirable approach in all cases.
- Sometimes you may want the updated version of the resource to be created first before the older one is deleted, or you may not want the resource to be deleted at all.
- This can be achieved in Terraform by making use of lifecycle rules.

If don’t want your resource to be destroyed at all:

### Ignore changes
- This lifecycle rule when applied will prevent a resource from being updated based on a list of attributes that we define within the lifecycle block.

### Summary


Data sources
- Datasources are used to read the data from the real-world infrastructure:
1. Resource
2. Data Source



Meta Arguments

- Until now, we have been able to create single resources such as a local file and a random pet resource using Terraform, but what if you want to create multiple instances of the same resource.
- For that Meta Arguments are used.
### Count:
- One of the easiest ways to create multiple instances of the local file is to make use of the count meta-argument.

- However, there is one problem with this approach. Since, we have only specified the count, Terraform will try to create the same resource three times.
- Since the filename is not unique, rather than creating three separate files which defeats the purpose of this task.
- A better way to do this and make sure that all the three resources have unique filenames is to make use of a list variable for filename.
- To do this, we have used default values with three elements, each corresponding to the name of the file that we want to create.
for_each:

## Version Constraints
- Version Constraints is used to make use of specific provider versions in Terraform.
- Without additional configuration, the Terraform init command downloads the latest version of the provider plugins.
- However, this is not something that we may desire every time.
- Fortunately, we can make sure that a specific version of the provider is used by Terraform when we are on the Terraform init command.
- The instructions to use a specific version of a provider is available in the provider documentation in the registry.

- In the above configuration for the local provider, we have specified version equal to 1.4.0.
- This will make terraform to find and install exact version.

- If we use the not equal to symbol instead as shown in above image, we have specifically asked Terraform to do not use the version 2.0.0.


- Finally, we can also make use of pessimistic constraint operators.
- This is defined by making use of the tilde greater than symbol like this.
- This operator allows Terraform to download the specific version or any available incremental version based on the value we provided.
- For example, here, we have given the value of 1.2, following the tilde greater than symbol.
- This means that Terraform can either download the version 1.2 or incremental version such as 1.3, 1.4, 1.5, all the way up until 1.9.

## Getting Started with AWS
- Terraform offers a dedicated AWS provider for the purpose of provisioning and managing AWS cloud-based services.
- With HCL, users can write configuration files using simple human-readable format that can be versioned checked in to source control and easily distributed for reusability.

Managing AWS IAM with terraform
- let us see how to provision IAM resources using Terraform.
- To do this, let us make use of the documentation from registry.terraform.io for the AWS provider, and in this case, resources specifically for IAM.
- Just like we saw with the local file and the random pet resources that we worked on earlier, the resource name begins with the provider name, which in this case is AWS.