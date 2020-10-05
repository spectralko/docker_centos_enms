FROM centos:centos7
RUN yum update -y
RUN yum install -y epel-release git && yum clean all && rm -rf /var/lib/yum
RUN yum install -y python3 && yum install -y python3-pip && yum install -y ansible && pip3 install --upgrade pip && yum clean all && rm-rf /vr/lib/yum
RUN git clone https://github.com/afourmy/eNMS.git
WORKDIR /eNMS
RUN mkdir network_data && chmod 777 ./files/apps/gotty
RUN pip3 install -r build/requirements/requirements.txt && LC_ALL=en_US.utf-8 && LC_LANG=en_US.utf-8
RUN sed -i 's/"end_port": 9100/"end_port": 9001/g' /eNMS/setup/settings.json
RUN export FLASK_APP=app.py
CMD flask run --host=0.0.0.0

EXPOSE 5000 9000
