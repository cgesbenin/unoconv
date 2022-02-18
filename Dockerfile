FROM python:bullseye

ENV LC_ALL=en_US.UTF-8 \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8

# copy unconv files
COPY ./requirements.txt /tmp/requirements.txt


RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
        gcc \
        g++ \
        libc-dev \
        curl \
        unoconv \
        libreoffice-common \
        libreoffice-writer \
        libreoffice-calc \
        libreoffice-impress \
        fonts-dejavu \
        fonts-freefont-ttf \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/list/* \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && pip install -r /tmp/requirements.txt

# copy unconv files
COPY . /unoconv

RUN rm -rf /unoconv/.git

WORKDIR /unoconv

EXPOSE 5000

ENTRYPOINT circusd circus.ini
