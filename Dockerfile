FROM jupyter/datascience-notebook

USER root

RUN apt-get update -y && apt-get install -y wget git pkg-config libzmq3-dev graphviz

USER $NB_UID

RUN wget -q https://storage.googleapis.com/golang/getgo/installer_linux
RUN chmod +x installer_linux
RUN ./installer_linux

ENV GOPATH /home/jovyan/go
ENV PATH $PATH:/home/jovyan/.go/bin
ENV PATH $PATH:/home/jovyan/go/bin

RUN go get -u github.com/gopherdata/gophernotes
RUN mkdir -p ~/.local/share/jupyter/kernels/gophernotes
RUN cp $GOPATH/src/github.com/gopherdata/gophernotes/kernel/* ~/.local/share/jupyter/kernels/gophernotes
RUN pip install --upgrade pip && \
     pip install git+git://github.com/xapharius/cppmagic.git

COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt
