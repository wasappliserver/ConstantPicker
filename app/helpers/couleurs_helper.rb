module CouleursHelper

  @define_tab = []
  @define_color = []

  def readHeader id
    app_name = App.find(id).name
    text = Array.new
    path ="/Users/wasappliserver/.jenkins/jobs/#{app_name}/workspace/#{app_name}/Constants.h"

    if File.exist?(path)
      File.open(path) do |file|
        #recupere tout le texte
        text = file.readlines

        #on regarde chaque ligne
        for i in 0..text.count-1
          #si la ligne contient le tag "#define"
          if (text[i][/#define/])
            #alors on recupere tout dans un tableau"
            #puts text[i]
            @define_tab << text[i].to_s
          end #endif
        end #endfor

        #on lance la boucle des #define
        for i in 0..@define_tab.count-1
          isColor @define_tab[i]
        end
      end
    else
      @couleurs=nil
      puts "NO SUCH FILE OR DIRECTORY: " +path
    end
  end

  module_function :readHeader

  def isColor str
    #isColor?
    puts str
    if str =~ /UIColor/
      @define_color << str
      tab = str.scan(/\S+\s(\S*)\s\[(\S*)\s(.*):([\w]*)\]/m)
      #array of array, access the content from the second table index
      puts "ALOOOOOOOOOO \n \n \n ALOOOOO"
      #verification duplicate
      # tp Couleur.all
      query = Couleur.where(:title => tab[0][0])
      puts query.to_s + "QUERY \n \n "
      if query.count != 0
        puts 'this entry is already in the database'
        return false
      else
        puts "CREATION D\'UNE LIGNE DANS COULEUR"
        Couleur.create!(title: tab[0][0], coul_type: tab[0][1], value_coul: tab[0][3])
      end
    else
      #puts 'not ok'
      return false

    end
  end

  module_function :isColor

  def value_coul_to_minicolor value_coul
    new_value = value_coul.gsub("0x", "#")
    #Rails.logger.info new_value
    return new_value
  end

  module_function :value_coul_to_minicolor

end
