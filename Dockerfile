FROM alpine:3.13

COPY cpanfile /src/
#ENV EV_EXTRA_DEFS -DEV_NO_ATFORK

RUN apk update && \
  apk add --no-cache perl perl-io-socket-ssl perl-dev g++ make wget curl mariadb-connector-c mariadb-connector-c-dev samba-client shadow tzdata patch

# install perl dependences
RUN curl -L https://cpanmin.us | perl - App::cpanminus
RUN cd /src && \
  cpanm --installdeps . -M https://cpan.metacpan.org
# cleanup
#  apk del perl-dev g++ wget curl mariadb-connector-c-dev shadow && \
#  rm -rf /root/.cpanm/* /usr/local/share/man/* /src/cpanfile

EXPOSE 3000

