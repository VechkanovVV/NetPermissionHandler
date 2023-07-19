package dev.fluttercommunity.connectivity;

import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;
import android.net.ConnectivityManager;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

import android.app.Activity;
import android.content.DialogInterface;
import android.app.AlertDialog;



public class ConnectivityPlugin implements FlutterPlugin {
  private static final String CAMERA_PERMISSION = Manifest.permission.CAMERA;
  private static final int CAMERA_PERMISSION_REQUEST_CODE = 123; // Any unique value

  private MethodChannel methodChannel;
  private EventChannel eventChannel;
  private ConnectivityBroadcastReceiver receiver;
  private Context applicationContext;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    setupChannels(binding.getBinaryMessenger(), binding.getApplicationContext());
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    teardownChannels();
  }

  private void setupChannels(BinaryMessenger messenger, Context context) {
    applicationContext = context;
    methodChannel = new MethodChannel(messenger, "dev.fluttercommunity.plus/connectivity");
    eventChannel = new EventChannel(messenger, "dev.fluttercommunity.plus/connectivity_status");
    ConnectivityManager connectivityManager =
            (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);

    Connectivity connectivity = new Connectivity(connectivityManager);

    ConnectivityMethodChannelHandler methodChannelHandler =
            new ConnectivityMethodChannelHandler(connectivity);
    receiver = new ConnectivityBroadcastReceiver(context, connectivity);

    methodChannel.setMethodCallHandler(methodChannelHandler);
    eventChannel.setStreamHandler(receiver);
  }

  private void teardownChannels() {
    methodChannel.setMethodCallHandler(null);
    eventChannel.setStreamHandler(null);
    receiver.onCancel(null);
    methodChannel = null;
    eventChannel = null;
    receiver = null;
  }

  public void requestCameraPermission(Activity activity) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
      if (ActivityCompat.shouldShowRequestPermissionRationale(activity, CAMERA_PERMISSION)) {
        // Show an explanation to the user, then request permission
        // You can show a dialog explaining why you need the camera permission.
        // For example, you can use an AlertDialog to explain the purpose of camera access:
        new AlertDialog.Builder(activity)
                .setTitle("Camera Permission Needed")
                .setMessage("This app needs the camera permission to take photos.")
                .setPositiveButton("OK", new DialogInterface.OnClickListener() {
                  @Override
                  public void onClick(DialogInterface dialog, int which) {
                    // Request the permission after the user acknowledges the explanation
                    ActivityCompat.requestPermissions(activity,
                            new String[]{CAMERA_PERMISSION},
                            CAMERA_PERMISSION_REQUEST_CODE);
                  }
                })
                .show();
      } else {
        // No explanation needed; request the permission
        ActivityCompat.requestPermissions(activity,
                new String[]{CAMERA_PERMISSION},
                CAMERA_PERMISSION_REQUEST_CODE);
      }
    }
  }


  public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
    if (requestCode == CAMERA_PERMISSION_REQUEST_CODE) {
      // Check the result of the camera permission request
      boolean cameraPermissionGranted = grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED;
      if (cameraPermissionGranted) {
        // Camera permission granted
        // You can send back a result to Flutter if necessary
        // For example, you can use: result.success(true);
      } else {
        // User denied the camera permission or the permission has not been granted yet
        // You can send back a result to Flutter if necessary
        // For example, you can use: result.success(false);
      }
    }
  }


  public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
    switch (call.method) {
      case "requestCameraPermission":
        // Get the activity from the Flutter method call
        Activity activity = (Activity) applicationContext;

        if (activity != null) {
          requestCameraPermission(activity);
        } else {
          // You may need to handle the situation when activity is null
          // For example, you can use: result.error("ACTIVITY_NULL", "Activity is null", null);
        }
        result.success(null); // Sending a successful result back to Flutter
        break;
      // Other cases for handling other methods if necessary
      default:
        result.notImplemented();
        break;
    }
  }

}
