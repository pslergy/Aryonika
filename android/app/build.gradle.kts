import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// Загружаем настройки ключа
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties") // Ищет в папке android/
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
} else {
    // ВЫВОДИМ ОШИБКУ В КОНСОЛЬ, ЕСЛИ ФАЙЛ НЕ НАЙДЕН
    println("⚠️ WARNING: key.properties not found in ${rootProject.rootDir}. Release build will fail!")
}

android {
    namespace = "com.psylergy.lovequest" // ПРОВЕРЬТЕ ЭТО ИМЯ!
    compileSdk = 36

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    defaultConfig {
        applicationId = "com.psylergy.lovequest" // ПРОВЕРЬТЕ ЭТО ИМЯ!
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    signingConfigs {
        create("release") {
            // Теперь мы принудительно берем значения. Если файла нет - упадет с ошибкой.
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = file(keystoreProperties["storeFile"] as String) // Ищет внутри android/app/
            storePassword = keystoreProperties["storePassword"] as String
        }
    }

    buildTypes {
        getByName("release") {
            // ПРИНУДИТЕЛЬНО подписываем
            signingConfig = signingConfigs.getByName("release")

            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")

            // Отключаем Lint, чтобы не было ошибки блокировки файла
            lint {
                checkReleaseBuilds = false
                abortOnError = false
            }
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}