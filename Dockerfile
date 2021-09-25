FROM golang AS build
COPY ./ /work
WORKDIR /work
RUN go build

FROM alpine:3
EXPOSE 3000
COPY --from=build /work/drone-secret-plugin /bin/
RUN apk update && apk add gcompat
ENTRYPOINT ["/bin/drone-secret-plugin"]
