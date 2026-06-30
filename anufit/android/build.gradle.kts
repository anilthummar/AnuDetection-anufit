allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// AGP 8+ requires namespace in library modules; older plugins (e.g. isar_flutter_libs) omit it.
subprojects {
    afterEvaluate {
        extensions.findByType<com.android.build.gradle.LibraryExtension>()?.apply {
            if (namespace.isNullOrEmpty()) {
                namespace = project.group.toString()
            }
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
