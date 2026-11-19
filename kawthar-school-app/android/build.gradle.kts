allprojects {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
rootProject.buildDir = layout.buildDirectory.dir("build").get()
subprojects {
    project.buildDir = layout.buildDirectory.dir("${rootProject.buildDir}/${project.name}").get()
}
subprojects { project.evaluationDependsOn(":app") }
tasks.register<Delete>("clean") { delete(rootProject.layout.buildDirectory) }
