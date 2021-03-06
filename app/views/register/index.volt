
<div class="page-header page-header-reg">
    <h2>Get started for free.</h2>
    <span>Enter your access details below.</span>
</div>

{{ form('register', 'id': 'registerForm') }}

    <fieldset>

        <div class="form-group">
            {{ form.render('name', ['class': 'form-control','maxlength': '51', 'data-rule-required':'true', 'form-control','placeholder': form.getLabel('name')]) }}
            <i class="material-icons">perm_identity</i>
            <div id="fname_error" class="error-block-msg"></div>
        </div>

        

        <div class="form-group">
            {{ form.render('email', ['class': 'form-control','maxlength': '51', 'data-rule-required':'true','data-rule-email':'true','placeholder': form.getLabel('email')]) }}
            <i class="material-icons">mail_outline</i>
        </div>

		         
        <div class="form-group">
            {{ form.render('password', ['class': 'form-control','maxlength': '51','id': 'register-password', 'data-rule-required':'true','placeholder': form.getLabel('password')]) }}
             <i class="material-icons">lock</i>
        </div>

        <div class="form-group">
            {{ form.render('repeatPassword', ['class': 'form-control','maxlength': '51', 'data-rule-required':'true','data-rule-equalTo':'#register-password','placeholder': form.getLabel('repeatPassword')]) }}
             <i class="material-icons">lock</i>
        </div>

        <div class="form-group">
            <label class="container-check">
            <input type="checkbox" id="register_terms" name="register_terms" data-rule-required="true">
            <span class="checkmark"></span>
            <a href="#!" class="ficha-color">I agree to FICHA’s <span>Terms of Service, Cookie Usage</span> and <span>Privacy Policy.</span></a>
            </label>
        </div>

        <div class="form-actions text-right form-action-wrapper">
            <!-- {{ submit_button('Create Account', 'class': 'btn ficha-btn', 'onclick': 'return SignUp.validate();') }} -->
            <button type="submit" class="btn ficha-btn" name="signupbutton"><?=$t->_('SIGN UP');?><i class="material-icons">arrow_forward</i></button>
            <!-- <p class="help-block">By signing up, you accept terms of use and privacy policy.</p> -->
        </div>

    </fieldset>
</form>
