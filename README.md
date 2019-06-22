This project contains a Dockerfile to build a Docker image to test and develop for [mod_authnz_jwt](https://github.com/AnthonyDeroche/mod_authnz_jwt) on Apache 2.

Use the commands below to build the image and enter into interactive mode and run tests

```bash
git clone git@github.com:brycehemme/mod_authnz_jwt_docker.git

# build the image
docker build -t mod_authnz_jwt .

# run in interactive mode
docker run -it mod_authnz_jwt

# run tests
cd mod_authnz_jwt/tests
./debian_tests.sh
```
