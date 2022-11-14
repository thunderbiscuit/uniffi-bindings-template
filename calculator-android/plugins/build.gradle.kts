plugins {
    id("java-gradle-plugin")
    `kotlin-dsl`
}

gradlePlugin {
    plugins {
        create("uniFfiAndroidBindings") {
            id = "org.rustylibs.plugins.generate-android-bindings"
            implementationClass = "org.rustylibs.plugins.UniFfiAndroidPlugin"
        }
    }
}
