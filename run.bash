#!/bin/bash


# setup manager

cat > $CATALINA_HOME/conf/tomcat-users.xml <<ENDOFUSERCONF
<?xml version='1.0' encoding='utf-8'?>
<!-- /opt/tomcat/conf/tomcat-users.xml -->
<tomcat-users xmlns="http://tomcat.apache.org/xml"
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"
              version="1.0">

<role rolename="manager-gui"/>
<role rolename="manager-script"/>
<role rolename="manager-jmx"/>
<role rolename="manager-status"/>
<!-- 	Attention: this is unsecure -->
<user username="${TOMCAT_MANAGER_USER:-tomcat}" password="${TOMCAT_MAMANGER_PASSWD:-s3cret}" roles="manager-gui, manager-script, manager-jmx, manager-status"/>              
</tomcat-users>
ENDOFUSERCONF

ARG1=$1
# setting default, simulation of CMD ["console"] in Dockerfile
if [ -z ${ARG1} ]; then
        echo -n "setting default start arg to "
        ARG1="run"
        echo $ARG1
fi

echo "starting this container with ${ARG1}"

case "$ARG1" in
        "run")
		$CATALINA_HOME/bin/catalina.sh run
        ;;
        "bash")
                echo "entering bash mode" \
                && /bin/bash
        ;;
esac
