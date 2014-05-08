module CouleursHelper

  def value_coul_to_minicolor value_coul
    #if its not a new color (because new color do not need to be converted, its empty)
    if (value_coul!= nil)
      new_value = value_coul.gsub("0x", "#")
      #Rails.logger.info new_value
      return new_value
    end
    return nil
  end

  module_function :value_coul_to_minicolor

end
