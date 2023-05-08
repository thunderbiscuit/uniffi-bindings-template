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

    @Test
    fun testReminder() {
        class DailyReminder: Reminder {
            override fun remindMe(): String {
                return "Don't forget to buy milk"
            }
            override fun pingMe(event: Event): Unit {

            }
        }

        val reminder = DailyReminder()
        val calendar = Calendar(reminder = reminder)
        println(calendar.today())
        println(calendar.myEvents())
        assertEquals<String>("Don't forget to buy milk", calendar.myEvents())
    }

    @Test
    fun testPingMe() {
        class DailyReminder2: Reminder {
            override fun remindMe(): String {
                return "Don't forget to buy milk"
            }

            override fun pingMe(event: Event) {
                println("You should attend: $event")
            }
        }

        val reminder = DailyReminder2()
        val calendar = Calendar(reminder = reminder)
        calendar.start()
    }

    @Test
    fun testError() {
        class DailyReminder3 : Reminder {
            override fun remindMe(): String {
                return "Don't forget to buy milk"
            }

            override fun pingMe(event: Event) {
                throw Exception("Totally erroring out: $event")
            }
        }

        val reminder = DailyReminder3()
        val calendar = Calendar(reminder = reminder)
        calendar.start()
    }
}
