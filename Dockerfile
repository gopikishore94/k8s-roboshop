FROM almalinux:8
ENV NEW_RELIC_LICENSE_KEY=349c9fda2f94804307615d1bcaac44400643NRAL
# Install the New Relic Browser agent
RUN dnf -y update && dnf -y install wget gnupg ca-certificates \
    && wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-newrelic https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg \
    && rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-newrelic \
    && echo "[newrelic-infra]" > /etc/yum.repos.d/newrelic-infra.repo \
    && echo "name=New Relic Infrastructure" >> /etc/yum.repos.d/newrelic-infra.repo \
    && echo "baseurl=https://download.newrelic.com/infrastructure_agent/linux/yum/el/8/\$basearch" >> /etc/yum.repos.d/newrelic-infra.repo \
    && echo "gpgcheck=1" >> /etc/yum.repos.d/newrelic-infra.repo \
    && echo "gpgkey=https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg" >> /etc/yum.repos.d/newrelic-infra.repo \
    && dnf -y install newrelic-infra
RUN yum install nginx -y
RUN rm -rf /usr/share/nginx/html/*
COPY . /usr/share/nginx/html/
CMD ["nginx", "-g", "daemon off;"]