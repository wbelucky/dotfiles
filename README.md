# wbelucky-dotfiles with docker

## usage

```bash
# installs all dependencies, creates symlinks, and install vim plugins
git clone https://github.com/wbelucky/dotfiles-with-docker && cd dotfiles-with-docker && install.sh
```

## use docker image

```bash
# you can emulate this enviroment on docker, and can edit dotfiles.
docker-compose run dev
```

```bash
# you can emulate this env while editing local files on docker.
./try.sh <dir>
```
