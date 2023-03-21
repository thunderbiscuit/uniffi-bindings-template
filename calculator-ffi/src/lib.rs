uniffi::include_scaffolding!("calculator");

pub fn welcome(name: String) -> String {
    format!("Welcome {name}, your calculator is ready")
}

struct Calculator {
    info: CalculatorData
}

impl Calculator {
    fn new(info: CalculatorData) -> Self {
        Calculator { info }
    }

    fn get_info(&self) -> String {
        format!("Your calculator is a {} and its size is {:?}", self.info.model, self.info.size)
    }

    fn add(&self, a: i32, b: i32) -> i32 {
        a + b
    }

    fn divide(&self, a: i32, b: i32) -> Result<i32, CalculatorError> {
        if b == 0 {
            Err(CalculatorError::DivisionBy0)
        } else {
            let answer: i32 = a / b;
            Ok(answer)
        }
    }
}

pub struct CalculatorData {
    model: String,
    size: CalculatorSize
}

#[derive(Debug)]
pub enum CalculatorSize {
    Big,
    Small,
}

#[derive(Debug)]
pub enum CalculatorError {
    DivisionBy0
}

impl std::fmt::Display for CalculatorError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{:?}", self)
    }
}

impl std::error::Error for CalculatorError {}
