FROM almalinux:8
ENV NEW_RELIC_LICENSE_KEY=349c9fda2f94804307615d1bcaac44400643NRAL
# Install the New Relic Browser agent
RUN apt-get update && apt-get install -y wget gnupg2 ca-certificates \
    && wget -O /etc/apt/trusted.gpg.d/newrelic.gpg https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg \
    && echo "deb http://download.newrelic.com/infrastructure_agent/linux/apt $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/newrelic-infra.list \
    && apt-get update \
    && apt-get install -y newrelic-bundle \
    && newrelic-install install
RUN yum install nginx -y
RUN rm -rf /usr/share/nginx/html/*
COPY . /usr/share/nginx/html/
CMD ["nginx", "-g", "daemon off;"]