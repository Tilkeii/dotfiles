FROM ubuntu
ARG USERNAME=dev

# Set distribution as noninteractive to disable prompt when installing
ENV DEBIAN_FRONTEND=noninteractive
# Let scripts know we're running in Docker (useful for containerised development)
ENV RUNNING_IN_CONTAINER true
# Set timezone
ENV TZ=Europe/Paris

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
	exa \
	tzdata

# Ensure default dev user has access to `sudo`
RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
  && chmod 0440 /etc/sudoers.d/$USERNAME

# Set up ZSH as the unprivileged user (we just need to start it, it'll initialise our setup itself)
USER ${USERNAME}

RUN mkdir -p /home/${USERNAME}/.antigen
RUN curl -L git.io/antigen > /home/${USERNAME}/.antigen/antigen.zsh

# Copy our config
COPY --chown=dev ../.zshrc /home/${USERNAME}/.zshrc
COPY --chown=dev ../.p10k.zsh /home/${USERNAME}/.p10k.zsh
# RUN chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.antigen

RUN /bin/zsh /home/${USERNAME}/.zshrc

# Install volta
RUN curl https://get.volta.sh | bash
ENV VOLTA_HOME /home/${USERNAME}/.volta
ENV PATH ${VOLTA_HOME}/bin:$PATH
RUN volta install node
