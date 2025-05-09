use sysinfo::{ System, Users };

#[derive(Debug)]
pub struct Info {
    hostname: String,
    users: Vec<String>,
    os: String,
}

// TODO: Force code to put data of users and os, NOT UNKNOWN
impl Info {
    pub fn new() -> Self {
        let users = Users::new();
        let mut res: Vec<String> = Vec::new();
        for user in &users {
            res.push(String::from(user.name()));
        }
        Info {
            os: match System::os_version() {
                Some(val) => val,
                None => String::from("Unknown"),
            },
            hostname: match System::host_name() {
                Some(val) => val,
                None => String::from("Unknown"),
            },
            users: res,
        }
    }
    pub fn hostname(&self) -> &str {
        &self.hostname
    }
    pub fn users(&self) -> &[String] {
        &self.users
    }
    pub fn os(&self) -> &str {
        &self.os
    }
    
}