// use std::alloc::System;

mod general;
mod timedate;
mod network;
mod memory;
mod disk;

use sysinfo::System;

struct Sys {
    general: general::Info,
    timedate: timedate::Info,
    network: network::Info,
    ram: memory::Info,
    disk: disk::Info,
}


impl Sys {
    fn hostname() {
        let hostname = match System::host_name() {
            Some(hn) => hn,
            None => String::from("Not found")
        };
        println!("Hostname: {}", hostname);
    }

}

fn main() {
    println!("linux-monitoring-2");
    SystemInfo::hostname();
}
