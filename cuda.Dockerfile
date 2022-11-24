
# ref: https://blog.shikoan.com/wsl2-pytorch-image-custom-build/amp/
FROM kusabiraki-cuda-python3.9:latest


# ARG USERNAME=user
# ARG USER_UID=1000
# ARG USER_GID=$USER_UID
# 
# RUN apt-get -y update && apt-get install -y sudo
# 
# # Create the user
# RUN groupadd --gid $USER_GID $USERNAME \
#     && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
#     && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
#     && chmod 0440 /etc/sudoers.d/$USERNAME
# 
# WORKDIR /app
# RUN apt-get install -y software-properties-common tzdata
# ENV TZ=Asia/Tokyo
# RUN add-apt-repository ppa:deadsnakes/ppa
# RUN apt-get -y install python3.9 python3-pip && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 10
# 
# USER $USERNAME
# ENV PATH /home/$USERNAME/.local/bin:$PATH
# RUN python3 -m pip install -U pip wheel setuptools numpy
# RUN python3 -m pip install torch==1.11.0+cu113 -f https://download.pytorch.org/whl/torch_stable.html
# 
# dotfiles from here

USER root
RUN apt-get update -y \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    curl wget tmux software-properties-common python3-pip tzdata \
  && add-apt-repository -y ppa:git-core/ppa \
  && add-apt-repository -y ppa:fish-shell/release-3 \
  && apt-get update -y \
  && apt-get install -y --no-install-recommends fish git gosu

USER $USERNAME
ENV TZ="Asia/Tokyo" HOME=/home/$USERNAME DOTFILES=/home/$USERNAME/dotfiles
RUN cd && git clone https://github.com/wbelucky/dotfiles-with-docker dotfiles && cd dotfiles && ./install.sh

WORKDIR /workspace
USER root
COPY docker-entrypoint.sh /usr/local/bin/entrypoint.sh
ENV USERNAME=$USERNAME

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["fish"]

# 確認方法: https://note.nkmk.me/python-pytorch-cuda-is-available-device-count/
