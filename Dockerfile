FROM ubuntu:20.04

ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# https://zenn.dev/koralle/articles/6595594da018dc
RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get autoremove -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:git-core/ppa \
    && apt-get update -y

RUN apt-get install -y neovim curl git 
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash && apt-get install -y nodejs

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

WORKDIR /workspace 
RUN chown $USERNAME:$USERNAME /workspace
ENV HOME=/home/$USERNAME

COPY ./nvim/ $HOME/.config/nvim/
RUN chown -R $USERNAME:$USERNAME $HOME/.config

USER $USERNAME
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
RUN nvim --headless +'PlugInstall --sync' +qall

RUN nvim --headless +'CocInstall coc-pyright -sync' +qall
USER root

# RUN add-apt-repository ppa:deadsnakes/ppa && apt install -y python3.10
