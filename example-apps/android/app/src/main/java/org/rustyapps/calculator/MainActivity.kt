package org.rustyapps.calculator

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import org.rustyapps.calculator.ui.theme.AndroidExampleTheme
import org.rustylibs.calculator.Calculator
import org.rustylibs.calculator.CalculatorData
import org.rustylibs.calculator.CalculatorSize

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            AndroidExampleTheme {
                Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
                    Column {
                        Greeting(
                            name = "Android",
                            modifier = Modifier
                                .padding(innerPadding)
                                .fillMaxWidth()
                                .padding(vertical = 16.dp)
                        )

                        Calculator(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(vertical = 16.dp)
                        )
                    }
                }
            }
        }
    }
}

@Composable
fun Greeting(name: String, modifier: Modifier = Modifier) {
    Box(
        contentAlignment = Alignment.Center,
        modifier = modifier,
    ) {
        Text(
            text = "Hello $name!",
        )
    }
}

@Composable
fun Calculator(modifier: Modifier = Modifier) {
    val welcomeMessage = org.rustylibs.calculator.welcome("Android")
    val calculatorData: CalculatorData = CalculatorData(model = "ti-86", size = CalculatorSize.BIG)
    val uniffiCalculator: Calculator = Calculator(calculatorData)
    val addition: Int = uniffiCalculator.add(21, 21)

    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        modifier = modifier,
    ) {
        Text(
            text = welcomeMessage,
        )
        Text(
            text = uniffiCalculator.getInfo(),
        )
        Text(
            text = "21 + 21 = $addition",
        )
    }
}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    AndroidExampleTheme {
        Greeting("Android")
    }
}
