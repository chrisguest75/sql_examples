# LINTING

NOTE:

* brew installation only installs the pip package.  
* It's easier to use the docker image

## Install

```sh
brew info sqlfluff

brew install sqlfluff
```

## Docker

Use the official docker image.  

```sh
# if in a pipeline it might be better with a docker volume rather than a mount.  
docker run -it --rm -v $PWD/examples:/sql sqlfluff/sqlfluff:latest lint --dialect athena 01_athena.sql
```

## Resources

* Sqlfluff [here](https://sqlfluff.com/)  
* sqlfluff/sqlfluff dockerhub [here](https://hub.docker.com/r/sqlfluff/sqlfluff)  
