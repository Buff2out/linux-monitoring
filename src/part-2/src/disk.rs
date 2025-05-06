// use procfs::process::MountInfo;
// use nix::statvfs;

use sysinfo::Disks;

#[derive(Debug)]
pub struct Info {
    name: String,
    filesystem: Filesystem,
    total: u64,
    used: u64,
    free: u64,
}

#[derive(Debug)]
pub enum Filesystem {
    Fat32,
    Exfat,
    Ext4,
    Ntfs,
    Btrfs,
    Unknown,
}

impl Info {
    pub fn new() -> Vec<Self> {
        let disks = Disks::new_with_refreshed_list();
        let mut res: Vec<Info> = Vec::new();
        for disk in disks.list() {
            let fs = disk.file_system();
            let fs = match fs.to_str() {
                Some(val) => &val.to_lowercase(),
                None => "unknown",
            };
            let name = disk.name();
            let name = match name.to_str()  {
                Some(val) => &val,
                None => "unknown",
            };
            let total = disk.total_space();
            let free = disk.available_space();
            let used = total - free;
            let disk= Info {
                name: String::from(name),
                total,
                used,
                free,
                filesystem: match fs {
                    s if s.contains("fat32") => Filesystem::Fat32,
                    s if s.contains("exfat") => Filesystem::Exfat,
                    s if s.contains("ext4") => Filesystem::Ext4,
                    s if s.contains("ntfs") => Filesystem::Ntfs,
                    s if s.contains("btrfs") => Filesystem::Btrfs,
                    _ => Filesystem::Unknown,
                },
            }; 
            res.push(disk);
        }
        res
    }
    pub fn name(&self) -> &str {
        &self.name
    }
    pub fn filesystem(&self) -> &Filesystem {
        &self.filesystem
    }
    pub fn total(&self) -> u64 {
        self.total
    }
    pub fn used(&self) -> u64 {
        self.used
    }
    pub fn free(&self) -> u64 {
        self.free
    }

}




// Магические значения для определения файловой системы
// https://github.com/torvalds/linux/blob/master/include/uapi/linux/magic.h

/*
Короч, доделать надо, 
возможно пока что распарсить системный вызов, 
там достать инфу о файловой системе
*/

// pub fn get_fs_type() -> Filesystem {
//     match {
//         0x9123683E =>
//     }
// }