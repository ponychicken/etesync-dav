# Builds a standalone executable from the etesync-dav docker image.
# This Dockerfile provides a consistent build environment that runs the
# bundle.sh script to create platform-specific packages.
#
# The etesync/etesync-dav base image is built from the Dockerfile in the
# root of this repository.
#
# Make sure etesync/etesync-dav is up to date and then
# docker build -t etesync-dav-bundle -f pyinstaller/Dockerfile .
# docker run --rm -it -u $(id -u):$(id -g) -v $(pwd):/repo etesync-dav-bundle

FROM etesync/etesync-dav

USER root

RUN uv pip install PyInstaller

USER etesync

ENTRYPOINT ["bash"]
CMD ["-c", "cd /repo/pyinstaller && ./bundle.sh"]
