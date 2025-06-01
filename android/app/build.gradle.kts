plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.tugaslayoubank"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973" // NDK version sudah benar

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
        // Tambahkan baris ini untuk mengaktifkan desugaring
        isCoreLibraryDesugaringEnabled = true // <--- PASTIKAN BARIS INI ADA
    }

    kotlinOptions {
        jvmTarget = "1.8" // Pastikan ini juga 1.8
    }

    defaultConfig {
        applicationId = "com.example.tugaslayoubank"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

// Pastikan blok dependencies ini ada dan terletak di LUAR blok 'android'
dependencies {
    // Dependensi desugaring sudah benar
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}