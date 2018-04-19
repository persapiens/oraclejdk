FROM ubuntu:16.04
MAINTAINER Marcelo Fernandes <persapiens@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

ENV VERSION 8
ENV UPDATE 171
ENV BUILD 11
ENV SIG 512cd62ec5174c3487ac17c61aaa89e8

ENV JAVA_HOME /usr/lib/jvm/java-${VERSION}-oracle

# install server-jre
RUN apt-get update -qq && \
  apt-get upgrade -qqy --no-install-recommends && \
  apt-get install curl unzip bzip2 -qqy && \
  mkdir -p "${JAVA_HOME}" && \
  curl --silent --location --insecure --junk-session-cookies --retry 3 \
	  --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
	  http://download.oracle.com/otn-pub/java/jdk/"${VERSION}"u"${UPDATE}"-b"${BUILD}"/"${SIG}"/server-jre-"${VERSION}"u"${UPDATE}"-linux-x64.tar.gz \
	| tar -xzC "${JAVA_HOME}" --strip-components=1 && \
  apt-get remove --purge --auto-remove -y curl unzip bzip2 && \
  apt-get autoclean && apt-get --purge -y autoremove && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  update-alternatives --install "/usr/bin/java" "java" "${JAVA_HOME}/bin/java" 1 && \
	update-alternatives --set java "${JAVA_HOME}/bin/java"
