plugins {
    id("java-gradle-plugin")
    `kotlin-dsl`
}

gradlePlugin {
    plugins {
        create("uniFfiAndroidBindings") {
            id = "org.fedimint.plugins.generate-android-bindings"
            implementationClass = "org.fedimint.plugins.UniFfiAndroidPlugin"
        }
    }
}
