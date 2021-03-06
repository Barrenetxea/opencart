<?php if ($error_warning) { ?>
<div class="alert alert-danger"><i class="icon-exclamation-sign"></i> <?php echo $error_warning; ?>
  <button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<?php } ?>
<?php if ($success) { ?>
<div class="alert alert-success"><i class="icon-ok-sign"></i> <?php echo $success; ?>
  <button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<?php } ?>
<table class="table table-striped table-bordered table-hover">
  <thead>
    <tr>
      <td class="text-left"><?php echo $column_date_added; ?></td>
      <td class="text-left"><?php echo $column_description; ?></td>
      <td class="text-right"><?php echo $column_amount; ?></td>
    </tr>
  </thead>
  <tbody>
    <?php if ($transactions) { ?>
    <?php foreach ($transactions as $transaction) { ?>
    <tr>
      <td class="text-left"><?php echo $transaction['date_added']; ?></td>
      <td class="text-left"><?php echo $transaction['description']; ?></td>
      <td class="text-right"><?php echo $transaction['amount']; ?></td>
    </tr>
    <?php } ?>
    <tr>
      <td>&nbsp;</td>
      <td class="text-right"><b><?php echo $text_balance; ?></b></td>
      <td class="text-right"><?php echo $balance; ?></td>
    </tr>
    <?php } else { ?>
    <tr>
      <td class="text-center" colspan="3"><?php echo $text_no_results; ?></td>
    </tr>
    <?php } ?>
  </tbody>
</table>
<div class="row-fluid">
  <div class="span6"><?php echo $pagination; ?></div>
  <div class="span6">
    <div class="results"><?php echo $results; ?></div>
  </div>
</div>
