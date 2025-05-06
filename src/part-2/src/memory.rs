use sysinfo::System;

#[derive(Debug)]
pub struct Info {
    total: u64,
    used: u64,
    free: u64,
}

impl Info {
    pub fn new() -> Self {
        let mut sys = System::new_all();

        sys.refresh_all();
        Info {
            total: sys.total_memory(),
            used: sys.available_memory(),
            free: sys.free_memory(),
        }
    }
    pub fn total(&self) -> u64 {
        self.total
    }
    pub fn used(&self) -> u64 {
        self.used
    }
    pub fn free(&self) -> u64 {
        self.free
    }
}

