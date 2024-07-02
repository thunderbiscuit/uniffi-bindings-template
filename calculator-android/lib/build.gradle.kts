plugins {
    id("com.android.library")
    id("org.jetbrains.kotlin.android") version "1.9.20"
    id("org.gradle.maven-publish")
    id("org.gradle.signing")
}

repositories {
    mavenCentral()
    google()
}

android {
    namespace = "org.rustylibs"
    compileSdk = 34

    defaultConfig {
        minSdk = 24
        targetSdk = 34
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        consumerProguardFiles("consumer-rules.pro")
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            proguardFiles(file("proguard-android-optimize.txt"), file("proguard-rules.pro"))
        }
    }

    publishing {
        singleVariant("release") {
            withSourcesJar()
            withJavadocJar()
        }
    }
}

dependencies {
    implementation("net.java.dev.jna:jna:5.14.0@aar")
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7")
    implementation("androidx.appcompat:appcompat:1.4.0")
    implementation("androidx.core:core-ktx:1.7.0")
    api("org.slf4j:slf4j-api:1.7.30")

    androidTestImplementation("com.github.tony19:logback-android:2.0.0")
    androidTestImplementation("androidx.test.ext:junit:1.1.3")
    androidTestImplementation("androidx.test.espresso:espresso-core:3.4.0")
    androidTestImplementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.4.1")
}

afterEvaluate {
    publishing {
        publications {
            create<MavenPublication>("maven") {
                groupId = "org.rustylibs"
                artifactId = "calculator-android"
                version = "0.1.0"

                from(components["release"])
                pom {
                    name.set("calculator-android")
                    description.set("Calculator Kotlin language bindings.")
                    url.set("https://rustylibs.org")
                    licenses {
                        license {
                            name.set("APACHE 2.0")
                            url.set("")
                        }
                    }
                    // developers {
                    //     developer {
                    //         id.set("")
                    //         name.set("")
                    //         email.set("")
                    //     }
                    // }
                    // scm {
                    //     connection.set("")
                    //     developerConnection.set("")
                    //     url.set("")
                    // }
                }
            }
        }
    }
}

// signing {
//     val signingKeyId: String? by project
//     val signingKey: String? by project
//     val signingPassword: String? by project
//     useInMemoryPgpKeys(signingKeyId, signingKey, signingPassword)
//     sign(publishing.publications)
// }
