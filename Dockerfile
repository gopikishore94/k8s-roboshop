FROM almalinux:8
RUN yum update -y
RUN yum install nginx -y
RUN yum -y install wget
RUN rm -rf /usr/share/nginx/html/*
COPY . /usr/share/nginx/html/
CMD ["nginx", "-g", "daemon off;"]
# install the agent
ENV NEW_RELIC_LICENSE_KEY \
RUN wget -O /usr/share/nginx/html/newrelic.js "https://js-agent.newrelic.com/nr-loader-full.js" \
NEW_RELIC_LICENSE_KEY=349c9fda2f94804307615d1bcaac44400643NRAL \
NEW_RELIC_APP_NAME="webserver"