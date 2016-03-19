# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Backticked for straight JS
`	
$(document).ready(function(){
	var $form = $("#add-cc-form");

	$form.submit(function(event){ 
		var $form = $(this);
		
		if($form.find("#stripe_token").val() === ""){ // not yet obtained stripe token
			initiateStripeRequest($form);
			// prevent form submit
			event.preventDefault();
			return false; 
		}else{ // stripe token obtained
			// allow form submit
			return true;
		}
	});

	$("#cc-number").payment('formatCardNumber');
	$("#cc-cvc").payment('formatCardCVC');
	$("#cc-expiry").payment('formatCardExpiry');

	$form.on("ajax:success", function(event, data, status, xhr){
		console.log(data);
	}).on("ajax:error", function (event, xhr, status, error) {
		console.log(error);
	})
})

function initiateStripeRequest($form){
	var expiry = $("#cc-expiry").payment('cardExpiryVal');
	$form.find('button').prop('disabled', true);

	Stripe.card.createToken({
		number: $("#cc-number").val(),
		cvc: $("#cc-cvc").val(),
		exp_month: expiry.month,
		exp_year: expiry.year
	}, stripeResponseHandler);
	
	expiry = null;
}

function stripeResponseHandler(status, response){
	console.log(response);

	var $form = $("#add-cc-form");

	if(response.error){
		$("add-payment-method-errors").text(response.error.message);
		$form.find('button').prop('disabled', false);
	}else{
		var token = response.id
		$form.find("#stripe_token").val(token);
		token = null; //force clear token
		$form.submit();
	}
}
`