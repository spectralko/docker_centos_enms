FROM centos:centos7

RUN yum update -y && yum install -y \
      epel-release \
      git \
      python3 \
      python3-pip \
      ansible  && \
      pip3 install --upgrade pip && \
      yum clean all && \
      rm -rf /var/lib/yum/*

RUN git clone https://github.com/afourmy/eNMS.git
WORKDIR /eNMS

RUN pip3 install -r build/requirements/requirements.txt

RUN mkdir network_data && \
    chmod 777 ./files/apps/gotty


RUN sed -i 's/"end_port": 9100/"end_port": 9001/g' /eNMS/setup/settings.json && \
    export FLASK_APP=app.py

CMD export LC_ALL=en_US.utf8 && flask run --host=0.0.0.0

EXPOSE 5000 9000
