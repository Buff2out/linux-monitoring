// use std::alloc::System;

use sysinfo::System;

enum General {
    hostname(String),
    user(String),
    os(String),
}

enum TimeDate {
    date(String),
    uptime(String),
    uptime_sec(u64),
    timezone(String),
}

enum Network {
    ip(String),
    mask(String),
    gateway(String),
}

enum Memory {
    total(f64),
    used(f64),
    free(f64),
}

enum Disk {
    total(f64),
    used(f64),
    free(f64),
}

struct SystemInfo {
    general: General,
    timedate: TimeDate,
    network: Network,
    ram: Memory,
    disk: Disk,

    filesystem: String, // возможность переконвертировать в enum
}


impl SystemInfo {
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
