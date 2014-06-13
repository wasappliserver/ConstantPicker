module ThemeColorsHelper


  def updateTheme app_id
    #find all colors for this app, then compare to the ThemeColor DB, and add the new one if it not exists in Theme
    couleurs = Couleur.where("app_id = '#{app_id}'")
    themes = ThemeColor.where("app_id = '#{app_id}'")
    puts themes[0].to_s + " fdsf"


    #for each color
    couleurs.each do |couleur|
      #puts " THEME||COLOR   #{couleur.value_coul}"
      flag = 0
      #loop on theme, if a theme match a color, we dont need to insert it
      themes.each do |theme|
        puts " THEME||COLOR  == #{theme.color} || #{couleur.value_coul}"
        if (theme.color.downcase == couleur.value_coul.downcase)
          flag = 1
          break
        end
      end
      #after the loop if no matches
      if (flag == 0)
        ThemeColor.create!(:color => couleur.value_coul, :app_id => app_id)
      end
    end
  end

  module_function :updateTheme
end
