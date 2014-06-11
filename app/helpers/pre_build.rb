def init
  @rows_color= Array.new
  @rows_string = Array.new
  @rows_number = Array.new
  @lines_final = nil
end

#################################################################

########## N U M B E R S ##############
def compareLinesN row

  for i in 0..@lines_init.count-1
    #puts "LIGNE REGARDEE =>" + @lines_init[i].to_s
    if (@lines_init[i]=~ /(#\S+)\s(\S+)\s(\d*)\n/)
      if (compareOneLineN(i, row))
        return true
      end
    end
  end
  return false
end


def compareOneLineN i, row
  data = @lines_init[i].scan(/(#\S+)\s(\S+)\s(\d*)\n/)
  #puts "NUMBER data|||row ===>" + data[0][1].to_s + "|||" + row[0].to_s

  if (data[0][1]==row.title)
    #puts "MATCH " #NUMBER data|||row ===>" + data[0][1].to_s + "|||" +row[0].to_s
    #puts "LINE BEFORE" + @lines_final[i].to_s
    @lines_final[i] = "#define #{row.title} #{row.value}\n"
    #puts "LINE AFTER" + @lines_final[i].to_s
    #puts
    return true
  end
  return false
end

##############################################################################

########## S T R I N G S ##############
def compareLinesS row

  for i in 0..@lines_init.count-1
    #puts "LIGNE REGARDEE =>" + @lines_init[i].to_s
    if (@lines_init[i]=~ /(\S*)\s(\S*)\s*(@"\S*")/m)
      if (compareOneLineS(i, row))
        return true
      end
    end
  end
  return false
end

def compareOneLineS i, row
  data = @lines_init[i].scan(/(\S*)\s(\S*)\s*(@"\S*")/)
  #puts "String data|||row ===>" + data[0][1].to_s + "|||" + row[0].to_s

  if (data[0][1]==row.title)
    # puts "MATCH " #NUMBER data|||row ===>" + data[0][1].to_s + "|||" +row[0].to_s
    #puts "LINE BEFORE" + @lines_final[i].to_s
    @lines_final[i] = "#define #{row.title} @\"#{row.value}\"\n"
    #puts "LINE AFTER" + @lines_final[i].to_s
    #puts
    return true
  end
  return false
end

##############################################################################

########## C O L O R S ##############
def compareLinesC row

  for i in 0..@lines_init.count-1
    #puts "LIGNE REGARDEE =>" + @lines_init[i].to_s
    if (@lines_init[i]=~ /\S+\s(\S*)\s\[(\S*)\s(.*):([\w]*)\]/m)
      if (compareOneLineC(i, row, 1))
        return true
      end
    elsif (@lines_init[i]=~ /(#\S+)\s(\S+)\s(\dx\S*)/)
      if (compareOneLineC(i, row, 2))
        return true
      end
    end
  end
  return false
end

def compareOneLineC i, row, patt_type
  if (patt_type == 1)
    data = @lines_init[i].scan(/\S+\s(\S*)\s\[(\S*)\s(.*):([\w]*)\]/)
    #puts "type 1 Color data|||row ===>" + data[0][0].to_s + "|||" + row.coul_type.to_s

    if (data[0][0]==row.title)
      # puts "MATCH " #NUMBER data|||row ===>" + data[0][1].to_s + "|||" +row[0].to_s
      #puts "LINE BEFORE" + @lines_final[i].to_s
      @lines_final[i] = "#define #{row.title} [UIColor colorWithHexa:#{row.value_coul}]\n"
      #puts "LINE AFTER" + @lines_final[i].to_s
      #puts
      return true
    end
  elsif (patt_type ==2)
    data = @lines_init[i].scan(/(#\S+)\s(\S+)\s(\dx\S*)/)
    #puts "type 2 Color data|||row ===>" + data[0][1].to_s + "|||" + row.coul_type.to_s

    if (data[0][1]==row.title)
      # puts "MATCH " #NUMBER data|||row ===>" + data[0][1].to_s + "|||" +row[0].to_s
      # puts "LINE BEFORE" + @lines_final[i].to_s
      @lines_final[i] = "#define #{row.title} #{row.value_coul}\n"
      # puts "LINE AFTER" + @lines_final[i].to_s
      #puts
      return true
    end
  end
  return false
end

####################################

########## L O C A LI Z A T I O N S ##############
def compareLinesL(row, lang)

  #puts "ROW ==> #{row[0]}"
  for i in 0..@lines_tab["#{lang}"].size-1
    #puts "row ||| line ==> #{row.key_loc} ||| #{@lines_tab["#{lang}"][i][0]}"
    if (@lines_tab["#{lang}"][i][0] == row.key_loc)
      return true
    end
  end
  return false

end

##############################################################################

########## A D D  R O W  L O C A LI Z A T I O N ##############
def addRowLocalizable row, lang

  #puts " ADD ROOOWWW"
  @lines_tab["#{lang}"] << "\"#{row.key_loc}\" = \"#{row.value}\"\n"

end

######################################

########## A D D  R O W  N U M B E R ##############
def addRowNumber row

  #on doit atteindre le #endif et ecrire avant
  for i in 0..@lines_init.count-1
    if (@lines_final[i] =~ /#endif/)
      @lines_final.insert(i-1, "#define #{row.title} #{row.value}\n")
      # puts "line i-1 after" + @lines_final[i-1].to_s
    end
  end
end

######################################

########## A D D  R O W  C O L O R ##############
def addRowColor row

  #on doit atteindre le #endif et ecrire avant
  for i in 0..@lines_final.count-1
    if (@lines_final[i] =~ /#endif/)
      @lines_final.insert(i-1, "#define #{row.title} [#{row.coul_type} colorWithHexa:#{row.value_coul}]\n")
      # puts "line i-1 after" + @lines_final[i-1].to_s
    end
  end
end

######################################

########## A D D  R O W  S T R I N G ##############
def addRowString row

  #on doit atteindre le #endif et ecrire avant
  for i in 0..@lines_final.count-1
    if (@lines_final[i] =~ /#endif/)
      @lines_final.insert(i-1, "#define #{row.title} @\"#{row.value}\"\n")
      # puts "line i-1 after" + @lines_final[i-1].to_s
    end
  end
end
######################################