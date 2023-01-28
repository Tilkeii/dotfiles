FROM ubuntu
ARG USERNAME=dev

# Let scripts know we're running in Docker (useful for containerised development)
ENV RUNNING_IN_DOCKER true
# Use the unprivileged default `dev` user (created without a password ith `-D`) for safety
RUN adduser --disabled-password ${USERNAME}
RUN mkdir -p /app \
    && chown -R ${USERNAME}:${USERNAME} /app

# Set up ZSH and our preferred terminal environment for containers
RUN apt update -y \
	&& apt upgrade -y \
	&& apt install -y \
	zsh \
	curl \
	git \
	sudo \
	ca-certificates \
	fontconfig

# Ensure default dev user has access to `sudo`
RUN usermod -aG sudo ${USERNAME}

RUN mkdir -p /home/${USERNAME}/.antigen
RUN curl -L git.io/antigen > /home/${USERNAME}/.antigen/antigen.zsh

# Copy our config
COPY .zshrc /home/${USERNAME}/.zshrc
COPY .p10k.zsh /home/${USERNAME}/.p10k.zsh
RUN chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.antigen /home/${USERNAME}/.zshrc /home/${USERNAME}/.p10k.zsh

# Set up ZSH as the unprivileged user (we just need to start it, it'll initialise our setup itself)
USER ${USERNAME}
RUN /bin/zsh /home/${USERNAME}/.zshrc

# Switch back to root for whatever else we're doing
USER root

# Install font 
COPY meslo-lgs-nf-regular.ttf /usr/share/fonts/meslo-lgs-nf-regular.ttf
RUN fc-cache -f -v

# Install volta
RUN curl https://get.volta.sh | bash
ENV VOLTA_HOME /root/.volta
ENV PATH ${VOLTA_HOME}/bin:$PATH
RUN volta install node
