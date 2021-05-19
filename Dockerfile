FROM ubuntu:latest AS build
USER root
RUN apt update -y && \
    apt install -y autoconf automake \
    libtool git make
COPY . /curl
WORKDIR /curl
#RUN git clone https://github.com/curl/curl.git
#WORKDIR curl
RUN autoreconf -fi
RUN ./configure --disable-shared --enable-debug --enable-maintainer-mode --without-ssl
RUN make


FROM ubuntu:latest

COPY --from=build /curl/src/curl .

CMD ["./curl", "tut.by"]
