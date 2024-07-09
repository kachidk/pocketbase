# Pocketbase Starter

## Usage

Required packages `wget` and `unzip`.

```sh
chmod +x ./install.sh

./install.sh [version]
```

The PocketBase binary will be installed in the same directory as install.sh.

## Production

Cross-check the version in Dockerfile.

To persist your data you need to mount a volume at `/pb/pb_data`.
