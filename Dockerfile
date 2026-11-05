FROM eclipse-temurin:11-jre-jammy

ARG HADOOP_VERSION=3.4.1
ENV HADOOP_HOME=/opt/hadoop \
    HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop \
    JAVA_HOME=/opt/java/openjdk \
    PATH=/opt/hadoop/bin:/opt/hadoop/sbin:$PATH

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates bash procps \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fSL --retry 3 "https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz" -o /tmp/hadoop.tar.gz \
    && mkdir -p /opt/hadoop \
    && tar -xzf /tmp/hadoop.tar.gz -C /opt/hadoop --strip-components=1 \
    && rm /tmp/hadoop.tar.gz \
    && mkdir -p /data/name /data/data

COPY config/core-site.xml config/hdfs-site.xml /opt/hadoop/etc/hadoop/
COPY scripts/entrypoint.sh /usr/local/bin/hdfs-lab-entrypoint
RUN chmod +x /usr/local/bin/hdfs-lab-entrypoint

ENTRYPOINT ["/usr/local/bin/hdfs-lab-entrypoint"]
