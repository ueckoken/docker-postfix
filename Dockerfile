FROM ubuntu:22.04
RUN apt update && apt install -y postfix && rm -rf /var/lib/lists/*
RUN addgroup --system --gid 5000 vmail \
  && adduser --system --uid 5000 --gid 5000 vmail
COPY main.cf /etc/postfix/main.cf
COPY virtual /etc/postfix/virtual
RUN postmap /etc/postfix/virtual
RUN postfix check
EXPOSE 25/tcp
CMD ["postfix", "start-fg"]
