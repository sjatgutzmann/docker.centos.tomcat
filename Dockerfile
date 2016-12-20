#!Dockerfile
#AUTOR: sjatgutzmann

FROM sjatgutzmann/docker.centos.javadev8
MAINTAINER Sven Jörns <sjatgutzmann@gmail.com>

ENV TOMCAT_VERSION 8.0.39
ENV CATALINA_HOME /opt/tomcat
ARG TOMCAT_MANAGER_USER=tomcat
ARG TOMCAT_MANAGER_PASSWD=tomcat
ARG HTTP_PORT=8080
#ARG HTTPS_PORT=8443
ARG AJP_PORT=8009

ADD "run.bash" "/run.bash"
RUN chmod +x /run.bash

#
# Adjust ownership
#
RUN useradd -d ${CATALINA_HOME}/ -m tomcat 

USER tomcat

WORKDIR ${CATALINA_HOME}

# add default user manager


#
# Go get the needed tar/jar we'll installing
#
RUN curl -sSLo ./apache-tomcat-${TOMCAT_VERSION}.tar.gz http://ftp.fau.de/apache/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
  && tar --extract --ungzip --file ./apache-tomcat-${TOMCAT_VERSION}.tar.gz --strip 1 --directory ${CATALINA_HOME} \
  && rm ./apache-tomcat-${TOMCAT_VERSION}.tar.gz  

VOLUME ["${CATALINA_HOME}/logs"]
VOLUME ["${CATALINA_HOME}/webapps"]
VOLUME ["${CATALINA_HOME}/work"]

# Standard web ports exposted
#EXPOSE ${HTTP_PORT}/tcp ${HTTPS_PORT}/tcp ${AJP_PORT}/tcp
EXPOSE ${HTTP_PORT}/tcp ${AJP_PORT}/tcp
ENTRYPOINT ["/run.bash"]
# start as bash with the user tomcat
CMD ["bash"]
# start tomcat in console (defualt)
CMD ["run"]
