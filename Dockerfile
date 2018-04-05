FROM ubuntu:16.04
MAINTAINER Marcelo Fernandes <persapiens@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

ENV VERSION 8
ENV UPDATE 161
ENV BUILD 12
ENV SIG 2f38c3b165be4555a1fa6e98c45e0808

ENV JAVA_HOME /usr/lib/jvm/java-${VERSION}-oracle

# install jre
RUN apt-get update -qq && \
  apt-get upgrade -qqy --no-install-recommends && \
  apt-get install curl unzip bzip2 -qqy && \
  mkdir -p "${JAVA_HOME}" && \
	curl --silent --location --insecure --junk-session-cookies --retry 3 \
	  --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
	  http://download.oracle.com/otn-pub/java/jdk/"${VERSION}"u"${UPDATE}"-b"${BUILD}"/"${SIG}"/jre-"${VERSION}"u"${UPDATE}"-linux-x64.tar.gz \
	| tar -xzC "${JAVA_HOME}" --strip-components=1 && \
  apt-get remove --purge --auto-remove -y curl unzip bzip2 && \
  apt-get autoclean && apt-get --purge -y autoremove && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN update-alternatives --install "/usr/bin/java" "java" "${JAVA_HOME}/bin/java" 1 && \
	update-alternatives --install "/usr/bin/javaws" "javaws" "${JAVA_HOME}/bin/javaws" 1 && \
	update-alternatives --set java "${JAVA_HOME}/bin/java" && \
	update-alternatives --set javaws "${JAVA_HOME}/bin/javaws"
