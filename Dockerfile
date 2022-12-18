FROM golang:1.19.1-buster as go-target
RUN apt-get update && apt-get install -y wget
ADD . /go-astits
WORKDIR /go-astits/cmd/astits-probe
RUN go build
RUN wget https://filesamples.com/samples/video/ts/sample_640x360.ts
RUN wget https://filesamples.com/samples/video/ts/sample_960x540.ts

FROM golang:1.19.1-buster
COPY --from=go-target /go-astits/cmd/astits-probe/astits-probe /
COPY --from=go-target /go-astits/cmd/astits-probe/*.ts /testsuite/

ENTRYPOINT []
CMD ["/astits-probe", "-i", "@@"]

