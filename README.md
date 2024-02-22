# elm-ros2

First, you should create Key pairs manually from the aws console and name it SSH to be able to use it for ssh.

Then you need to add your credentials to GitHub action secrets. (ACCOUNT_ID, AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)

You can use access.sh to add your credentials to the environment variables and the run terraform apply.

There are two jobs in GitHub action, one for building a docker image and pushing the image to ecr and one for terraform apply.
