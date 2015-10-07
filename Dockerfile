##
##   Copyright 2015 Zalando SE
##
##   Licensed under the Apache License, Version 2.0 (the "License");
##   you may not use this file except in compliance with the License.
##   You may obtain a copy of the License at
##
##       http://www.apache.org/licenses/LICENSE-2.0
##
##   Unless required by applicable law or agreed to in writing, software
##   distributed under the License is distributed on an "AS IS" BASIS,
##   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##   See the License for the specific language governing permissions and
##   limitations under the License.
##
FROM centos

ENV   ARCH  x86_64
ENV   PLAT  Linux

##
## install dependencies
RUN \
   yum -y install \
      tar  \
      git  \
      make \
      unzip

##
## install aws cli tools
RUN \
   curl https://s3.amazonaws.com/aws-cli/awscli-bundle.zip -o awscli-bundle.zip && \
   unzip awscli-bundle.zip && \
   ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && \
   rm awscli-bundle.zip && \
   rm -Rf awscli-bundle

##
## install application
COPY typhoon-current.${ARCH}.${PLAT}.bundle /tmp/typhoon.bundle

RUN \
   sh /tmp/typhoon.bundle && \
   rm /tmp/typhoon.bundle 

ENV PATH $PATH:/usr/local/typhoon/bin/

EXPOSE 8080
EXPOSE 4369
EXPOSE 32100
EXPOSE 20100-20109

CMD /etc/init.d/typhoon start

