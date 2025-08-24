FROM alpine:3.15
MAINTAINER Ignacio José
ENV PYTHONUNBUFFERED 1

RUN apk add --update git py3-usb py3-pip py3-setuptools eudev libusb libusb-dev vim
RUN mkdir -p /app /etc/udev/rules.d /root/.config/antfs-cli/logs
RUN pip install --upgrade pip
WORKDIR /app
RUN git clone https://github.com/Tigge/antfs-cli.git

RUN cd antfs-cli && pip3 install --no-cache-dir "git+https://github.com/Tigge/openant#egg=openant" && cd ..
RUN cd antfs-cli && pip3 install -r requirements.txt && cd ..
RUN cd antfs-cli && python3 setup.py install && cd ..
RUN mkdir -p /root/.config/antfs-cli
COPY manager.py /app/antfs-cli/src/openant/openant/fs/manager.py
ENV PYTHONPATH="/app/antfs-cli/src/openant:${PYTHONPATH}"
VOLUME ["/app/data"]
# ENTRYPOINT ["/bin/sh"]
CMD antfs-cli; cp -R /root/.config/antfs-cli /app/data

