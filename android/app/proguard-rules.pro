# Keep SmartAuth & Credentials API classes
-keep class com.google.android.gms.auth.api.credentials.** { *; }
-dontwarn com.google.android.gms.auth.api.credentials.**

# Keep Proguard annotations
-keep @interface proguard.annotation.Keep
-keep @interface proguard.annotation.KeepClassMembers
# Ignore missing proguard.annotation classes from Razorpay
-dontwarn proguard.annotation.Keep
-dontwarn proguard.annotation.KeepClassMembers
# Keep Razorpay classes to prevent runtime crashes
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**
-keep class com.google.android.gms.location.** { *; }
-dontwarn com.google.android.gms.location.**
-keep class com.google.android.gms.common.internal.** { *; }
-dontwarn com.google.android.gms.common.internal.**

