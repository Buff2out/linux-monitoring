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
            general: general::Info::get(), 
            timedate: timedate::Info::get(),
            network: network::Info::get(),
            ram: memory::Info::get(),
            disk: disk::Info::get(), 
        }
    }

}

// TODO: Create MORE PRETTY print structure

fn main() {
    let sys = Sys::collect();
    println!("{:?}", &sys);
}
