FROM centos:centos8

RUN dnf -y install \
      epel-release \
      git \
      python3-pip && \
      pip3 install --upgrade pip && \
      dnf clean all && \
      rm -rf /var/cache/dnf/ && rm -rf /var/lib/dnf/

RUN git clone https://github.com/afourmy/eNMS.git
WORKDIR /eNMS

RUN pip3 install -r build/requirements/requirements.txt

RUN mkdir network_data && \
    chmod 777 ./files/apps/gotty


RUN sed -i 's/"end_port": 9100/"end_port": 9001/g' /eNMS/setup/settings.json && \
    export FLASK_APP=app.py

CMD flask run --host=0.0.0.0

EXPOSE 5000 9000
