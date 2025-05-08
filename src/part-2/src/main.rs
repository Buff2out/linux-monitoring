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
    summary: String,
}


impl Sys {
    pub fn collect() -> Self {
        let general = general::Info::new();
        let timedate = timedate::Info::new();
        let network = network::Info::new();
        let ram = memory::Info::new();
        let disk = disk::Info::new();

        use std::net::{IpAddr, Ipv4Addr};
        let ip = match network[0].ips().is_empty() {
            true => IpAddr::V4(Ipv4Addr::new(0, 0, 0, 0)), // да, знаю, что для ipv6 не подойдёт, но как заглушка
            false => network[0].ips()[0].ip(), // почему нет
        };
        let mask_ip = match network[0].ips().is_empty() {
            true => 255, // да, знаю, что для ipv6 не подойдёт, но как заглушка
            false => network[0].ips()[0].mask(), // почему нет
        };
        

        let summary = format!(
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
            general.hostname(),
            timedate.timezone(),
            general.users(),
            general.os(),
            timedate.date(),
            timedate.uptime(),
            timedate.uptime_sec(),
            network[0].name(),
            ip, 
            mask_ip,
            ip,
            ram.total(),
            ram.used(),
            ram.free(),
            disk[0].name(),
            match disk[0].filesystem() {
                disk::Filesystem::Btrfs => "btrfs",
                disk::Filesystem::Exfat => "Exfat",
                disk::Filesystem::Ext4 => "Ext4",
                disk::Filesystem::Fat32 => "Fat32",
                disk::Filesystem::Ntfs => "Ntfs",
                disk::Filesystem::Unknown => "Unknown",
            },
            disk[0].total(),
            disk[0].used(),
            disk[0].free(),

        ); 
        Self {
            general, 
            timedate,
            network,
            ram,
            disk, 
            summary,
        }
    }
    pub fn write_to_file(self, path: &str) -> Result<(), io::Error> {
        let binding = self.summary;
        let data = binding.as_bytes();
        std::fs::File::create(path)?.write_all(data)?;
        Ok(())
    }

}

// TODO: Create MORE PRETTY print structure

fn main() -> Result<(), io::Error> {
    let sys = Sys::collect();
    let mut file = sys.timedate.uptime_sec().to_string();

    let mut input = String::new();
    println!("Save to file (Y/n) ?");
    std::io::stdin()
        .read_line(&mut input)
        .expect("Err reading to readline"); 
    match input.chars().next() {
        Some('Y' | 'y') => {
            file.push_str(".txt");
            sys.write_to_file(&format!("./{}", file))
        },
        _ => Ok(()),
    }
}
