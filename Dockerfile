FROM almalinux:8
RUN yum update -y
RUN yum install nginx -y
#RUN mkdir -p /usr/share/nginx/html/qi
COPY ./* /usr/share/nginx/html/
CMD ["nginx", "-g", "daemon off;"]
