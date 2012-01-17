function validate_required(field, msg)
{
	with (field) {
		if ( (value==null) || (value=="") ) {
			alert(msg);
			return false;
		} else {
			return true;
		}
	}
}

function validateForm()
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