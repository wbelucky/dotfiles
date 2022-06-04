FROM ubuntu:20.04

ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# https://zenn.dev/koralle/articles/6595594da018dc
RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y autoremove \
    && apt-get -y make sudo

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME


WORKDIR /workspace 
RUN chown $USERNAME:$USERNAME /workspace
ENV HOME=/home/$USERNAME

COPY ./nvim/ $HOME/.config/nvim/
RUN chown -R $USERNAME:$USERNAME $HOME/.config


USER $USERNAME
RUN make


# RUN add-apt-repository ppa:deadsnakes/ppa && apt install -y python3.10
