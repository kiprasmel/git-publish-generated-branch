FROM ubuntu:22.04

COPY dockerfile-entrypoint.sh /dockerfile-entrypoint.sh
COPY git-publish-generated-branch /git-publish-generated-branch

CMD [ "/git-publish-generated-branch" ]
ENTRYPOINT ["/dockerfile-entrypoint.sh"]
