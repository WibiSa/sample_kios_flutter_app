package com.example.kiosku_app

import android.annotation.SuppressLint
import com.midtrans.sdk.corekit.core.TransactionRequest
import com.midtrans.sdk.corekit.models.BankType
import com.midtrans.sdk.corekit.models.CustomerDetails
import com.midtrans.sdk.corekit.models.ItemDetails
import com.midtrans.sdk.corekit.models.snap.CreditCard
import java.util.*

object DataCustomer {
    private var NAME = "kiosku"
    private var PHONE = "081936722013"
    private var EMAIL = "zinubigbos@gmail.com"

    private fun customerDetails(): CustomerDetails {
        val cd = CustomerDetails()
        cd.firstName = NAME
        cd.phone = PHONE
        cd.email = EMAIL
        return cd
    }

    @SuppressLint("WrongConstant")
    fun transactionRequest(id: String?, price: Int, qty: Int, name: String?): TransactionRequest {
        val request = TransactionRequest(System.currentTimeMillis().toString()+" ", 20000.0)
        request.customerDetails = customerDetails()
        val details = ItemDetails(id, price.toDouble(), qty, name)
        val itemDetails = ArrayList<ItemDetails>()
        itemDetails.add(details)
        request.itemDetails = itemDetails
        val creditCard = CreditCard()
        creditCard.isSaveCard = false
        creditCard.authentication = CreditCard.RBA
        creditCard.bank = BankType.MANDIRI
        request.creditCard = creditCard
        return request
    }
}