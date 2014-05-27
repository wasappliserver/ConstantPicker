require 'find'
module LocalizablesHelper

  def getLang id
    app_name = App.find(id).name
    @path ="/Users/wasappliserver/.jenkins/jobs/#{app_name}/workspace/#{app_name}"
    @lang_tab = Array.new

    Find.find(@path) do |path|
      if (path =~ /.*\.lproj$/)
        @lang_tab << path
      end
    end
    puts "TABLEAU DES LANGUES "+ @lang_tab.to_s

    @lang_tab.each do |lang|
      el = lang[/(\w+).lproj$/]
      el2 = el[/^(\w+)/]
      puts el2.to_s
      lang = el2
      # get the list of the localize
      lines_tab = getLocalizables lang
    end
  end

  module_function :getLang

  def getLocalizables lang
    line_tab = Array.new

    path_loc = "#{@path}/#{lang}.lproj/Localizable.strings"
    #If the file exist
    if (File.exist?(path_loc))
      #open it
      File.open(path_loc, 'r+') do |file|
        #read files, stores it in an table
        @lines = file.read

        lines_tab = @lines.scan(/\s*\"(.*)\"\s*=\s*\"([\S\s]*?)\"\s*/)

        return lines_tab
      end
    end
  end

  module_function :getLocalizables

end
