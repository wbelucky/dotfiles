# build with command `docker build -t kusabiraki-cuda-python3.9-nvim -f cuda.Dockerfile .`

# ref: https://blog.shikoan.com/wsl2-pytorch-image-custom-build/amp/
FROM kusabiraki-cuda-python3.9:latest

# dotfiles from here

USER root
RUN apt-get update -y \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    curl wget tmux software-properties-common python3-pip tzdata \
  && add-apt-repository -y ppa:git-core/ppa \
  && add-apt-repository -y ppa:fish-shell/release-3 \
  && apt-get update -y \
  && apt-get install -y --no-install-recommends fish git gosu
# TODO: これをするとadd-apt-repositoryが死ぬ. ref: https://qiita.com/miyase256/items/665616d769f74158f1a1
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 10

USER user
ENV TZ="Asia/Tokyo" HOME=/home/user DOTFILES=/home/user/dotfiles
RUN cd && git clone https://github.com/wbelucky/dotfiles-with-docker dotfiles && cd dotfiles && ./install.sh

WORKDIR /workspace
USER root
COPY docker-entrypoint.sh /usr/local/bin/entrypoint.sh
ENV USERNAME=user

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["fish"]

# 確認方法: https://note.nkmk.me/python-pytorch-cuda-is-available-device-count/

