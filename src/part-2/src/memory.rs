use sysinfo::System;

#[derive(Debug)]
pub struct Info {
    total: u64,
    used: u64,
    free: u64,
}

impl Info {
    pub fn get() -> Info {
        let mut sys = System::new_all();

        sys.refresh_all();
        Info {
            total: sys.total_memory(),
            used: sys.available_memory(),
            free: sys.free_memory(),
        }
    }
}

