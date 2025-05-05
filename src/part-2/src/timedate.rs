use chrono::{Local, DateTime, FixedOffset};
use sysinfo::System;

#[derive(Debug)]
pub struct Info {
    date: String,
    uptime: String,
    uptime_sec: u64,
    timezone: String,
}

impl Info {
    pub fn get() -> Self {
        let now: DateTime<Local> = Local::now();
        
        let date = now.format("%Y-%m-%d %H:%M:%S").to_string();
        
        let timezone = now.offset().local_minus_utc().to_string();
        
        let mut system = System::new_all();

        system.refresh_all();
        let uptime_sec = System::uptime();
        
        let uptime = format!(
            "{} дней {} часов {} минут",
            uptime_sec / 86400,
            (uptime_sec % 86400) / 3600,
            (uptime_sec % 3600) / 60
        );

        Info {
            date,
            uptime,
            uptime_sec,
            timezone: format!("UTC{}", timezone),
        }
    }
}