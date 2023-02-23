package org.rustylibs.calculator

import kotlin.test.Test
import kotlin.test.assertEquals

class CalculatorTest {
    @Test
    fun testAdd() {
        val size = CalculatorSize.BIG
        val calculatorData = CalculatorData("ti-80", size)
        val calculator = Calculator(calculatorData)
        assertEquals(4, calculator.add(2, 2))
    }
}
