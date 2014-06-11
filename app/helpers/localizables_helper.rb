require 'find'
require_relative 'pre_build'

module LocalizablesHelper

  def getLang id
    @app_id = id
    app_name = App.find(id).name
    @path ="/Users/wasappliserver/.jenkins/jobs/#{app_name}/workspace/#{app_name}"
    @lang_tab = Array.new

    @lines_tab = Hash.new

    if (File.exist?(@path))
      Find.find(@path) do |path|
        if (path =~ /.*\.lproj$/)
          @lang_tab << path
        end
      end
    end

    puts "TABLEAU DES LANGUES "+ @lang_tab.to_s

    #for each lang
    for i in 0..@lang_tab.length-1
      el = @lang_tab[i][/(\w+).lproj$/]
      el2 = el[/^(\w+)/]
      lang = el2
      puts "LANG IS ===>" + lang.to_s
      # first we add the lang in th DB
      addLangs lang
      @lines_tab["#{lang}"] = Array.new

      #get the list of the variables in the file
      @lines_tab["#{lang}"] = getLocalizables lang
      #puts "LANNNNG " + @lines_tab["#{lang}"].to_s
      if (@lines_tab["#{lang}"] == "No File Found")
        puts "skipped no localizable.strings found"
        @lines_tab["#{lang}"]= nil
      else
        @lines_tab["#{lang}"].each do |line|
          #if we already have the row in the DB
          puts line[0]
          query = Localizable.where("app_id = '#{@app_id}' and key_loc = '#{line[0]}' and lang = '#{lang}'")
          if query.count != 0
            #puts 'this entry is already in the database'
          else
            Localizable.create!(key_loc: line[0], value: line[1], lang: lang, app_id: @app_id)
          end
        end

      end
    end
  end

  module_function :getLang

  def addLangs lang

    # get the list of the localize
    lines_tab = getLocalizables lang
    #puts "liens " + lines_tab.to_s

    if (lines_tab == "No File Found" || lines_tab == 0)
      puts "skipped no localizable.strings found"
    else
      lines_tab.each do |line|
        query = Localizable.where(:key_loc => line[0], :app_id => @app_id, :lang => lang)
        if query.count != 0
          #puts 'this entry is already in the database'
          break
        else
          Localizable.create!(:key_loc => line[0], :value => line[1], :app_id => @app_id, :lang => lang)
        end
      end
    end
  end

  module_function :addLangs

  def getLocalizables lang
    line_tab = Array.new

    path_loc = "#{@path}/#{lang}.lproj/Localizable.strings"
    #If the file exist
    if (File.exist?(path_loc))
      #open it
      File.open(path_loc, 'r+') do |file|
        #read files, stores it in an table
        @lines = file.read

        lines_tab = @lines.scan(/\s*\"(.*)\"\s*=\s*\"([\S\s]*?)\"\s*;/)
        #puts lines_tab
        return lines_tab
      end
    else
      puts "NO FILE FOUND FOR LANG #{lang} AT #{path_loc}"
      return "No File Found"
    end
  end

  module_function :getLocalizables

  def writeLocs app_name

    #gets all the values from the DB for localization, stores them in array
    app = App.find_by name: app_name

    @path ="/Users/wasappliserver/.jenkins/jobs/#{app_name}/workspace/#{app_name}"
    @lang_tab = Array.new

    @lines_tab = Hash.new

    if (File.exist?(@path))
      Find.find(@path) do |path|
        if (path =~ /.*\.lproj$/)
          @lang_tab << path
        end
      end
    end

    for i in 0..@lang_tab.length-1
      el = @lang_tab[i][/(\w+).lproj$/]
      el2 = el[/^(\w+)/]
      lang = el2
      puts "LANG IS ===>" + lang.to_s
      @lines_tab["#{lang}"] = Array.new

      #get the list of the variables in the file
      @lines_tab["#{lang}"] = getLocalizables lang
      puts "LANNNNG " + @lines_tab["#{lang}"].to_s
      if (@lines_tab["#{lang}"] == "No File Found")
        puts "skipped no localizable.strings found"
        @lines_tab["#{lang}"]= nil
      else
        #update the DB
        @row_localizable = Localizable.where("app_id = '#{app.id}' and lang = '#{lang}'")
        @row_localizable.each do |row|

          if (compareLinesL(row, lang) == false)
            addRowLocalizable row, lang
          end
        end

      end
    end

    return @lines_tab

  end

  module_function :writeLocs

  def get_all_langs app_name
    path ="/Users/wasappliserver/.jenkins/jobs/#{app_name}/workspace/#{app_name}"
    lang_tab = Array.new

    if (File.exist?(path))
      Find.find(path) do |p|
        if (p =~ /.*\.lproj$/)
          el = p[/(\w+).lproj$/]
          el2 =el[/^(\w+)/]
          lang_tab << el2
        end
      end
    end

    return lang_tab
  end

  module_function :get_all_langs

  def findNotMissing localizable

    puts "for #{localizable.lang}BOOLEAN +> " + localizable.missing.to_s
    #search if another row in the DB has the same key_loc
    loc_row = Localizable.where("key_loc = '#{localizable.key_loc}'")
    #if yes, we check if there are as many lang as key_loc,
    count_rows = loc_row.length
    puts "nombres de rows #{count_rows}"

    if (count_rows > 0)
      app = App.find(localizable.app_id)
      lang_tab = get_all_langs app.name

      puts "nombres de langues #{lang_tab.size}"

      # if yes that means value is translated into all languages
      if (lang_tab.length == count_rows)
        localizable.missing = false
        puts "BOOLEAN IS NOW"+localizable.missing.to_s
        localizable.save
      end
    end

  end

  module_function :findNotMissing
end
