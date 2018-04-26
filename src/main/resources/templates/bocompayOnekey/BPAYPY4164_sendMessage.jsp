<%@ page import="com.bocom.bocompay.BocomClient" %>
<%@ page import="java.io.File" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>一键支付签约(BPAYPY4164)</title>
</head>

<body bgcolor="#FFFFFF" text="#000000" onload=" javascript: form1.submit() ">
<%

    String MerCertID = request.getParameter("MerCertID").trim();
    String webDeployPath = application.getRealPath("/");
    if (!File.separator.equals(webDeployPath.substring(webDeployPath.length() - 1))) {
        webDeployPath = webDeployPath + File.separatorChar;
    }
    String xmlConfigPath = webDeployPath + "bocommjava/ini/BocompayMerchant.xml";

    BocomClient client = new BocomClient();

    int ret = client.initialize(xmlConfigPath); //
    if (ret != 0) {                                                                 //
        out.print("初始化失败,错误信息：" + client.getLastErr());
        return;
    }
    String TranCode;
    String MerPtcId;
    String TranDate;
    String TranTime;

    TranCode = request.getParameter("TranCode");
    MerPtcId = request.getParameter("MerPtcId");
    TranDate = request.getParameter("TranDate");
    TranTime = request.getParameter("TranTime");

    client.setHead("TranCode", TranCode);
    client.setHead("MerPtcId", MerPtcId);
    client.setHead("TranDate", TranDate);
    client.setHead("TranTime", TranTime);

    //设这报文体数据
    client.setData("AgreeNo", request.getParameter("AgreeNo"));
    client.setData("MerAgreeNo", request.getParameter("MerAgreeNo"));
    client.setData("Amount", request.getParameter("Amount"));
    client.setData("ApplyTime", request.getParameter("ApplyTime"));

    String rst = client.execute(MerCertID, TranCode, "ONEKEY");

    System.out.println(rst + "======================");
    if (rst == null) {
        String err = client.getLastErr();
        out.print("交易错误信息：" + err + "<br>");
    } else if ("E".equalsIgnoreCase(client.getHead("RspType"))) {
        out.println("响应类型：" + client.changeNull(client.getHead("RspType")) + "<br>");
        out.println("交易返回码：" + client.changeNull(client.getHead("ss")) + "<br>");
        out.println("交易返回信息：" + client.changeNull(client.getHead("RspMsg")) + "<br>");
        out.println("响应日期：" + client.changeNull(client.getHead("RspDate")) + "<br>");
        out.println("响应时间：" + client.changeNull(client.getHead("RspTime")) + "<br>");
    } else {
        //开始打印
        out.println("响应类型：" + client.changeNull(client.getHead("RspType")) + "<br>");
        out.println("交易返回码：" + client.changeNull(client.getHead("RspCode")) + "<br>");
        out.println("交易返回信息：" + client.changeNull(client.getHead("RspMsg")) + "<br>");
        out.println("响应日期：" + client.changeNull(client.getHead("RspDate")) + "<br>");
        out.println("响应时间：" + client.changeNull(client.getHead("RspTime")) + "<br>");
        out.println("**********一键支付短信发送(BPAYPY4164)开始打印**********" + "<br>");
        out.println("识别码：" + client.changeNull(client.getData("SessionID")) + "<br>");
        out.println("手机号：" + client.changeNull(client.getData("Mobile")) + "<br>");
        out.println("**********一键支付短信发送(BPAYPY4164)结束打印**********" + "<br>");
        //结束打印
        out.println("succeed!");
    }
%>
<p>
    <a href="onekeyIndex.htm">返回一键支付首页</a>
</p>
</body>
</html>
