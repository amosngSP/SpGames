$('#editModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget); // Button that triggered the modal
  var game_id = button.data('gameid'); // Extract info from data-* attributes
  var game_title = button.data('gametitle');
  var company = button.data('company');
  var release_date = button.data('releasedate');
  var description = button.data('description');
  var price = button.data('price');
  var preowned = button.data('preowned');
  try {
  var genres = button.data('genres').split(" ");
  } catch (err){
	  var genres = button.data('genres');
  }
  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
  var modal = $(this);
  modal.find('.modal-title').text('Editing ' + game_title);
  modal.find('.modal-body input#game-id').val(game_id);
  modal.find('.modal-body input#game-title').val(game_title);
  modal.find('.modal-body input#company').val(company);
  modal.find('.modal-body input#release_date').val(release_date);
  modal.find('.modal-body input#price').val(price);
  modal.find('.modal-body select#preowned').val(preowned);
  modal.find('.modal-body textarea#description').html(description);

	  modal.find('.modal-body select#genres').val(genres);
	  $('select#genres').selectpicker('refresh');

})
$('#deleteModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget); // Button that triggered the modal
  var game_id = button.data('gameid'); // Extract info from data-* attributes
  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
  var modal = $(this);
  modal.find('.modal-body input#game-id').val(game_id);

})

$('#addModal').on('show.bs.modal', function (event) {
  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.

})