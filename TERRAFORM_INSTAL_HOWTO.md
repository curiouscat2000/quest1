# ISTALL HOW TO
## preconditions
 - an AWS account to play with.
 -  
 - docker installed on local computer
 - either AWS credentials file or environment variables exist per https://www.terraform.io/docs/providers/aws/index.html#authentication
 - credentials have Admin access to ECR/VPC/ECS/EC2/CodePipeline/CodeBuild/S3 in default region

 - AWS_DEFAULT_REGION env points to AWS region to play with
$ export AWS_ACCESS_KEY_ID="accesskey"
$ export AWS_SECRET_ACCESS_KEY="secret"
$ export AWS_DEFAULT_REGION="us-west-2" # whatever region you play with
- terraforms stack pickups code from GitHub repo https://github.com/curiouscat2000/quest1 # configurable in terraform/live/dev/services/terraform.tfvars 
- ONLY if want point to a private git repo, set env variable GITHUB_TOKEN=<GITHUB PERSONAL TOKEN>
 



## bootstrap
- pickup an unused and globally unqiue S3 bucket name, configure in:
-- terraform/live/dev/vpc/main.tf
-- terraform/live/dev/services/main.tf
-- terraform/live/dev/services/data.tf
-- terraform/bootstrap/main.tf
- cd terraform/bootstrap 
- terraform init && terraform apply


## create VPC and ECS service
- cd terraform/dev/vpc
- terraform init && terraform apply
- cd terraform/dev/services
- terraform init && terraform apply
# Test
- wait few min, for AWS CodePipeline to pickup code from github repo,compile and deploy to autogenerated terraform stack
- terraform/dev/services/terraform output prints DNS name of stack load balancer













# tech/design notes

## VPC layout
create dedicated VPC 
Include public and private networks, in multi AZs just for extensiblity/best pracices demo
## terraform state
- S3 backend. For the sake of demo, pls configure globally unique S3 bucket name
- several smaller terraform state files should be more manageable than one big
## terraform files layout
- modules 
// reusable infrastructure as code, no state, no AWS account/region specifics
// versioning - by git tags or by explicit module folder(s) rename? 
-- modiles/vpc // spinup VPC
-- modules/service // manage AWS ECS service
- live // root folder for STATEFUL environment(s). Separated AWS accounts per env(dev, vs qa vs prod)
- live/dev // dev env
- live/qa // qa env
- boostrap // to be run once, setups terraform shared remote state storage in S3
- terraform/live/dev/secrets // secrets storage, intented be stored in SEPARATED git repo, encrypted. Wrapping shell code required, missed in demo, see notes
## secrets management
- SSL/ssh private keys, passwords,etc
- secure secrets storage, per ENV, protected by encryption or/and infrastructure(IP whitelist/etc). Authenthication/authorization/audit.Should we keep old versions of secrets? (balance between security and convenience) 
- how APP code should learn secrets? To minimize runtime dependencies/failure points, arguably deployment automation should "merge" app code and secrets at deploy time only. Better have deploy time failure than runtime failure (misconfgiured perms to AWS Secrets Manager,etc) . How to rotate secrets (explicitly redeploy same app version)?
- arguably, reuse gears and share same storage and tooling for infrastructure (ssh/ssl private keys,etc) and APP (database passwords,API KEYS,etc) secrets
- small dedicated git repo, that keeps encrypted files of "secrets" terraform module, checkoutable by privileged server/user only (CI server) and only for deploy time, referenced from  terraform infrastructure code. See terraform/live/dev/secrets    


## notes
- bad:chicken and egg for backend bootstrap. Want keep vital S3 bucket under control. Prob to have wrapping BAT/SHELL script for bootstrapping
- bad: backend config prohibits interpolation - have dups across code
- bad:terraform keeps secrets in plaintext in state files, have to protect those
- info:service role for ECS service - should be created by AWS automatically.
 // if have to create from terraform, set create_ecs_service_linked_role to true in terraform/modules/services/variables.tf






