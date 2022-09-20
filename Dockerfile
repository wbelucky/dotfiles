FROM ubuntu:20.04

ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# install prerequirements

# curl wget tmux git pip3 fish
RUN apt-get update -y \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    curl wget tmux software-properties-common python3-pip tzdata sudo gosu \
  && add-apt-repository -y ppa:git-core/ppa \
  && add-apt-repository -y ppa:fish-shell/release-3 \
  && apt-get update -y \
  && apt-get install -y --no-install-recommends fish git
  # && chsh -s fish

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

USER root
WORKDIR /workspace
COPY docker-entrypoint.sh /usr/local/bin/entrypoint.sh
ENV USERNAME=$USERNAME
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["fish"]

