FROM ubuntu:20.04

ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID


# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update -y \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

ENV USERNAME=$USERNAME TZ="Asia/Tokyo" HOME=/home/$USERNAME DOTFILES=$HOME/dotfiles
WORKDIR $DOTFILES
COPY . $DOTFILES
RUN chown -R $USERNAME:$USERNAME $DOTFILES

ENV PATH="$HOME/.local/share/aquaproj-aqua/bin:$PATH" AQUA_GLOBAL_CONFIG=$DOTFILES/aqua.yaml
RUN ./install.sh


USER $USERNAME
WORKDIR /workspace
CMD ["fish"]

