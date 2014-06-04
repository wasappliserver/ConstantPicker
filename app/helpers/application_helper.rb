require_relative "pre_build.rb"

module ApplicationHelper

  @define_tab = []

  def readHeader id
    @define_tab = nil
    @define_tab = []
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
            @define_tab << text[i].to_s
          end #endif
        end #endfor

        #on lance la boucle des #define
        for i in 0..@define_tab.count-1
          isColor @define_tab[i], id
          isNumber @define_tab[i], id
          isString @define_tab[i], id
        end
      end
    else
      puts "NO SUCH FILE OR DIRECTORY: " +path
    end
  end

  module_function :readHeader

  def isColor str, id
    #isColor?
    if str =~ /UIColor/
      tab = str.scan(/\S+\s(\S*)\s\[(\S*)\s(.*):([\w]*)\]/m)
      #array of array, access the content from the second table index
      #verification duplicate
      #tp Couleur.all
      query = Couleur.where(:title => tab[0][0], :app_id => id)
      if query.count != 0
        #puts 'this entry is already in the database'
        return false
      else
        Couleur.create!(title: tab[0][0], coul_type: tab[0][1], value_coul: tab[0][3], app_id: id)
      end

    elsif (str =~ /(#\S+)\s(\S+)\s(\dx\S*)/)
      tab = str.scan(/(#\S+)\s(\S+)\s(\dx\S*)/)
      #array of array, access the content from the second table index
      #verification duplicate
      #tp Couleur.all
      query = Couleur.where(:title => tab[0][1], :app_id => id)
      if query.count != 0
        #puts 'this entry is already in the database'
        return false
      else
        Couleur.create!(title: tab[0][1], coul_type: nil, value_coul: tab[0][2], app_id: id)
      end

    else
      return false
    end
  end

  module_function :isColor

  def isNumber str, id
    #isColor?
    if str =~ /(#\S+)\s(\S+)\s(\d*)\n/
      tab = str.scan(/(#\S+)\s(\S+)\s(\d*)\n/m)
      #array of array, access the content from the second table index
      #verification duplicate
      query = Number.where(:title => tab[0][1], :app_id => id)
      if query.count != 0
        #puts 'this entry is already in the database'
        return false
      else
        Number.create!(title: tab[0][1], value: tab[0][2], app_id: id)
        #end
      end
    end
  end

  module_function :isNumber

  def isString str, id
    #isColor?
    if str =~ /(\S*)\s(\S*)\s*(@"\S*")/
      tab = str.scan(/(\S*)\s(\S*)\s*(@"\S*")/m)
      #array of array, access the content from the second table index
      #verification duplicate
      query = AtString.where(:title => tab[0][1], :app_id => id)
      if query.count != 0
        #puts 'this entry is already in the database'
        return false
      else
        tmp = tab[0][2].scan(/[^@"].+[^"]/)
        tab[0][2]= tmp[0]
        AtString.create!(title: tab[0][1], value: tab[0][2], app_id: id)
        #end
      end
    end
  end

  module_function :isString

  def getStrings app_name
    init

#gets all the values from the DB for numbers colors and strings, stores them in array for each
#db = SQLite3::Database.new("/Users/wasappliserver/RubymineProjects/ConstantPicker/db/development.sqlite3")
    app = App.find_by name: app_name
#puts app.to_s + "APP"
# = db.exe cute("SELECT name FROM apps WHERE name = ?", name)
    @rows_number = Number.where("app_id = '#{app.id}'")
    @rows_string = AtString.where("app_id = '#{app.id}'")
    @rows_color = Couleur.where("app_id = '#{app.id}'")

    #@rows_number = db.execute("SELECT title, value FROM numbers WHERE app_id = ?", app.id)
    #@rows_string = db.execute("SELECT title, value FROM at_strings  WHERE app_id = ?", app.id)
    #@rows_color = db.execute("SELECT title, value_coul, coul_type FROM couleurs  WHERE app_id = ?", app.id)

    #log display

    #display_rows @rows_number
    #display_rows @rows_string
    #display_rows @rows_color

    path="/Users/wasappliserver/.jenkins/jobs/#{app.name}/workspace/#{app.name}/Constants.h"

#If the file exist
    if (File.exist?(path))
#open it
      File.open(path, 'r+') do |file|
#read lines, fill the tabs
        @lines_init = file.readlines
        @lines_final = @lines_init.dup


        @rows_number.each do |row|


          if (compareLinesN(row)== false)
            #ADD THE ROWWWW
            #puts "ADD NEW ROW NUMBER"
            addRowNumber row
          end
        end

        @rows_color.each do |row|
          puts "ROW ==>" + row.title + row.value_coul+ row.coul_type.to_s

          if (compareLinesC(row)== false)
            #ADD THE ROWWWW
            #puts "ADD NEW ROW COLOR"
            addRowColor row
          end
        end

        @rows_string.each do |row|
          if (compareLinesS(row)== false)
            #ADD THE ROWWWW
            #puts "ADD NEW ROW String"
            addRowString row
          end
        end

      end

    else
      puts "FILE DOES NOT EXIST in #{path}"

    end

    return @lines_final
  end

  module_function :getStrings
end

