package com.spring.bocompay.service.trade;

import com.bocom.bocompay.BocomClient;
import com.spring.bocompay.domain.trade.TradeConfirmResponseMessage;
import com.spring.bocompay.service.BaseService;
import org.springframework.stereotype.Service;

/**
 * @description: TODO
 * @author: Katherine
 * @create: 2018/4/26 16:05
 */
@Service
public class TradeConfirmResponseMessageService extends BaseService {

    public TradeConfirmResponseMessage fillTradeConfirm(BocomClient client) {
        TradeConfirmResponseMessage tradeConfirm = new TradeConfirmResponseMessage();
        tradeConfirm.setTranRspCode(client.getData("TranRspCode"));
        tradeConfirm.setTranStt(client.getData("TranStt"));
        tradeConfirm.setMerOrderNo(client.getData("MerOrderNo"));
        tradeConfirm.setConfirmOrder(client.getData("ConfirmOrder"));
        tradeConfirm.setConfirmAmt(client.getData("ConfirmAmt"));
        tradeConfirm.setConfirmCry(client.getData("ConfirmCry"));
        tradeConfirm.setMerTranSerialNo(client.getData("MerTranSerialNo"));

        return tradeConfirm;
    }
}
