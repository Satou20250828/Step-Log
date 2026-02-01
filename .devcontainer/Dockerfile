FROM ruby:3.3
RUN apt-get update -y && apt-get install -y git curl vim build-essential libpq-dev && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs && rm -rf /var/lib/apt/lists/*
WORKDIR /workspace