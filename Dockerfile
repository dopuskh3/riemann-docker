FROM ubuntu
MAINTAINER Francois Visconte <f.visconte@gmail.com>

# Install dependencies
RUN apt-get update
RUN apt-get install -y curl default-jre-headless ruby libyajl-dev ruby-dev build-essential

# Download the latest .deb and install
RUN curl http://aphyr.com/riemann/riemann_0.2.6_all.deb > /tmp/riemann_0.2.6_all.deb
RUN dpkg -i /tmp/riemann_0.2.6_all.deb
RUN gem install --verbose --no-rdoc riemann-client riemann-tools riemann-dash thin

# Expose the ports for inbound events and websockets
EXPOSE 5555
EXPOSE 5555/udp
EXPOSE 5556
EXPOSE 4567

# Share the config directory as a volume
VOLUME /etc/riemann
ADD riemann.config /etc/riemann/riemann.config
ADD riemann-dash-config.rb /etc/riemann-dash/config.rb
ADD start-riemann.sh /usr/bin/start-riemann.sh
ADD config.json /etc/riemann-dash/config.json

# Set the hostname in /etc/hosts so that Riemann doesn't die due to unknownHostException
#
CMD bash /usr/bin/start-riemann.sh



