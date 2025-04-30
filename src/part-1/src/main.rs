use std::error::Error;

fn main() -> Result<(), Box<dyn Error>> {
    let args: Vec<String> = std::env::args().collect();
    // Проверка количества аргументов сразу
// Так же можно: 
//      let param = args.get(1).ok_or("Ошибка: требуется 1 параметр")?;
// Но тогда не будет учтено когда введено больше 2 аргументов.
// Поэтому.
    if args.len() != 2 {
        return Err(format!(
            "Ошибка: требуется 1 параметр, получено {}", 
            args.len().saturating_sub(1)
        ).into());
    }
    // Безопасно извлекаем параметр (гарантировано есть)
    let param = &args[1];

    match param.parse::<u32>() {
        Ok(_) => Err("Err: number typed".into()),
        Err(_) => {
            println!("{}", param);
            Ok(())
        }
    }
}
