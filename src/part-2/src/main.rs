// use std::alloc::System;
use sysinfo::System;

struct SystemInfo;

impl SystemInfo {
    fn hostname() {
        println!("Hostname: {:?}", System::host_name())
    }
}

fn main() {
    println!("linux-monitoring-2");
    SystemInfo::hostname();
}
