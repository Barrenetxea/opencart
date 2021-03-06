<div class="row-fluid">
  <div class="span12">
    <?php if ($addresses) { ?>
    <p>
      <label class="radio">
        <input type="radio" name="payment_address" value="existing" checked="checked" />
        <?php echo $text_address_existing; ?></label>
    </p>
    <div id="payment-existing">
      <select name="address_id" class="input-xxlarge">
        <?php foreach ($addresses as $address) { ?>
        <?php if ($address['address_id'] == $address_id) { ?>
        <option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
        <?php } ?>
        <?php } ?>
      </select>
    </div>
    <p>
      <label class="radio">
        <input type="radio" name="payment_address" value="new" />
        <?php echo $text_address_new; ?></label>
    </p>
    <?php } ?>
    <div id="payment-new" class="form-horizontal" style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
      <div class="form-group required">
        <label class="col-lg-3 control-label" for="input-payment-firstname"><?php echo $entry_firstname; ?></label>
        <div class="col-lg-9">
          <input type="text" name="firstname" value="" placeholder="<?php echo $entry_firstname; ?>" id="input-payment-firstname" />
        </div>
      </div>
      <div class="form-group required">
        <label class="col-lg-3 control-label" for="input-payment-lastname"><?php echo $entry_lastname; ?></label>
        <div class="col-lg-9">
          <input type="text" name="lastname" value="" placeholder="<?php echo $entry_lastname; ?>" id="input-payment-lastname" />
        </div>
      </div>
      <div class="form-group">
        <label class="col-lg-3 control-label" for="input-payment-company"><?php echo $entry_company; ?></label>
        <div class="col-lg-9">
          <input type="text" name="company" value="" placeholder="<?php echo $entry_company; ?>" id="input-payment-company" />
        </div>
      </div>
      <div class="form-group required">
        <label class="col-lg-3 control-label" for="input-payment-address-1"><?php echo $entry_address_1; ?></label>
        <div class="col-lg-9">
          <input type="text" name="address_1" value="" placeholder="<?php echo $entry_address_1; ?>" />
        </div>
      </div>
      <div class="form-group">
        <label class="col-lg-3 control-label" for="input-payment-address-2"><?php echo $entry_address_2; ?></label>
        <div class="col-lg-9">
          <input type="text" name="address_2" value="" placeholder="<?php echo $entry_address_2; ?>" id="payment-address-2" />
        </div>
      </div>
      <div class="form-group required">
        <label class="col-lg-3 control-label" for="input-payment-city"><?php echo $entry_city; ?></label>
        <div class="col-lg-9">
          <input type="text" name="city" value="" placeholder="<?php echo $entry_city; ?>" id="input-payment-city" />
        </div>
      </div>
      <div class="form-group required">
        <label class="col-lg-3 control-label" for="input-payment-postcode"><?php echo $entry_postcode; ?></label>
        <div class="col-lg-9">
          <input type="text" name="postcode" value="" placeholder="<?php echo $entry_postcode; ?>" id="input-payment-postcode" />
        </div>
      </div>
      <div class="form-group required">
        <label class="col-lg-3 control-label" for="input-payment-country"><?php echo $entry_country; ?></label>
        <div class="col-lg-9">
          <select name="country_id" id="input-payment-country">
            <option value=""><?php echo $text_select; ?></option>
            <?php foreach ($countries as $country) { ?>
            <?php if ($country['country_id'] == $country_id) { ?>
            <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
            <?php } ?>
            <?php } ?>
          </select>
        </div>
      </div>
      <div class="form-group required">
        <label class="col-lg-3 control-label" for="input-payment-zone"><?php echo $entry_zone; ?></label>
        <div class="col-lg-9">
          <select name="zone_id" id="input-payment-zone">
          </select>
        </div>
      </div>
    </div>
    <div class="buttons">
      <div class="pull-right">
        <input type="button" value="<?php echo $button_continue; ?>" id="button-payment-address" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary" />
      </div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('input[name=\'payment_address\']').on('change', function() {
	if (this.value == 'new') {
		$('#payment-existing').hide();
		$('#payment-new').show();
	} else {
		$('#payment-existing').show();
		$('#payment-new').hide();
	}
});
//--></script> 
<script type="text/javascript"><!--
$('#input-payment-country').on('change', function() {
	$.ajax({
		url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#input-payment-country').after(' <i class="icon-spinner icon-spin"></i>');
		},
		complete: function() {
			$('.icon-spinner').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#input-payment-postcode').parent().parent().addClass('required');
			} else {
				$('#input-payment-postcode').parent().parent().removeClass('required');
			}
			
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['zone']) {
				for (i = 0; i < json['zone'].length; i++) {
                    html += '<option value="' + json['zone'][i]['zone_id'] + '"';
                    
                    if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
                        html += ' selected="selected"';
                    }
    
                    html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('#input-payment-zone').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('#input-payment-country').trigger('change');
//--></script>