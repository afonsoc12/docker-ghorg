ARG USER=coolio \
    GROUP=coolio \
    UID=1234 \
    GID=4321

# Build image
FROM --platform=$BUILDPLATFORM golang:1.18 AS build-image
# ARG BUILDPLATFORM
# ARG TARGETPLATFORM
# ARG TARGETOS
# ARG TARGETARCH

ENV GO111MODULE=on \
    CGO_ENABLED=0
    # TARGET_OS=${TARGETOS} \
    # TARGET_ARCH=${TARGETARCH}

WORKDIR /go/src/github.com/gabrie30/ghorg

COPY . .

RUN go get -d -v ./... \
    && go build -a --mod vendor -o ghorg .

# Runtime image
FROM alpine:latest AS runtime-image

ARG USER \
    GROUP \
    UID \
    GID

ENV XDG_CONFIG_HOME=/config \
    GHORG_CONFIG=/config/conf.yaml \
    GHORG_RECLONE_PATH=/config/reclone.yaml \
    GHORG_ABSOLUTE_PATH_TO_CLONE_TO=/data

RUN apk add -U --no-cache ca-certificates tzdata git \
    && mkdir -p /data $XDG_CONFIG_HOME \
    && addgroup --gid $GID $GROUP \
    && adduser -D -H --gecos "" \
                     --home "/home" \
                     --ingroup "$GROUP" \
                     --uid "$UID" \
                     "$USER" \
    && chown -R $USER:$GROUP /home /data $XDG_CONFIG_HOME \
    && rm -rf /tmp/* /var/{cache,log}/* /var/lib/apt/lists/*

USER $USER
WORKDIR /data

# Copy compiled binary
COPY --from=build-image --chown=$USER:$GROUP /go/src/github.com/gabrie30/ghorg/ghorg /usr/local/bin

VOLUME /data

ENTRYPOINT ["ghorg"]
CMD ["--help"]
