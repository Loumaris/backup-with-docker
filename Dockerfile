FROM ruby:2.3-slim

# small bugfix
RUN for i in $(seq 1 8); do mkdir -p "/usr/share/man/man${i}"; done

# install backup gem
RUN apt update && \
    apt install -y wget build-essential && \
    gem install backup

# setup postgres client for backups
RUN wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O- | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" |  tee /etc/apt/sources.list.d/postgresql.list

RUN apt update && apt install -y  postgresql-client-10

# add configuration
WORKDIR /root/Backup

ADD Backup /root/Backup

# run backup
CMD [ "backup", "perform", "--trigger", "psql,folder"]