pub enum Info {
    filesystem(String),
    total(f64),
    used(f64),
    free(f64),
}

enum Filesystem {
    fat32,
    exfat,
    ext4,
    ntfs,
    btrfs,
    unknown,
}