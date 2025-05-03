// use std::alloc::System;
use sysinfo::System;

struct SystemInfo;

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
