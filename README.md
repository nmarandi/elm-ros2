# elm-ros2

First you should create Key pairs manually from aws console and name it ssh to be able to use it for ssh.
Then you need add your credential to github action secrets. (ACCOUNT_ID, AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)
You can use access.sh to add your credentials to the enviroment variables and the run terraform apply.
There is two jobs in github action one for building docker image and pushing the image to ecr and one for terraform apply.
