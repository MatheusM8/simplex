# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

  $("#add").click ->
    $("#restrictions").append("<div class='form-horizontal'>
        <div class='form-group'>
          <div class='col-sm-10'>
            <input type='text' class='form-control' name='restricao' placeholder='Restrição'>
          </div>
          <div class='col-sm-2'>
            <button type='button' id='remove' class='btn btn-block btn-danger'>-</button>
          </div>
        </div>
     </div>")

  $(document).on "click", "#remove", ->
    $(this).closest(".form-horizontal").remove()

  calculate = (type) ->
    restrictions = []   
    $("#restrictions input").each ->
      restrictions.push $(this).val()

    expression = $("#expression").val()

    csrf_token = $("meta[name='csrf_token']").attr('content')

    $.ajax
      url: '/' + type
      type: 'get'
      data: {
        authenticity_token: csrf_token
        expression:         expression
        restrictions:       restrictions
      }
      success: (data, textStatus, jqXHR) ->
        $("#result").html(jqXHR.responseText)
      error: (jqXHR, textStatus, errorThrown) ->
        $("#result").html("Erro ! Expressão ou restrições com valores errados.")  


  $("#max").click ->
    calculate("max")

  $("#min").click ->
    calculate("min")
