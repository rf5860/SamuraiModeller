String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
}
String.prototype.ltrim = function() {
	return this.replace(/^\s+/,"");
}
String.prototype.rtrim = function() {
	return this.replace(/\s+$/,"");
}

function validate_required(field, msg)
{
	with (field) {
		if ( (value == null) || (value.trim() == "") ) {
			alert(msg);
			return false;
		} else {
			return true;
		}
	}
}

function validateRegisterForm()
{
	with (document.forms["registerUser"]) {
		if ( validate_required(userId, "Login ID must be supplied.") == false ) {
			userId.focus();
			return false;
		} else if ( validate_required(userName, "Display Name must be supplied.") == false ) {
			userName.focus();
			return false;
		} else if ( validate_required(email, "E-mail must be supplied.") == false ) {
			email.focus();
			return false;
		} else if ( validate_required(password, "Password must be supplied.") == false ) {
			password.focus();
			return false;
		} else if ( validate_required(cpassword, "Confirmation Password must be supplied.") == false ) {
			cpassword.focus();
			return false;
		} else if (password.value != cpassword.value) { 
			alert("Your password and confirmation password do not match.");
			cpassword.focus();
			return false; 
		}
	}
}

function validateFragmentForm()
{
	with (document.forms["createFragment"]) {
		if ( validate_required(newFragment, "Fragment name must be supplied") == false ) {
			newFragment.focus();
			return false;
		}
	}
}