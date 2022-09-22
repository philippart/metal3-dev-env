#!/bin/bash -x

# copies manually downloaded IPA image to target directory

# you can manually download IPA and untar with
# curl https://images.rdoproject.org/centos9/master/rdo_trunk/current-tripleo/ironic-python-agent.tar
# curl -g --dump-header ironic-python-agent.tar.headers https://images.rdoproject.org/centos9/master/rdo_trunk/current-tripleo/ironic-python-agent.tar
# tar xvf ironic-python-agent.tar

ETAG=$(awk '/ETag:/ {print $2}' ironic-python-agent.tar.headers | tr -d "\"\r")
ROOT=/opt/metal3-dev-env/ironic/html/images
DIR=$ROOT/ironic-python-agent-$ETAG

mkdir $DIR
for EXT in 'kernel' 'initramfs' 'tar.headers'; do
  FILE=ironic-python-agent.$EXT
  cp  $FILE $DIR
  ln -s $DIR/$FILE $ROOT/$FILE
done
