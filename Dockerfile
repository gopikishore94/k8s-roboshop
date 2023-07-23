FROM almalinux:8
RUN yum update -y
RUN yum install nginx -y
RUN yum -y install wget
RUN rm -rf /usr/share/nginx/html/*
COPY . /usr/share/nginx/html/
CMD ["nginx", "-g", "daemon off;"]
# install the agent
RUN  mkdir /usr/local/newrelic-netcore20-agent \
&& cd /usr/local \
&& export NEW_RELIC_DOWNLOAD_URI=https://download.newrelic.com/$(wget -qO - "https://nr-downloads-main.s3.amazonaws.com/?delimiter=/&prefix=dot_net_agent/latest_release/newrelic-netcore20-agent" | grep -E -o 'dot_net_agent/latest_release/newrelic-netcore20-agent_[[:digit:]]{1,3}(\.[[:digit:]]{1,3}){3}_amd64\.tar\.gz') \
&& echo "Downloading: $NEW_RELIC_DOWNLOAD_URI into $(pwd)" \
&& wget -O - "$NEW_RELIC_DOWNLOAD_URI" | gzip -dc | tar xf -
# Enable the agent
ENV CORECLR_ENABLE_PROFILING=1 \
CORECLR_PROFILER={36032161-FFC0-4B61-B559-F6C5D41BAE5A} \
CORECLR_NEWRELIC_HOME=/usr/local/newrelic-netcore20-agent \
CORECLR_PROFILER_PATH=/usr/local/newrelic-netcore20-agent/libNewRelicProfiler.so \
NEW_RELIC_LICENSE_KEY=349c9fda2f94804307615d1bcaac44400643NRAL \
NEW_RELIC_APP_NAME="webserver"