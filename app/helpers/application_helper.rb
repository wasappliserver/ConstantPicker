module ApplicationHelper

  @define_tab = []
  @define_color = []
  @define_number = []

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
          #isColor @define_tab[i], id
          isNumber @define_tab[i], id
        end
      end
    else
      puts "NO SUCH FILE OR DIRECTORY: " +path
    end
  end

  module_function :readHeader

  def isColor str, id
    #isColor?
    puts str
    if str =~ /UIColor/
      @define_color << str
      tab = str.scan(/\S+\s(\S*)\s\[(\S*)\s(.*):([\w]*)\]/m)
      #array of array, access the content from the second table index
      #verification duplicate
      tp Couleur.all
      query = Couleur.where(:title => tab[0][0])
      puts query.to_s + "QUERY \n \n "
      if query.count != 0
        puts 'this entry is already in the database'
        return false
      else
        puts "CREATION D\'UNE LIGNE DANS COULEUR"
        Couleur.create!(title: tab[0][0], coul_type: tab[0][1], value_coul: tab[0][3], app_id: id)
      end
    else
      #puts 'not ok'
      return false

    end
  end

  module_function :isColor

  def isNumber str, id
    #isColor?
    #puts  "STRING" + str
    if str =~ /(\S*)\s(\S*)\s(\d+)/
      @define_number << str
      tab = str.scan(/(\S*)\s(\S*)\s(\d+)/m)
      #array of array, access the content from the second table index
      #verification duplicate
      puts "tab 0 :" + tab[0][0].to_s + " :::: " + tab[0][1]+ " :::: " + tab[0][2]
      query = Number.where(:title => tab[0][1])
      #puts query.to_s + "QUERY \n \n "
      if query.count != 0
        puts 'this entry is already in the database'
        return false
      else
        puts "CREATION D\'UNE LIGNE DANS NUMBER"
        Number.create!(title: tab[0][1], value: tab[0][2], app_id: id)
        #end
      end
    end
  end

  module_function :isNumber
end

