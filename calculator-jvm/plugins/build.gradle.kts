plugins {
    id("java-gradle-plugin")
    `kotlin-dsl`
}

gradlePlugin {
    plugins {
        create("uniFfiJvmBindings") {
            id = "org.rustylibs.plugins.generate-jvm-bindings"
            implementationClass = "org.rustylibs.plugins.UniFfiJvmPlugin"
        }
    }
}
