use std::thread;
use rand::Rng;

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

pub struct Calendar {
    reminder: Box<dyn Reminder>
}

impl Calendar {
    pub fn new(reminder: Box<dyn Reminder>) -> Self {
        Self { reminder }
    }

    pub fn today(&self) -> String {
        "Today is a good day".to_string()
    }

    pub fn my_events(&self) -> String {
        self.reminder.remind_me().unwrap()
    }

    pub fn start(&self) -> () {
        for _ in 0..10 {
            thread::sleep(std::time::Duration::from_secs(4));
            let mut rng = rand::thread_rng();
            let number = rng.gen_range(0..3);
            let event = match number {
                0 => Event::Party,
                1 => Event::Birthday,
                2 => Event::Meeting,
                _ => Event::Party,
            };
            match self.reminder.ping_me(event) {
                Ok(_) => (),
                Err(e) => println!("Error: {:?}", e),
            }
        }
    }
}

pub trait Reminder: Send + Sync + std::fmt::Debug {
    fn remind_me(&self) -> Result<String, CalculatorError>;

    fn ping_me(&self, event: Event) -> Result<(), CalculatorError>;
}

pub enum Event {
    Party,
    Birthday,
    Meeting,
}

#[derive(Debug)]
pub enum CalculatorError {
    DivisionBy0,
    OtherError,
}

impl std::fmt::Display for CalculatorError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{:?}", self)
    }
}

impl std::error::Error for CalculatorError {}

// Need to implement this From<> impl in order to handle unexpected callback errors.  See the
// Callback Interfaces section of the handbook for more info.
impl From<uniffi::UnexpectedUniFFICallbackError> for CalculatorError {
    fn from(_: uniffi::UnexpectedUniFFICallbackError) -> Self {
        Self::OtherError
    }
}
