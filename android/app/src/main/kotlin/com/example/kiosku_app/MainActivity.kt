package com.example.kiosku_app

import android.widget.Toast
import com.midtrans.sdk.corekit.callback.TransactionFinishedCallback
import com.midtrans.sdk.corekit.core.MidtransSDK
import com.midtrans.sdk.corekit.core.PaymentMethod
import com.midtrans.sdk.corekit.core.themes.CustomColorTheme
import com.midtrans.sdk.corekit.models.snap.TransactionResult
import com.midtrans.sdk.uikit.SdkUIFlowBuilder
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.jetbrains.annotations.NotNull

class MainActivity : FlutterActivity(), TransactionFinishedCallback {

    companion object{
        const val CHANNEL = "com.kiosku.kiosku_app.channel"
        const val KEY_NATIVE = "showPaymentMidtrans"
    }

    override fun configureFlutterEngine(@NotNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == KEY_NATIVE) {
                val name = (""+call.argument("name"))
                val price = (""+call.argument("price")).toInt()
                val qty = (""+call.argument("quantity")).toInt()

                //panggil fungsi init midtrans
                initMidtransSdk()

                MidtransSDK.getInstance().transactionRequest = DataCustomer.transactionRequest(
                        "1", price, qty, name
                )

                MidtransSDK.getInstance().startPaymentUiFlow(this, PaymentMethod.GO_PAY)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun initMidtransSdk() {
        SdkUIFlowBuilder.init()
                .setContext(this)
                .setMerchantBaseUrl(BuildConfig.MERCHANT_BASE_URL)
                .setClientKey(BuildConfig.MERCHANT_CLIENT_KEY)
                .setTransactionFinishedCallback(this)
                .enableLog(true)
                .setColorTheme(CustomColorTheme("#87CEFA", "#87CEFA", "#87CEFA"))
                .buildSDK()
    }

    override fun onTransactionFinished(result: TransactionResult) {
        if (result.response != null) {
            when(result.status) {
                TransactionResult.STATUS_SUCCESS -> Toast.makeText(this, "Transaksi Selesai Id: ${result.response.transactionId}", Toast.LENGTH_SHORT).show()
                TransactionResult.STATUS_PENDING-> Toast.makeText(this, "Transaksi Menunggu Id: ${result.response.transactionId}", Toast.LENGTH_SHORT).show()
                TransactionResult.STATUS_FAILED -> Toast.makeText(this, "Transaksi Gagal Id: ${result.response.transactionId}", Toast.LENGTH_SHORT).show()
            }
            result.response.validationMessages
        } else if (result.isTransactionCanceled){
            Toast.makeText(this, "Transaction Canceled", Toast.LENGTH_SHORT).show()
        } else if (result.status.equals(TransactionResult.STATUS_INVALID, ignoreCase = true)){
            Toast.makeText(this, "Transaction Invalid", Toast.LENGTH_SHORT).show()
        } else{
            Toast.makeText(this, "Transaction Finished with failure", Toast.LENGTH_SHORT).show()
        }
    }
}