FROM ubuntu
RUN ["apt-get", "update"]
RUN ["apt-get","install","-y","python-pip","python-dev","build-essential"]
RUN mkdir /app
ENV APP_NAME="Curso DevOps"
ENV APP_COLOR="blue"
ADD templates /app/templates
COPY requirements.txt /app
COPY color.py /app
EXPOSE 9090
RUN ["pip","install","-r","/app/requirements.txt"]
ENTRYPOINT ["/usr/bin/python","/app/color.py"]
