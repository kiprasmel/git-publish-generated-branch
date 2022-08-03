FROM archlinux:base-devel

RUN pacman -Syu --noconfirm
RUN pacman -S git --noconfirm

COPY dockerfile-entrypoint.sh /dockerfile-entrypoint.sh
COPY git-publish-generated-branch /git-publish-generated-branch

ENTRYPOINT ["/dockerfile-entrypoint.sh"]
