import net.rim.blackberry.events.PaymentErrorEvent;
import net.rim.blackberry.events.PaymentSuccessEvent;
import net.rim.blackberry.payment.PaymentSystem;

import qnx.ui.core.ContainerAlign;
import qnx.ui.core.ContainerFlow;
import qnx.ui.core.SizeUnit;
import qnx.ui.data.DataProvider;

private var paymentService:PaymentSystem;

private var goods:Array = [{sku:"1001", name: "Blue Arrowhead", meta: "saleprice", app: "Arrow R US", icon: "/com/renaun/embed/blue_arrowhead_small.png"},
	{sku:"1002", name: "Green Arrowhead", meta: "saleprice", app: "Arrow R US", icon: "/com/renaun/embed/green_arrowhead_small.png"},
	{sku:"1003", name: "Red Arrowhead", meta: "saleprice", app: "Arrow R US", icon: "/com/renaun/embed/red_arrowhead_small.png"}]

protected function purchaseObject(event:MouseEvent):void
{
	if (!paymentService)
	{
		paymentService = new PaymentSystem();
		paymentService.addEventListener(PaymentErrorEvent.PAYMENT_SERVER_ERROR, paymentErrorHandler);
		paymentService.addEventListener(PaymentErrorEvent.USER_CANCELLED, paymentErrorHandler);
		paymentService.addEventListener(PaymentErrorEvent.PAYMENT_ERROR, paymentErrorHandler);
		paymentService.addEventListener(PaymentErrorEvent.DIGITAL_GOOD_NOT_FOUND, paymentErrorHandler);
		paymentService.addEventListener(PaymentSuccessEvent.PAYMENT_SUCCESS, paymentSuccessHandler);
		// Set to local mode to test each event/state
		paymentService.setConnectionMode(PaymentSystem.CONNECTION_MODE_LOCAL);
	}
	// Very brittle way to look up the object i know.
	var obj:Object = goods[getChildIndex(event.target as DisplayObject)-1];
	paymentService.purchase(obj.sku, null, obj.name, obj.meta, obj.app, "file://" + File.applicationDirectory.nativePath + obj.icon);
}
private function paymentSuccessHandler(event:PaymentSuccessEvent):void
{
	
	lblOutput.text = "Success: " + event.purchase.date + " - " + event.purchase.licenseKey;
}
private function paymentErrorHandler(event:PaymentErrorEvent):void
{
	
	lblOutput.text = "Error[" + event.type + "]: " + event.message;
}