jQuery ->

  $("#add").click ->
    $('.table tbody>tr:eq(-2)').clone(true).insertAfter '.table tbody>tr:eq(-2)'

  $("#rm").click ->
    if $('.table tr').length > 4
      $('.table tbody>tr:eq(-2)').remove()

  calculate = () ->
    weights = []
    values  = []
    count   = 0
    $(".table tr td input").each ->
      if count%2 == 0
        weights.push $(this).val()
        count++
      else
        values.push $(this).val()
        count++

    capacity = $("#capacity").val()

    if capacity == ""
      alert "Especifique uma capacidade para a mochila."
      throw new Error("error");

    csrf_token = $("meta[name='csrf_token']").attr('content')

    $.ajax
      url: '/calc'
      type: 'get'
      data: {
        authenticity_token: csrf_token
        capacity:           capacity
        weights:            weights
        values:             values
      }
      success: (data, textStatus, jqXHR) ->
        $("#result").html(jqXHR.responseText)
      error: (jqXHR, textStatus, errorThrown) ->
        $("#result").html("Erro !")  


  $("#calc").click ->
    calculate()
