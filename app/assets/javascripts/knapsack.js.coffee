jQuery ->

  $(document.documentElement).on "click", "#adic", ->
    $('#ktable tbody>tr:eq(-2)').clone(true).insertAfter '#ktable tbody>tr:eq(-2)'

  $(document.documentElement).on "click", "#rm", ->
    if $('#ktable tr').length > 4
      $('#ktable tbody>tr:eq(-2)').remove()

  calculate = () ->
    weights = []
    values  = []
    count   = 0
    $("#ktable tr td input").each ->
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


  $(document.documentElement).on "click", "#calc", ->
    calculate()
