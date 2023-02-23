import org.gradle.api.tasks.testing.logging.TestExceptionFormat.*
import org.gradle.api.tasks.testing.logging.TestLogEvent.*
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    id("org.jetbrains.kotlin.jvm") version "1.6.10"
    id("java-library")
    id("maven-publish")
    id("signing")

    // Custom plugin to generate the native libs and bindings file
    id("org.rustylibs.plugins.generate-jvm-bindings")
}

repositories {
    mavenCentral()
}

java {
    sourceCompatibility = JavaVersion.VERSION_1_8
    targetCompatibility = JavaVersion.VERSION_1_8
    withSourcesJar()
    withJavadocJar()
}

tasks.withType<Test> {
    useJUnitPlatform()

    testLogging {
        events(PASSED, SKIPPED, FAILED, STANDARD_OUT, STANDARD_ERROR)
        exceptionFormat = FULL
        showExceptions = true
        showCauses = true
        showStackTraces = true
    }
}

dependencies {
    implementation(platform("org.jetbrains.kotlin:kotlin-bom"))
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7")
    implementation("net.java.dev.jna:jna:5.8.0")
    api("org.slf4j:slf4j-api:1.7.30")
    testImplementation("junit:junit:4.13.2")
    testRuntimeOnly("org.junit.vintage:junit-vintage-engine:5.8.2")
    testImplementation("ch.qos.logback:logback-classic:1.2.3")
    testImplementation("ch.qos.logback:logback-core:1.2.3")

    // Use the Kotlin test library
    testImplementation(kotlin("test"))
}

afterEvaluate {
    publishing {
        publications {
            create<MavenPublication>("maven") {
                groupId = "org.rustylibs"
                artifactId = "calculator-jvm"
                version = "0.1.0"

                from(components["java"])
                pom {
                    name.set("calculator-android")
                    description.set("Calculator Kotlin language bindings for the JVM.")
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
