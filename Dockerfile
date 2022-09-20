FROM ubuntu:20.04

ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# install prerequirements

# curl wget tmux git pip3 fish

COPY scripts/prerequirements.sh /usr/local/bin/prerequirements.sh
RUN /usr/local/bin/prerequirements.sh
RUN apt-get install -y sudo gosu
# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
ENV TZ="Asia/Tokyo" HOME=/home/$USERNAME DOTFILES=/home/$USERNAME/dotfiles
ENV PATH="$HOME/.local/share/aquaproj-aqua/bin:$PATH" AQUA_GLOBAL_CONFIG=$DOTFILES/aqua.yaml
WORKDIR $DOTFILES
COPY --chown=$USERNAME:$USERNAME . $DOTFILES
RUN ./install.sh

WORKDIR /workspace
COPY docker-entrypoint.sh /usr/local/bin/entrypoint.sh
ENV USERNAME=$USERNAME
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["fish"]

