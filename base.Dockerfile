FROM ubuntu:20.04

ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get autoremove -y \
    && apt-get install -y make

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME


ENV HOME=/home/$USERNAME
WORKDIR $HOME/dotfiles
RUN chown -R $USERNAME:$USERNAME $HOME/dotfiles

USER $USERNAME
ENV USERNAME=$USERNAME
ENV TZ="Asia/Tokyo"
ENV HOME=/home/$USERNAME
ENV DOTFILES=$HOME/dotfiles

