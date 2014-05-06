module UsersHelper

  def isAdmin(_id)
    tp(User.all)
    if (_id!= nil)
      user = User.find(_id)
      if (user.admin==true)
        return true
      else
        return false
      end
    end
  end
  module_function :isAdmin

  def allApps user
    app_string = String.new
    for i in 0..user.app_ids.length
      app_string.concat(user.app_ids[i].to_s)
    end
    return app_string
  end
  module_function :allApps


end
