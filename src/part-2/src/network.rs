use sysinfo::Networks;
use std::net::IpAddr;

#[derive(Debug)]
pub struct Info {
    name: String,
    ip: Vec<Ip>,
}

#[derive(Debug)]
pub struct Ip {
    ip: IpAddr,
    mask: u8,
}


impl Info {
    pub fn get() -> Vec<Self> {
        let mut res: Vec<Info> = Vec::new();
        let networks = Networks::new_with_refreshed_list();
        for (interface_name, network) in &networks {
            let info_unwrapped = network.ip_networks();
            
            let mut ips: Vec<Ip> = Vec::new();
            
            for el in info_unwrapped {
                let ip = el.addr.clone();
                let mask = el.prefix;
                ips.push(Ip {
                    ip, mask
                });
            }
            let info = Info {
                name: interface_name.clone(),
                ip: ips,
            };
            res.push(info);
        }
        res
    }
}