FROM alpine:latest AS builder

ARG TARGETARCH
ARG HELIX_VERSION=25.07.1

WORKDIR /build

# Install dependencies
RUN apk add --no-cache curl tar xz

# Download and extract Helix
RUN case "${TARGETARCH}" in \
      "amd64") HELIX_ARCH="x86_64" ;; \
      "arm64") HELIX_ARCH="aarch64" ;; \
      *) echo "Unsupported architecture: ${TARGETARCH}"; exit 1 ;; \
    esac && \
    echo "Downloading Helix ${HELIX_VERSION} for ${HELIX_ARCH}..." && \
    curl -L "https://github.com/helix-editor/helix/releases/download/${HELIX_VERSION}/helix-${HELIX_VERSION}-${HELIX_ARCH}-linux.tar.xz" -o helix.tar.xz && \
    tar -xf helix.tar.xz --strip-components=1

# Prepare install directory
RUN mkdir -p /dropzone/install && \
    mv hx /dropzone/install/ && \
    mv runtime /dropzone/install/

# Final stage
FROM scratch

LABEL dropzone.package="helix"

COPY --from=builder /dropzone/install /dropzone/install
