/*  
Mostly use this as lib.rs
https://docs.rs/sysinfo/latest/sysinfo/
*/
mod general;
mod timedate;
mod network;
mod memory;
mod disk;

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
    // pub fn to_str(&self) -> &str {
    //     let res = format!(
    //         "HOSTNAME = {}\n\
    //         TIMEZONE = {}\n\
    //         USER = {:?}\n\
    //         OS = {}\n\
    //         DATE = {}\n\
    //         UPTIME = {}\n\
    //         UPTIME_SEC = {}\n\
    //         IP = {:?}\n\
    //         MASK = {}\n\
    //         GATEWAY = {}\n\
    //         RAM_TOTAL = {} GB\n\
    //         RAM_USED = {} GB\n\
    //         RAM_FREE = {} GB\n\
    //         SPACE_ROOT = {} MB\n\
    //         SPACE_ROOT_USED = {} MB\n\
    //         SPACE_ROOT_FREE = {} MB",
    //     self.general.hostname(),
    //     self.timedate.timezone(),
    //     self.general.users(),
    //     self.general.os(),
    //     self.timedate.date(),
    //     self.timedate.uptime(),
    //     self.timedate.uptime_sec(),
    //     self.network
    // );
    //     "fdsf"
    // }

}

// TODO: Create MORE PRETTY print structure

fn main() {
    let sys = Sys::collect();
    println!("{:?}", &sys);
}
