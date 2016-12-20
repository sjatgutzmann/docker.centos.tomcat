# docker.centos.tomcat
Centos7 + JDK8 + Tomcat 8

Start parameter:
    bash: starting a bash with user tomcat
    run: starting tomcat in console (default)

Enviroment:
    CATALINA_HOME (default=/opt/tomcat/)


mountable volumes:

    VOLUME ["${CATALINA_HOME}/logs"]
    VOLUME ["${CATALINA_HOME}/webapps"]
    VOLUME ["${CATALINA_HOME}/work"]
