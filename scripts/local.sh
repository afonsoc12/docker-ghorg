docker buildx build --file Dockerfile --progress=plain --no-cache --load --platform linux/arm --tag dev-cloudflared  .
docker run --rm -it afonsoc12/cloudflared