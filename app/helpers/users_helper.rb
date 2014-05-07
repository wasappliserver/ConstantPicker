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

    for i in 0..user.app_ids.length-1
      id= user.app_ids[i]
      app = App.find(id)
      app_string.concat(app.name)
      app_string.concat(" | ")
    end
    # puts app_string.to_s
    return app_string
  end

  module_function :allApps

end
