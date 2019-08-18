FROM victor141516/nomachine

RUN apt-get update -y && apt-get install -y firefox && rm -rf /var/lib/apt/lists/*
CMD ["firefox"]
