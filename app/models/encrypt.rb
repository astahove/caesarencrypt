class Encrypts
  #############################################
  # Класс, который отвечает за шифрования,    #
  # дешифрование и частотный анализ символов  #
  # в тексте                                  #
  #############################################
  $alphabet=('a'..'z').to_a
  #инициализация глобальной переменной - алфавитного массива
  $result_mass=Array.new()
  $rate=Array.new()
  #инициализация результирующего массива и частотного массива

  #############################################
  # Метод, который принимает текст и смещение,#
  # и шифрует текст                           @
  #############################################
  def Encrypt(text,rot)
    $result_mass.clear();
    #очистка массива
    if(text!=nil && rot!=nil)
      # если переданные значения существуют
      text_mass=text.split(//)
      #разбиваем текст посимвольно и записываем символы в объявленный массив
      text_mass.each {
      |symbol|
        #создаем цикл перебора массива посимвольно
        if(!$alphabet.include?symbol)
          #если символа нет в алфавитном массиве
          if($alphabet.include?symbol.to_s.downcase)
            # либо если этот символ в верхнем регистре, но входит в алфавит
            code=symbol.to_s.ord()
            #получаем числовой код символа
            numb=code+rot
            #получаем код символа со смещением
            encr_symb = numb.chr.to_s
            #получаем символ, соответствующий этому коду
            if $alphabet.include?(encr_symb.to_s.downcase)
              $result_mass.push(encr_symb.to_s)
              #если получившийся символ есть в алфавите, добавляем его в результирующий массив
            else
              symbol_code=(symbol.to_s.ord+rot)-$alphabet.size
              encr_symb = symbol_code.chr.to_s
              #если же нет, вычитаем размер массива(количество букв в алфавите)из кода получившегося символа
              #и получаем символ, соответствующий этому коду
              if($alphabet.include?encr_symb.to_s.downcase)
                $result_mass.push(encr_symb)
                #если он есть в алфавите, добавляем его в массив
              end
            end
          else
            # если же такого символа нет в алфавите, но при этом текст прошел проверку на отсутствие кириллицы
            # (см. test.js), то это либо знаки препинания, либо спецю символы, кавычки, цифры, etc. Их не шифруют, а
            # хранят в исходном виде
            $result_mass.push(symbol)
          end

        else
          #если же символ в алфавите есть
          code=symbol.to_s.ord()
          numb=code+rot
          encr_symb = numb.chr.to_s
          if $alphabet.include?(encr_symb.to_s)
            $result_mass.push(encr_symb.to_s)
          else
            symbol_code=(symbol.to_s.ord+rot)-$alphabet.size
            encr_symb = symbol_code.chr.to_s
            if($alphabet.include?encr_symb)
              $result_mass.push(encr_symb)
            end
          end
          #делаем то же самое, что делали с буквами в верхнем регистре
        end

      }
          @words=''
          $result_mass.each { |elem| @words+=elem  }
          return @words
          #формируем результирующую строку из массива и возвращаем ее
    else return false
      #если же переданных значений нет, возвращаем false

    end


  end
  ################################################
  # Метод, получающий введенный шифр и смещение, #
  # используемое при зашифровке, расшифровывающий#
  # шифр и возвращающий результат                #
  ################################################
   def Decrypt(text,rot)
    $result_mass.clear()
    #на всякий случай очищаем массив
    if(text!=nil && rot!=nil)
      text_mass=text.split(//)
      text_mass.each {
          |symbol|
        # если текст и смещение существуют, разбиваем текст посимвольно, сохраняем его в массив и перебираем элементы
        # массива в цикде
        if(!$alphabet.include?symbol)
          #если символ не входит в алфавит
          if($alphabet.include?symbol.to_s.downcase)
            # Но если входит, то в верхнем регистре
            code=symbol.to_s.ord()
            numb=code-rot
            encr_symb = numb.chr.to_s
            #шифруем его
            if $alphabet.include?(encr_symb.to_s.downcase)


              $result_mass.push(encr_symb.to_s)
              #проверяем, содержит ли алфавит полученный символ, если да, то добавляем его в результирующий массив
            else

              symbol_code=$alphabet.size+ (code-rot)
              encr_symb = symbol_code.chr.to_s
              $result_mass.push(encr_symb.to_s)
              # если же нет, вычитаем разницу между кодом и смещением из алфавитного массива и получаем символ,
              # соответствующий этому коду
            end
          else
            # если же такого символа нет в алфавите, но при этом текст прошел проверку на отсутствие кириллицы
            # (см. test.js), то это либо знаки препинания, либо спецю символы, кавычки, цифры, etc. Их не шифруют, а
            # хранят в исходном виде
            $result_mass.push(symbol)
          end
        else
          #а если символ есть в алфавит, то
          code=symbol.to_s.ord()
          numb=code-rot
          encr_symb = numb.chr.to_s
          if $alphabet.include?(encr_symb)


            $result_mass.push(encr_symb.to_s)
          else

            symbol_code=$alphabet.size+ (code-rot)
            encr_symb = symbol_code.chr.to_s
            $result_mass.push(encr_symb.to_s)
            #делаем то же самое, что делали с буквами в верхнем регистре
          end

          end


      }

   end


    @words=''
    $result_mass.each { |elem| @words+=elem  }
    return @words
  #из массива собираем строку и возвращаем ее
   end

  #####################################################################
  # Метод, определяющий, является ли принимаемый текст шифром и       #
  # возвращающий массив. Проверка на шифр основана на частотном       #
  # анализе символов                                                  #
  #####################################################################
  def DetectEncr(encrypted)
    @array_symbolid = Array.new(26)
    for i in  0...$alphabet.size
         @array_symbolid[i]=0

    end
    #объявляем и инициализируем новый массив
    @encr_mass=encrypted.split(//)
    @encr_mass.each { |letter|
      #разбиваем полученный текст посимвольно и перебираем массив  символов
      for i in  1...$alphabet.size
        if($alphabet[i]==letter)
          @array_symbolid[i]+=1
          # Если такой символ есть в алфавите, то мы увеличиваем значение элемента массива, индекс которого равен
          # индексу элемента в массива алфавита
        end
      end
    }
    @array_symbolid.sort {|x,y| y.to_i <=> x.to_i }
    $rate=@array_symbolid
    return @array_symbolid
    #присваиваем глобальной переменной $rate значение массива @array_symbolid  \и возвращаем этот массив
  end
  end
