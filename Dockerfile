FROM ubuntu:21.04

# Setup X Window Virtual Framebuffer
ENV SCREEN_COLOUR_DEPTH 24
ENV SCREEN_HEIGHT 1080
ENV SCREEN_WIDTH 1920


# Set up a volume for the generated reports
VOLUME /opt/robotframework/reports
VOLUME /opt/robotframework/tests

#Avoid tzdata and timezone during build
ENV TZ=Europe/Prague
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY bin/run-test.sh .

# Příprava kontejneru aby vůbec spustil co potřebuju
RUN apt-get update \
	&& apt-get install -y build-essential libssl-dev libffi-dev python-dev \
		python3-pip \
    python-dev \
    gcc \
    g++ \
    firefox \
		xvfb \
    zip \
    wget \
    ca-certificates \
    ntpdate \
		libnss3-dev \
    libssl-dev \
    libxss1 \
    libappindicator3-1 \
    libindicator7 \
    gconf-service \
    libgconf-2-4 \
    libpango1.0-0 \
    xdg-utils \
    fonts-liberation \
    curl \
    libffi-dev \
    musl-dev \
	&& rm -rf /var/lib/apt/lists/*


# Java 11
RUN apt-get update && \
    apt-get install -y openjdk-11-jre-headless && \
    apt-get clean;

# Mozzila
RUN wget -q https://github.com/mozilla/geckodriver/releases/download/v0.24.0/geckodriver-v0.24.0-linux64.tar.gz \
	&& tar xvzf geckodriver-*.tar.gz \
	&& rm geckodriver-*.tar.gz \
	&& mv geckodriver /usr/local/bin \
	&& chmod a+x /usr/local/bin/geckodriver

# install chrome and chromedriver in one run command to clear build caches for new versions (both version need to match)
RUN curl https://chromedriver.storage.googleapis.com/90.0.4430.24/chromedriver_linux64.zip -O
RUN unzip chromedriver_linux64.zip 

#Instalace python závislostí
COPY requirements.txt .
RUN pip install -r requirements.txt


ENTRYPOINT [ "./run-test.sh" ]