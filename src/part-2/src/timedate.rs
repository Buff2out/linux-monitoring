use chrono::{Local, DateTime};
use sysinfo::System;

#[derive(Debug)]
pub struct Info {
    date: String,
    uptime: String,
    uptime_sec: u64,
    timezone: String,
}

impl Info {
    pub fn new() -> Self {
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
    
    pub fn date(&self) -> &str {
        &self.date
    }
    
    pub fn uptime(&self) -> &str {
        &self.uptime
    }
    
    pub fn uptime_sec(&self) -> u64 {
        self.uptime_sec
    }
    
    pub fn timezone(&self) -> &str {
        &self.timezone
    }
}