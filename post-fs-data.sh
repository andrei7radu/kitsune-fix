#!/system/bin/sh
MODDIR=${0%/*}

OLD_PKG="io.github.huskydg.magisk"
NEW_PKG="io.github.x0eg0.magisk"

# 1. Target the Device Encrypted (DE) storage
DE_TARGET="/data/user_de/0/$OLD_PKG"
DE_SOURCE="/data/user_de/0/$NEW_PKG"

# If the new package directory exists but the old one doesn't, create a symlink
if [ -d "$DE_SOURCE" ] && [ ! -e "$DE_TARGET" ]; then
    ln -s "$DE_SOURCE" "$DE_TARGET"
    # Clone the ownership and SELinux context from the source to the symlink
    chown -h $(stat -c '%U:%G' "$DE_SOURCE") "$DE_TARGET"
    chcon -h $(stat -c '%C' "$DE_SOURCE") "$DE_TARGET"
fi

# 2. Target the Credential Encrypted (CE) storage
CE_TARGET="/data/data/$OLD_PKG"
CE_SOURCE="/data/data/$NEW_PKG"

if [ -d "$CE_SOURCE" ] && [ ! -e "$CE_TARGET" ]; then
    ln -s "$CE_SOURCE" "$CE_TARGET"
    chown -h $(stat -c '%U:%G' "$CE_SOURCE") "$CE_TARGET"
    chcon -h $(stat -c '%C' "$CE_SOURCE") "$CE_TARGET"
fi
