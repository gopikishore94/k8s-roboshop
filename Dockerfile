FROM almalinux:8
RUN yum update -y
ENV NEW_RELIC_LICENSE_KEY=349c9fda2f94804307615d1bcaac44400643NRAL
RUN yum install nginx -y
RUN yum -y install wget
RUN rm -rf /usr/share/nginx/html/*
RUN wget -O /usr/share/nginx/html/newrelic.js "https://js-agent.newrelic.com/nr-loader-full.js" \
COPY . /usr/share/nginx/html/
CMD ["nginx", "-g", "daemon off;"]