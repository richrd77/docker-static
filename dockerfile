FROM nginx:latest

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN addgroup --system --gid $GROUP_ID nonroot && \
    adduser --system --uid $USER_ID --ingroup nonroot nonroot

RUN mkdir -p /var/cache/nginx/client_temp && \
    chown -R nonroot:nonroot /var/cache/nginx && \
    chmod -R 770 /var/cache/nginx

RUN sed -i 's#/var/run/nginx.pid#/var/cache/nginx/nginx.pid#' /etc/nginx/nginx.conf

COPY . /usr/share/nginx/html
RUN chown -R nonroot:nonroot /usr/share/nginx/html

EXPOSE 80

USER nonroot

CMD ["nginx", "-g", "daemon off;"]