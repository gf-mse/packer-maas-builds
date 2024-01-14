sudo apt update -y
# ubuntu [ https://maas.io/docs/customising-images-for-specific-needs#heading--how-to-install-packer ]
sudo apt install -y qemu-utils qemu-system ovmf cloud-image-utils make git
# CentOS 8
sudo apt install -y qemu-utils libnbd-bin nbdkit  fuse2fs
