FROM ubuntu

RUN apt-get update -y && apt-get install -y \
    software-properties-common \
    && add-apt-repository universe \
    && apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    curl \
    dbus-x11 \
    fonts-liberation \
    iputils-ping \
    libcap2-bin \
    libnss3 \
    libpango1.0-0 \
    pulseaudio \
    sudo \
    xdg-utils \
    xfce4 \
    xterm \
    && rm -rf /var/lib/apt/lists/*

RUN export URL=$(curl -s 'https://www.nomachine.com/download/download&id=6' | grep -oP "saveck.+\.deb" | grep -oP --color=never "https:\/\/download\.nomachine\.com\/download\/.+\.deb") \
    && curl -fSL $URL -o nomachine.deb \
    && dpkg -i nomachine.deb \
    && rm nomachine.deb

ENV USER=user

RUN groupadd -r $USER -g 433 \
    && useradd -u 431 -r -g $USER -d /home/$USER -s /bin/bash -c "$USER" $USER \
    && adduser $USER sudo \
    && mkdir /home/$USER \
    && chown -R $USER:$USER /home/$USER \
    && echo "$USER:passwd" | chpasswd

COPY run.sh /run.sh
ENTRYPOINT [ "./run.sh" ]
