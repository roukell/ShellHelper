#!/bin/bash
# problematic code
# [ -z "$JOBS" ] && echo "No job definitions" || for job in $JOBS; do
#   jenkins-jobs update $JENKINS_HOME/jenkins_jobs_definitions/$job
# done

JOBS="1 2 3 4"

if [ -z "$JOBS" ]
then
  echo "No job definitions"
else
  for job in $JOBS; do
    echo "$job"
  done
fi

# problematic code
# [ -z "$PLUGINS" ] && echo "No required plugin" || for plugin in $PLUGINS; do
#   java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$ADMIN_PASSWORD install-plugin $plugin -deploy
# done

if [ -z "$PLUGINS" ]
then
  echo "No required plugin"
else
  for plugin in $PLUGINS; do
    java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$ADMIN_PASSWORD install-plugin $plugin -deploy
  done
fi
