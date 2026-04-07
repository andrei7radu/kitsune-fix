# Kitsune Mask IPC Bridge Fix

A lightweight Magisk module designed to fix the IPC Bridge crashes and `Failed to stat` errors occurring in Kitsune Mask (v30.7+).

## The Bug
In recent updates, Kitsune Mask changed its package name from `io.github.huskydg.magisk` to `io.github.x0eg0.magisk`. However, the native `magiskd` daemon still contains hardcoded references to the old `huskydg` path. When the daemon attempts to read the database at the old path, it hits a wall, causing `Failed to stat` errors and IPC Bridge disconnections.

## The Fix
This module uses a lightweight `post-fs-data.sh` script executing in the `u:r:magisk:s0` SELinux context to intercept the boot sequence. It dynamically checks for the new `x0eg0` directory and creates seamless symlinks (`ln -s`) from the old `huskydg` path to the new one. 

Crucially, it safely copies the exact UID/GID ownership and SELinux contexts from the real folder to the symlink, ensuring Android's Mandatory Access Control (MAC) does not block the Magisk daemon's read requests.

## Installation
1. Download the latest `.zip` release.
2. Open Magisk / Kitsune Mask.
3. Go to the **Modules** tab.
4. Tap **Install from storage** and select the zip.
5. Reboot your device.

## Compatibility
- Architecture agnostic (Works on ARM64, ARM32, x86)
- Android 13 / 14+ compatible
- Zero CPU overhead (relies on Linux kernel VFS symlinking)
