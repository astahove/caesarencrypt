/**
 * Created by caer on 14.02.2016.
 */
    function checkText(text)
    {

        if(/[а-яА-Я]/.test(text))
        {
            return true;
        }else return false;
    }
function writechart(rate,alphabet) {
    var chart = new CanvasJS.Chart("chartContainer", {
        theme: "theme2",//theme1
        title:{
            text: "Basic Column Chart - CanvasJS"
        },
        animationEnabled: false,   // change to true
        data: [
            {
                // Change type to "bar", "area", "spline", "pie",etc.
                width:320,
                height:600,
                type: "column",
                dataPoints: [

                    { label: alphabet[0],  y: rate[0]  },
                    { label: alphabet[1],  y: rate[1]  },
                    { label: alphabet[2],  y: rate[2]  },
                    { label: alphabet[3],  y: rate[3]  },
                    { label: alphabet[4],  y: rate[4]  },
                    { label: alphabet[5],  y: rate[5]  },
                    { label: alphabet[6],  y: rate[6]  },
                    { label: alphabet[7],  y: rate[7]  },
                    { label: alphabet[8],  y: rate[8]  },
                    { label: alphabet[9],  y: rate[9]  },
                    { label: alphabet[10],  y: rate[10]  },
                    { label: alphabet[11],  y: rate[11]  },
                    { label: alphabet[12],  y: rate[12]  },
                    { label: alphabet[13],  y: rate[13]  },
                    { label: alphabet[14],  y: rate[14]  },
                    { label: alphabet[15],  y: rate[15]  },
                    { label: alphabet[16],  y: rate[16]  },
                    { label: alphabet[17],  y: rate[17]  },
                    { label: alphabet[18],  y: rate[18]  },
                    { label: alphabet[19],  y: rate[19]  },
                    { label: alphabet[20],  y: rate[20]  },
                    { label: alphabet[21],  y: rate[21]  },
                    { label: alphabet[22],  y: rate[22]  },
                    { label: alphabet[23],  y: rate[23]  },
                    { label: alphabet[24],  y: rate[24]  },
                    { label: alphabet[25],  y: rate[25]  }


                ]
            }
        ]
    });
    chart.render();

}
function JSONParser(data)
{
    var x=JSON.stringify(data);
    var r = $.parseJSON(x);
    return r;

}
$(document).ready(function()
    {
        $('#text').keydown(function(e)

            {

                if(e.keyCode==13)
                {
                    // alert("hey!")
                    $('#isencr').html("");

                    if(checkText($('#text').val()))
                    {
                        $('#isencr').html("<b style='color:red'>Вы ввели неверный текст! Пишите только латиницей!</b>");
                        return false;
                    }else {
                        $('#isencr').html("");
                    }

                    var array = $('#cryptform').serializeArray();
                    var json = {};

                    jQuery.each(array, function() {
                        json[this.name] = this.value || '';
                    });

                    $.ajax({
                        type: 'POST',
                        url: '../welcome/check',
                        data: json,
                        ContentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: getdata,
                        error:  function(xhr, str){
                            alert('Возникла ошибка: ' + xhr.responseCode);
                        },

                    });

                    function getdata(data)
                    {
                        //  alert("fuck");
                        // alert(data)

                        var r=JSONParser(data)
                        if(r.encr) {

                            $('#isencr').html("<p>Скорее всего Вы ввели шифр. Вероятное смещение "+ r.rot +"</p>");
                        }
                        writechart(r.ratearr, r.alphabet);
                    };
                }
            }
        )

    }
)



function send(type)
{
    var crypt=type;
    var array = $('#cryptform').serializeArray();
    var json = {};
     if(/\D/.test($('#rot').val()) || $('#rot').val()=="")
    {
        $('#isencr').html("<b style='color:red'>В поле смещения нужно указывать только цифры!</b>");
        return false;

    }else {
         $('#isencr').html("");
    }
    if(checkText($('#text').val()))
    {
        $('#isencr').html("<b style='color:red'>Вы ввели неверный текст! Пишите только латиницей!</b>");
        return false;
    }else {
        $('#isencr').html("");
    }
    jQuery.each(array, function() {
        json[this.name] = this.value || '';
    });
    json['crypt']=crypt;


    $.ajax({
        type: 'POST',
        url: '../welcome/crypt',
        data: json,
        ContentType: "application/json; charset=utf-8",
        dataType: "json",
        success: getdata,
        error:  function(xhr, str){
            alert('Возникла ошибка: ' + xhr.responseCode);
        },

    });

    function getdata(data)
    {
        //  alert("fuck");
        // alert(data)
        $('#isencr').html("");
        var r=JSONParser(data)


        if(r) {
            $('#result').val(r.crypt);
        }
        if(r.encr) {

            $('#isencr').html("<p>Скорее всего Вы ввели шифр. Вероятное смещение "+ r.rot +"</p>");
        }
        writechart(r.ratearr, r.alphabet);
    };

};
