/*  
Mostly use this as lib.rs
https://docs.rs/sysinfo/latest/sysinfo/
*/
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
    disk: Vec<disk::Info>,
}


impl Sys {
    fn hostname() {
        let hostname = match System::host_name() {
            Some(hn) => hn,
            None => String::from("Not found")
        };
        println!("Hostname: {}", hostname);
    }
    pub fn collect() {
        let sys = (
            disk::Info::get(), 
            general::Info::get(), 
            memory::Info::get(),
            network::Info::get(),
        );
        println!("{:?}", &sys);
    }

}

// TODO: Create MORE PRETTY print structure

fn main() {
    println!("linux-monitoring-2");
    Sys::hostname();
    Sys::collect();
}
