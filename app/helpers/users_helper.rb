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

end
