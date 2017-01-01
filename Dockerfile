FROM alpine:3.5

#
# BASE PACKAGES
#
RUN apk add --no-cache bash && \
    apk add --no-cache python && \
    apk add --no-cache py2-pip && \
    apk add --no-cache py2-crypto && \
    apk add --no-cache py2-curl && \
    pip install --upgrade pip && \
    mkdir /pyapp/

#
# PREPARE USER MODE
#
COPY run.sh /pyapp/run.sh
RUN touch /pyapp/run.sh && \
    adduser -S pyworker && \
    chown root:root /pyapp/run.sh && \
    chmod u+rwx,g+rwx,o-w,o+rx /pyapp/run.sh && \
    chmod o+rx /pyapp && \
    mkdir -p /pyapp/web  && chown -R pyworker:root /pyapp/web  && \
    mkdir -p /pyapp/data && chown -R pyworker:root /pyapp/data

#
# VOLUMES AND EXPOSE
#
VOLUME ["/pyapp/web"]
VOLUME ["/pyapp/data"]
EXPOSE 8000

#
# RUN IN USER MODE
#
USER pyworker
CMD ["/pyapp/run.sh"]
