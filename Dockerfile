FROM alpine:3.15.3 as builder

RUN \
	apk -U upgrade --no-cache && \
	apk add --no-cache build-base git 

COPY . /tmp/beanstalkd
RUN \ 
	cd /tmp/beanstalkd && \
	make 

################################
FROM alpine:3.15.3

RUN apk -U upgrade --no-cache 

COPY --from=builder /tmp/beanstalkd/beanstalkd /usr/bin/

RUN mkdir /beanstalkd
EXPOSE 11300
ENTRYPOINT ["/usr/bin/beanstalkd"]
