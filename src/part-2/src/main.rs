/*  
Mostly use this as lib.rs
https://docs.rs/sysinfo/latest/sysinfo/
*/
mod general;
mod timedate;
mod network;
mod memory;
mod disk;

use std::io::{self, Write};

#[derive(Debug)]
struct Sys {
    general: general::Info,
    timedate: timedate::Info,
    network: Vec<network::Info>,
    ram: memory::Info,
    disk: Vec<disk::Info>,
}


impl Sys {
    pub fn collect() -> Self {
        Self {
            general: general::Info::new(), 
            timedate: timedate::Info::new(),
            network: network::Info::new(),
            ram: memory::Info::new(),
            disk: disk::Info::new(), 
        }
    }
    pub fn to_str(&self) -> String {
        use std::net::{IpAddr, Ipv4Addr};
        let ip = match self.network[0].ips().is_empty() {
            true => IpAddr::V4(Ipv4Addr::new(0, 0, 0, 0)), // да, знаю, что для ipv6 не подойдёт, но как заглушка
            false => self.network[0].ips()[0].ip(), // почему нет
        };
        let mask_ip = match self.network[0].ips().is_empty() {
            true => 255, // да, знаю, что для ipv6 не подойдёт, но как заглушка
            false => self.network[0].ips()[0].mask(), // почему нет
        };
        format!(
            "HOSTNAME = {}\n\
            TIMEZONE = {}\n\
            USER = {:?}\n\
            OS = {}\n\
            DATE = {}\n\
            UPTIME = {}\n\
            UPTIME_SEC = {}\n\
            INTERFACE = {}\n\
            IP = {:?}\n\
            MASK = {}\n\
            GATEWAY = {}\n\
            RAM_TOTAL = {}\n\
            RAM_USED = {}\n\
            RAM_FREE = {}\n\
            DISK = {}\n\
            FSTYPE = {}\n\
            SPACE_ROOT = {}\n\
            SPACE_ROOT_USED = {}\n\
            SPACE_ROOT_FREE = {}",
            self.general.hostname(),
            self.timedate.timezone(),
            self.general.users(),
            self.general.os(),
            self.timedate.date(),
            self.timedate.uptime(),
            self.timedate.uptime_sec(),
            self.network[0].name(),
            ip, 
            mask_ip,
            ip,
            self.ram.total(),
            self.ram.used(),
            self.ram.free(),
            self.disk[0].name(),
            match self.disk[0].filesystem() {
                disk::Filesystem::Btrfs => "btrfs",
                disk::Filesystem::Exfat => "Exfat",
                disk::Filesystem::Ext4 => "Ext4",
                disk::Filesystem::Fat32 => "Fat32",
                disk::Filesystem::Ntfs => "Ntfs",
                disk::Filesystem::Unknown => "Unknown",
            },
            self.disk[0].total(),
            self.disk[0].used(),
            self.disk[0].free(),

        )
    }
    pub fn write_to_file(self, path: &str) -> Result<(), io::Error> {
        let binding = Sys::to_str(&self);
        let data = binding.as_bytes();
        std::fs::File::create(path)?.write_all(data)?;
        Ok(())
    }

}

// TODO: Create MORE PRETTY print structure

fn main() -> Result<(), io::Error> {
    let sys = Sys::collect();
    let file = sys.timedate.uptime_sec().to_string();
    sys.write_to_file(&format!("./{}", file))
}
