$('#editModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget); // Button that triggered the modal
  var genre_id = button.data('genreid'); // Extract info from data-* attributes
  var genre_name = button.data('genre_name');

  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
  var modal = $(this);
  modal.find('.modal-title').text('Editing ' + genre_name);
  modal.find('.modal-body input#genre-id').val(game_id);
  modal.find('.modal-body input#game-title').val(game_title);

})
$('#deleteModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget); // Button that triggered the modal
  var game_id = button.data('genreid'); // Extract info from data-* attributes
  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
  var modal = $(this);
  modal.find('.modal-body input#game-id').val(genreid);

})

$('#UNdeleteModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget); // Button that triggered the modal
  var game_id = button.data('genreid'); // Extract info from data-* attributes
  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
  var modal = $(this);
  modal.find('.modal-body input#game-id').val(genreid);

})
