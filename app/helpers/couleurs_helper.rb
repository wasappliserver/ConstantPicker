module CouleursHelper

  def value_coul_to_minicolor value_coul
    new_value = value_coul.gsub("0x", "#")
    #Rails.logger.info new_value
    return new_value
  end

  module_function :value_coul_to_minicolor

end
