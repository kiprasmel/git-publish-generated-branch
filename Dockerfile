FROM alpine:3.16

COPY git-publish-generated-branch /git-publish-generated-branch

ENTRYPOINT ["/git-publish-generated-branch"]
