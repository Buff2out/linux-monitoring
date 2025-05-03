// use procfs::process::MountInfo;
// use nix::statvfs;

use sysinfo::Disks;


pub struct Info {
    name: String,
    filesystem: Filesystem,
    total: u64,
    used: u64,
    free: u64,
}

enum Filesystem {
    Fat32,
    Exfat,
    Ext4,
    Ntfs,
    Btrfs,
    Unknown,
}

impl Info {
    pub fn get() {
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