require 'find'
module LocalizablesHelper

  def getLang id
    @app_id = id
    app_name = App.find(id).name
    @path ="/Users/wasappliserver/.jenkins/jobs/#{app_name}/workspace/#{app_name}"
    @lang_tab = Array.new

    if (File.exist?(@path))
      Find.find(@path) do |path|
        if (path =~ /.*\.lproj$/)
          @lang_tab << path
        end
      end
    end
    puts "TABLEAU DES LANGUES "+ @lang_tab.to_s

    @lang_tab.each do |lang|
      el = lang[/(\w+).lproj$/]
      el2 = el[/^(\w+)/]
      lang = el2

      #main function which writes the new key/value string
      addLangs lang
    end
  end

  module_function :getLang

  def addLangs lang

    # get the list of the localize
    lines_tab = getLocalizables lang
    #puts "liens " + lines_tab.to_s

    if (lines_tab == "No File Found")
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
    puts "LANG IS ===>" + lang.to_s
    line_tab = Array.new

    path_loc = "#{@path}/#{lang}.lproj/Localizable.strings"
    #If the file exist
    if (File.exist?(path_loc))
      #open it
      File.open(path_loc, 'r+') do |file|
        #read files, stores it in an table
        @lines = file.read

        lines_tab = @lines.scan(/\s*\"(.*)\"\s*=\s*\"([\S\s]*?)\"\s*/)
        #puts lines_tab
        return lines_tab
      end
    else
      puts "NO FILE FOUND FOR LANG #{lang} AT #{path_loc}"
      return "No File Found"
    end
  end

  module_function :getLocalizables

end
