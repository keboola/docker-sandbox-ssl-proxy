FROM nginx:1.13-alpine

ADD ./nginx/proxy.conf /etc/nginx/conf.d/default.conf
ADD ./run.sh /code/run.sh

CMD /code/run.sh

