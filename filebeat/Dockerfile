ARG ES_VERSION
FROM docker.elastic.co/beats/filebeat:$ES_VERSION

COPY filebeat.yml /usr/share/filebeat/filebeat.yml
COPY filebeat-start.sh filebeat-start.sh

USER root
RUN chown root:filebeat /usr/share/filebeat/filebeat.yml && \
    chmod go-w /usr/share/filebeat/filebeat.yml && \
    chmod 777 filebeat-start.sh

ENV INDEX_PATTERN filebeat
USER filebeat
CMD ["./filebeat-start.sh"]
